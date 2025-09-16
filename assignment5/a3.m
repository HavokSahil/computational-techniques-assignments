%% Program to compute the numerical derivative of f(x) = cot(x)
%% using Forward and Central Difference Schemes
%%
%% Author: Sahil Raj
%% Assignment 5, Problem 3
%% Filename: a3.m

clc; clear; close all;

% Input: Angles in degrees
X_deg = [1; 2; 3; 4; 5];
X_rad = deg2rad(X_deg);          % convert to radians
F = cot(X_rad);                  % f(x) = cot(x)

% Forward Difference Derivative
N = length(X_deg);
dResF = zeros(N-1, 1);
for i = 1:N-1
    dResF(i) = (F(i+1) - F(i)) / (X_rad(i+1) - X_rad(i));
end
dXF = X_deg(1:N-1);

% Central Difference Derivative
dResC = zeros(N-2, 1);
for i = 2:N-1
    dResC(i-1) = (F(i+1) - F(i-1)) / (X_rad(i+1) - X_rad(i-1));
end
dXC = X_deg(2:N-1);

% True Derivative: f'(x) = -csc^2(x)
trueDeriv = -csc(X_rad).^2;

%% Plot function
subplot(1, 2, 1);
plot(X_deg, F, 'bo-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
xlabel('Angle (degrees)', 'FontWeight', 'bold');
ylabel('cot(x)', 'FontWeight', 'bold');
title('Cotangent Function');
grid on;
set(gca, 'FontSize', 10);

%% Plot numerical derivatives vs true derivative
subplot(1, 2, 2);
plot(dXF, dResF, 'rs-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r'); hold on;
plot(dXC, dResC, 'gd-', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
plot(X_deg, trueDeriv, 'k--', 'LineWidth', 1.2); % true derivative
xlabel('Angle (degrees)', 'FontWeight', 'bold');
ylabel('Derivative', 'FontWeight', 'bold');
title('Derivative of cot(x)');
legend('Forward Difference', 'Central Difference', 'True Derivative', 'Location', 'best');
grid on;
set(gca, 'FontSize', 10);

