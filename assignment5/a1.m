%% Program to Compute the Interpolation of the cotangent function
%% with rational interpolation.
%%
%% Author: Sahil Raj
%% Assignment 5: Problem 1
%% Filename: a1.m

clc; clear all; close all;

% Data points
Xd = 1:0.2:2.0;                % Degrees
Xr = deg2rad(Xd);        % Radians
Fs = cot(Xr);                  % Function values

N = length(Xd);
D = zeros(N, N);

% First column = function values
for i = 1:N
    D(i,1) = Fs(i);
end

% Build reciprocal difference table (logic unchanged)
for j = 2:N
    for i = 1:N-j+1
        num = Xr(i+j-1) - Xr(j-1);
        den = D(i+1,j-1) - D(1,j-1);
        D(i,j) = num / den;
    end
end

% Extract coefficients
A = D(1,1:N);

% ---------------------------
% Rational Interpolation Routine
% ---------------------------
function y = RationalInterp(x, X, A, N)
    sum = A(N);
    for i = N-1:-1:1
        sum = A(i) + (x - X(i)) / sum;
    end
    y = sum;
end

% Interpolation points
interpXd = 0.5:0.1:5.0;               % Degrees
interpXr = (pi / 180.0) * interpXd;   % Radians
interpN = length(interpXd);
interpFs = zeros(interpN, 1);

for i = 1:interpN
    interpFs(i) = RationalInterp(interpXr(i), Xr, A, N);
end

% Value at 0.75 degrees
x = deg2rad(0.75);
y = RationalInterp(x, Xr, A, N);
fprintf('cot(0.75°) [rational] = %.6f   (actual = %.6f)\n', y, cot(x));

% ---------------------------
% Neville's Interpolation for comparison
% ---------------------------
function res = Pij(i, j, x, X, Y)
    if i == j
        res = Y(i);
    else
        res = (x - X(i))*Pij(i+1, j, x, X, Y) - (x - X(j))*Pij(i, j-1, x, X, Y);
        res = res / (X(j) - X(i));
    end
end

function res = interpNeville(x, X, Y)
    N = length(X);
    res = Pij(1, N, x, X, Y);
end

yneville = interpNeville(x, Xr, Fs);
fprintf('cot(0.75°) [Neville]  = %.6f\n', yneville);

% ---------------------------
% Plot
% ---------------------------
figure;
plot(interpXd, interpFs, 'b-', 'LineWidth', 1.5); hold on;
plot(Xd, Fs, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
xlabel('x (degrees)', 'FontWeight', 'bold');
ylabel('cot(x)', 'FontWeight', 'bold');
title('Rational Interpolation of cot(x)');
legend('Rational Interpolation', 'Data Points', 'Location', 'northeast');
grid on;
set(gca, 'FontSize', 10);

