function dy = fhn(t, y, zt, z)
a = 0.7; b = 0.8; c = 3.0; r = 0.342;
z = interp1(zt, z, t);

dy = zeros(2,1);    % a column vector
dy(1) = c * (y(2) + y(1) - y(1) .^ 3 / 3 - r) + z;
dy(2) = -(y(1) - a + b * y(2)) / c;