%% Program to compute velocity from position-time data
%% using Central Difference Method
%%
%% Author: Sahil Raj
%% Assignment 5, Problem 4
%% Filename: a4.m

clc; clear; close all;

% Time (s) and Position (m)
T = [0.0; 0.1; 0.2; 0.3; 0.4];
Y = [1.200; 1.150; 1.010; 0.780; 0.460];

% Central difference derivative
N = length(T);
dX = T(2:N-1);              % midpoints where derivative is valid
dRes = zeros(N-2, 1);       % preallocate velocity results

for i = 2:N-1
    dRes(i-1) = (Y(i+1) - Y(i-1)) / (T(i+1) - T(i-1));
end

% Interpolated velocities
v1 = dRes(2);   % at t = 0.2 s
v2 = dRes(3);   % at t = 0.3 s

printf("v1 (interpolated): %f\n", v1);
printf("v2 (interpolated): %f\n", v2);

% Theoretical velocities (free fall assumption: v = g*t)
g = 9.8;
vR1 = g * 0.2;
vR2 = g * 0.3;
printf("v1 (theoretical): %f\n", vR1);
printf("v2 (theoretical): %f\n", vR2);


%% Plot Position vs Time
subplot(1, 2, 1);
plot(T, Y, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 7, ...
     'MarkerFaceColor', 'b');
xlabel('Time (s)', 'FontWeight', 'bold');
ylabel('Position (m)', 'FontWeight', 'bold');
title('Position vs Time');
grid on;
set(gca, 'FontSize', 10);

%% Plot Velocity vs Time
subplot(1, 2, 2);
plot(dX, dRes, 'rs-', 'LineWidth', 1.5, 'MarkerSize', 7, ...
     'MarkerFaceColor', 'r');
hold on;
scatter([0.2, 0.3], [vR1, vR2], 60, 'k', 'filled'); % true velocities
xlabel('Time (s)', 'FontWeight', 'bold');
ylabel('Velocity (m/s)', 'FontWeight', 'bold');
title('Velocity vs Time (Central Difference)');
legend('Numerical Velocity', 'True Velocity', 'Location', 'best');
grid on;
set(gca, 'FontSize', 10);

