load gradDurations2
figure(1); hold on; 
plot(zt25 + 12.5, z25);
plot(zt50 + 10.0, z50);
plot(zt75 + 7.5, z75);
plot(zt100 + 5.0, z100);
plot(zt125 + 2.5, z125);
plot(zt150, z150);


% 
% plot3(10 * ones(2001, 1), zt10 + 90, z10);
% plot3(20 * ones(2001, 1), zt20 + 80, z20);
% plot3(30 * ones(2001, 1), zt30 + 70, z30);
% plot3(40 * ones(2001, 1), zt40 + 60, z40);
% plot3(50 * ones(2001, 1), zt50 + 50, z50);
% plot3(60 * ones(2001, 1), zt60 + 40, z60);
% plot3(70 * ones(2001, 1), zt70 + 30, z70);
% plot3(80 * ones(2001, 1), zt80 + 20, z80);
% plot3(90 * ones(2001, 1), zt90 + 10, z90);
% plot3(100 * ones(2001, 1), zt100, z100);