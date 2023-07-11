function [found z3 i3] = gradAlg(x1o, x2o, x1f, x2f)

% Step 1: Estimate a set of control variable histories, u(t)
found = 0;
amplitude = 50;
resolution = 1;
lenStim = 30;
totalLength = 100;

W = 2;
epsilon = 0.5;

iterations = 1000;

zt = linspace(0, lenStim, lenStim * resolution + 1);
z = 2 * rand(1, lenStim * resolution + 1) * amplitude - amplitude;

i3 = 0;

finalSize = 10000;

iTemp = zeros(iterations, 1);
dist = zeros(iterations, 1);
ap = zeros(iterations, 1);

lengthStorage = zeros(finalSize, iterations);
   
zt3 = linspace(0, totalLength, finalSize);

for counter = 1:iterations
%    counter
    % Step 2: Integrate system equations forward with specified
    % initial conditions x(t0) and control variable histories.
    % Record x, u, psi(x(tf))
%    x1o = 0.95836586; x2o = -0.322958325;
%    x1f = 0.891; x2f = -0.4063;
%    x1f = -1.667; x2f = 0.4908;    

    z2 = [z 0 0];
    zt2 = [zt lenStim + 0.000001 totalLength]; 

    [Tx X] = ode45(@(t, y) fhn(t, y, zt2, z2), [0 100], [x1o x2o]);
    X30 = interp1(Tx, X, 30);
    psi = (X30 - [x1f x2f])';
    lengthStorage(:, counter) = interp1(zt2, z2, zt3);
   
    figure (1);
    subplot(2, 2, 1); plot(zt, z); xlabel('Time'); ylabel('Stimulus Current');
    subplot(2, 2, 2); plot(X(:, 1), X(:, 2)); hold on; plot(X30(1), X30(2), 'r.'); plot(x1f, x2f, 'g.'); hold off; xlabel('X1'); ylabel('X2');
    subplot(2, 2, 3); plot(iTemp); xlabel('Iteration'); ylabel('L2-Norm');
    subplot(2, 2, 4); plot(dist); xlabel('Iteration'); ylabel('Error in Terminal Condition'); 

    % Step 3: Determine n-vector p(t), and matrix R(t) by backward integration
    % of the influence equations using x(tf) obtained in step 2 to determine
    % boundary conditions
    [Tp p] = ode45(@(t, y) pInfluence(t, y, Tx, X), [lenStim 0], [0 0]);
    [TR R] = ode45(@(t, y) RInfluence(t, y, Tx, X), [lenStim 0], [1 0 0 1]);
    
    % consolidating all the time stamps
    t1 = union(TR, zt);
    t  = union(Tp, t1);
    
    iz = interp1(zt, z, t);
    ip = interp1(Tp, p, t);
    iR = interp1(TR, R, t);
    
    % Step 4: Compute Ipp, Ijp, Ijj integrals
    Ipp = zeros(2, 2);
    Ipp(1, 1) = (1 / W) * trapz(t, iR(:, 1) .^ 2);
    Ipp(1, 2) = (1 / W) * trapz(t, iR(:, 1) .* iR(:, 2));
    Ipp(2, 1) = (1 / W) * trapz(t, iR(:, 1) .* iR(:, 2));
    Ipp(2, 2) = (1 / W) * trapz(t, iR(:, 2) .^ 2);
    
    Ijp = zeros(1, 2);
    Ijp(1, 1) = (1 / W) * trapz(t, (ip(:, 1) + 2 * iz) .* iR(:, 1));
    Ijp(1, 2) = (1 / W) * trapz(t, (ip(:, 1) + 2 * iz) .* iR(:, 2));
    
    Ijj = (1 / W) * trapz(t, (ip(:, 1) + 2 * iz) .* (ip(:, 1) + 2 * iz));
    
    % Step 5: Choose values of dPsi, then determine v
    dPsi = -epsilon * psi;
    v = -inv(Ipp) * (dPsi + Ijp');
    
    iTemp(counter) = Ijj - Ijp / Ipp * Ijp';
    iTemp2(counter) = trapz(zt2, z2 .^ 2);
    dist(counter) = sqrt(psi(1) ^ 2 + psi(2) ^ 2);
    ap(counter) = max(X(ceil(0.80*length(X)):length(X), 1) - min(X(ceil(0.80*length(X)):length(X), 1)));

    % Step 6: Improve estimate of z(t)
    dZ = -(1 / W) * (2 * iz + ip(:, 1) + iR(:, 1) * v(1) + iR(:, 2) * v(2));
    z = iz + dZ;
    % zt = t;   
    
    zt = linspace(0, 30, 1001);
    za = interp1(t, z, zt);
    z = za;
%    [counter iTemp(counter) * 1000 dist(counter)]
end

index = find(ap > 3.5);
iTemp2 = iTemp(index);
lnStorage = lengthStorage(:, index);
[x i] = min(iTemp2);
z3 = lnStorage(:, i);