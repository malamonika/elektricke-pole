clear all;
close all;
clc;

% ANIMACE ELEKTRICKEHO POLE DVOJICE NABOJU

graphics_toolkit("gnuplot");

[x, y] = meshgrid(-5:0.6:5, -5:0.6:5);

q1 = 1;
q2 = -1;
R = 2;

figure(1);

for k = 1:200

    t = k * 0.08;

    % Poloha kladneho a zaporneho naboje
    x1 = R * cos(t);
    y1 = R * sin(t);

    x2 = -R * cos(t);
    y2 = -R * sin(t);

    % Vypocet elektrickeho pole od kladneho naboje
    rx1 = x - x1;
    ry1 = y - y1;
    r1 = sqrt(rx1.^2 + ry1.^2);
    r1(r1 < 0.4) = 0.4;

    % Vypocet elektrickeho pole od zaporneho naboje
    rx2 = x - x2;
    ry2 = y - y2;
    r2 = sqrt(rx2.^2 + ry2.^2);
    r2(r2 < 0.4) = 0.4;

    Ex = q1 * rx1 ./ r1.^3 + q2 * rx2 ./ r2.^3;
    Ey = q1 * ry1 ./ r1.^3 + q2 * ry2 ./ r2.^3;

    % Zmenseni sipek pro prehlednost
    E = sqrt(Ex.^2 + Ey.^2);
    Ex = Ex ./ E;
    Ey = Ey ./ E;

    Ex(isnan(Ex)) = 0;
    Ey(isnan(Ey)) = 0;

    clf;

    quiver(x, y, Ex, Ey, 0.7);
    hold on;

    plot(x1, y1, "ro", "MarkerSize", 16, "MarkerFaceColor", "r");
    plot(x2, y2, "bo", "MarkerSize", 16, "MarkerFaceColor", "b");

    text(x1 + 0.25, y1 + 0.25, "+", "FontSize", 18);
    text(x2 + 0.25, y2 + 0.25, "-", "FontSize", 18);

    title("Elektricke pole pohybujicich se naboju");
    xlabel("osa x");
    ylabel("osa y");

    axis equal;
    axis([-5 5 -5 5]);
    grid on;

    drawnow;
    pause(0.08);

end
