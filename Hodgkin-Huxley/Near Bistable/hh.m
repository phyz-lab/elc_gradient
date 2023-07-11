function dx = hh(t, x, zt, z)
V = x(1); m = x(2); n = x(3); h = x(4);
u = interp1(zt, z, t);

dx = zeros(4,1);
C = 1;
psi = 1;

% dx(1) = (1 / C) * (-120 * (m^3) * h * (V - 115) - 36 * (n^4) * (V + 12) - 0.3 * (V - 10.613) + 15 - u);  % monostable
% dx(1) = (1 / C) * (-120 * (m^3) * h * (V - 115) - 36 * (n^4) * (V + 12) - 0.3 * (V - 10.613) + 9 - u);  % bistable
dx(1) = (1 / C) * (-120 * (m^3) * h * (V - 115) - 36 * (n^4) * (V + 12) - 0.3 * (V - 10.613) + 9 - u);  % near bistable
% dx(1) = (1 / C) * (-120 * (m^3) * h * (V - 115) - 36 * (n^4) * (V + 12) - 0.3 * (V - 10.613) - u);  % unistable

am = psi * (0.1 * (25 - V)) / (exp(0.1 * (25 - V)) - 1);
bm = psi * 4 * exp(-V / 18);
an = psi * (0.01 * (10 - V)) / (exp(0.1 * (10 - V)) - 1);
bn = psi * 0.125 * exp(-V / 80);
ah = psi * 0.07 * exp(-V / 20);
bh = psi * 1 / (exp(0.1 * (30 - V)) + 1);

dx(2) = -(am + bm) * m + am;
dx(3) = -(an + bn) * n + an;
dx(4) = -(ah + bh) * h + ah;