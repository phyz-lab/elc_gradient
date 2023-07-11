errors = zeros(100, 1);
for i = 1:100
    [p, ~, mu] = polyfit(zt/10000, z, i);
    f = polyval(p, zt/10000, [], mu);

    plot(zt/10000, z, 'o', zt/10000, f, '-')
    errors(i) = trapz((f' - z) .^ 2);
end