function dR = RInfluence(t, R, xt, x)
b = 0.8; c = 3.0;
x = interp1(xt, x, t);

RMat = [(c * x(1) .^ 2 - c ) (1 / c); -c (b / c)];
tempR = [R(1) R(2); R(3) R(4)];
tempdR = RMat * tempR;

dR = zeros(4,1);    % a column vector
dR(1) = tempdR(1, 1);
dR(2) = tempdR(1, 2);
dR(3) = tempdR(2, 1);
dR(4) = tempdR(2, 2);