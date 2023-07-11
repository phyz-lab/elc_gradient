zt = linspace(0, 200, 201);
load gradStim;
% bestL2n = 9999;
% bestStr = -1;
% bestDur = -1;

% for str = -20: 0.1:20
%     for duration = 1:50
str = -3; duration = 2;
z = zeros(201, 1);
z(101 - duration:101) = str;
[Tx2, X2] = ode113(@(t, y) hh(t, y, zt, z), [0, 200], ...
    [0.0026 0.0529 0.3177 0.596]);
[x, i] = max(X2(:, 1));
figure(1);
subplot(2, 1, 1); plot(zt - Tx2(i), z);
subplot(2, 1, 2); plot(Tx2 - Tx2(i), X2(:, 1));
drawnow;

[Tx, X] = ode113(@(t, y) hh(t, y, zt2, z2), [0, 200], ...
    [0.0026 0.0529 0.3177 0.596]);
[x2, i2] = max(X(:, 1));
figure(1); 
subplot(2, 1, 1); hold on; plot(zt2 - Tx(i2), z2, 'r');
subplot(2, 1, 2); hold on; plot(Tx - Tx(i2), X(:, 1), 'r');
drawnow;

% if (max(X2(:, 1) > 20))
%     if (trapz(zt, z .^ 2) < bestL2n)
%         bestL2n = trapz(zt, z .^ 2);
%         bestStr = str;
%         bestDur = duration;
%     end
% end

% fprintf('Str: %f\tDur: %d\tL2n: %f\n', str, duration, trapz(zt, z .^ 2));
%     end
% end

% [pks1, locs1] = max(X(:, 1));
% [pks2, locs2] = max(X2(:, 1));
% 
% timeDiff = Tx2(locs2) - Tx(locs1);
% 
% figure;
% subplot(5, 1, 1); plot(zt100 - Tx(locs1), z100); hold on; plot(zt - Tx2(locs2), z);
% subplot(5, 1, 2); plot(Tx - Tx(locs1), X(:, 1)); hold on; plot(Tx2 - Tx2(locs2), X2(:, 1));
% subplot(5, 1, 3); plot(Tx - Tx(locs1), X(:, 2)); hold on; plot(Tx2 - Tx2(locs2), X2(:, 2));
% subplot(5, 1, 4); plot(Tx - Tx(locs1), X(:, 3)); hold on; plot(Tx2 - Tx2(locs2), X2(:, 3));
% subplot(5, 1, 5); plot(Tx - Tx(locs1), X(:, 4)); hold on; plot(Tx2 - Tx2(locs2), X2(:, 4));
% 
