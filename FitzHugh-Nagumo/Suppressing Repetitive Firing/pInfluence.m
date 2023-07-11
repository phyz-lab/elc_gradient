function dp = pInfluence(t, p, xt, x)
b = 0.8; c = 3.0;
x = interp1(xt, x, t);

pMat = [(c * x(1) .^ 2 - c ) (1 / c); -c (b / c)];
dp = pMat * p;

% dp = zeros(2,1);    % a column vector
% dp(1) = (c * x .^ 2 - c) .* p(1) + (1 / c) * p(2);
% dp(2) = -c * p(1) + (b / c) * p(2);