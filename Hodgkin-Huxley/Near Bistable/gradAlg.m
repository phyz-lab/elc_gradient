% Step 1: Estimate a set of control variable histories, u(t)
amplitude = 4;
tf = 100;
totalLength = 200;

W = 10;
epsilon = .5;

iterations = 1000;

z = amplitude * rand(tf * 10 + 1, 1) - amplitude / 2;

z3 = 0;
i3 = 0;

finalSize = totalLength * 10 + 1;

iTemp = zeros(iterations, 1);
iTemp2 = zeros(iterations, 1);
dist = zeros(iterations, 1);
ap = zeros(iterations, 1);

lengthStorage = zeros(finalSize, iterations);

zt = linspace(0, tf, tf * 10 + 1);
zt2 = linspace(0, totalLength, totalLength * 10 + 1);
zt3 = linspace(0, totalLength, finalSize);

for counter = 1:iterations
    z2 = zeros(totalLength * 10 + 1, 1);
    z2(1:tf * 10 + 1) = z;

    % Step 2: Integrate system equations forward with specified
    % initial conditions x(t0) and control variable histories.
    % Record x, u, psi(x(tf))
%     [Tx, X] = ode113(@(t, y) hh(t, y, zt2, z2), [0 totalLength], [0.0026 0.0529 0.3177 0.596]); 
    [Tx, X] = ode113(@(t, y) hh(t, y, zt2, z2), [0 totalLength], [3.7608 0.0816 0.3765 0.4617]);    % initial conditions for near bistable (6 uA / cm2)
    
    if (sum(isnan(X)) ~= 0)
        'broken'
        break;
    end
    
    Xf = interp1(Tx, X, tf);
    psi = Xf(1) - 15;
    lengthStorage(:, counter) = interp1(zt2, z2, zt3);
   
    figure (1);
    subplot(2, 4, 1); plot(zt2, -z2);
    subplot(2, 4, 2); plot(iTemp);
    subplot(2, 4, 3); plot(dist);

    subplot(2, 4, 5); plot(Tx, X(:, 1)); hold on; plot(tf, Xf(:, 1), 'r.'); hold off;
    subplot(2, 4, 6); plot(Tx, X(:, 2)); hold on; plot(tf, Xf(:, 2), 'r.'); hold off;
    subplot(2, 4, 7); plot(Tx, X(:, 3)); hold on; plot(tf, Xf(:, 3), 'r.'); hold off;
    subplot(2, 4, 8); plot(Tx, X(:, 4)); hold on; plot(tf, Xf(:, 4), 'r.'); hold off;

    % Step 3: Determine n-vector p(t), and matrix R(t) by backward integration
    % of the influence equations using x(tf) obtained in step 2 to determine
    % boundary conditions
    [Tp, p] = ode113(@(t, y) pInfluence(t, y, Tx, X), [tf 0], [0 0 0 0]);   
    [TR, R] = ode113(@(t, y) RInfluence(t, y, Tx, X), [tf 0], [1 0 0 1]);
    
    % consolidating all the time stamps
    t1 = union(TR, zt);
    t  = union(Tp, t1);
    
    iz = interp1(zt, z, t);
    ip = interp1(Tp, p, t);
    iR = interp1(TR, R, t);
    
    % Step 4: Compute Ipp, Ijp, Ijj integrals
    Ipp = (1 / W) * trapz(t, iR(:, 1) .^ 2);
    Ijp = (1 / W) * trapz(t, (-ip(:, 1) + 2 * iz) .* (-iR(:, 1)));
    Ijj = (1 / W) * trapz(t, (-ip(:, 1) + 2 * iz) .* (-ip(:, 1) + 2 * iz));
    
    % Step 5: Choose values of dPsi, then determine v
    dPsi = -epsilon * psi;
    v = -inv(Ipp) * (dPsi + Ijp');
    
    % Step 6: Decide whether to continue
    iTemp(counter) = Ijj - Ijp / Ipp * Ijp';
    iTemp2(counter) = trapz(zt2, z2 .^ 2);
    dist(counter) = abs(psi(1));
    
    % Step 6: Improve estimate of z(t)
    dZ = -(1 / W) * (2 * iz - ip(:, 1) - iR(:, 1) * v);
    z = iz + dZ;
    % zt = t;   
    
    zt = linspace(0, tf, tf * 10 + 1);
    za = interp1(t, z, zt);
    z = za;
%    [counter iTemp(counter) * 1000 dist(counter)]
end

index = dist < 5;
if (sum(index) > 0) 
    [~, i] = min(iTemp(index));
    z3 = lengthStorage(:, i);
end