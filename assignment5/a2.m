%% Program to compute the rational interpolation of the
%% amplitude data of a damped harmonic oscillator.
%%
%% Author: Sahil Raj
%% Assignment 5, Problem 2
%% Filename: a2.m

clc; clear; close all;

% Time samples (s)
T = [0; 2; 4; 6];
% Amplitude samples
Amp = [10; 5.5; 3.5; 2.6];

N = length(T);
D = zeros(N, N);

% First column = function values
for i = 1:N
    D(i,1) = Amp(i);
end

% Build reciprocal difference table
for j = 2:N
    for i = 1:N-j+1
        num = T(i+j-1) - T(j-1);
        den = D(i+1,j-1) - D(1,j-1);
        D(i,j) = num / den;
    end
end

% Extract coefficients
A = D(1,1:N);

% Evaluation routine
function y = RationalInterp(x, X, A, N)
    sum = A(N);
    for i = N-1:-1:1
        sum = A(i) + (x - X(i)) / sum;
    end
    y = sum;
end


% Interpolation points
interpT = 0:0.1:6.0;
interpN = length(interpT);
interpFs = zeros(interpN, 1);

for i = 1:interpN
    interpFs(i) = RationalInterp(interpT(i), T, A, N);
end

% Example: value at t = 5.0 s
x = 5.0;
y = RationalInterp(x, T, A, N);
fprintf("Amplitude [rational interp.] (t = %.1f s) = %.4f\n", x, y);

% Plot
plot(interpT, interpFs, 'b-', 'LineWidth', 1.5); hold on;
plot(T, Amp, 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r');
xlabel('Time (s)', 'FontWeight', 'bold');
ylabel('Amplitude', 'FontWeight', 'bold');
title('Rational Interpolation of Damped Oscillator');
legend('Rational Interpolation','Data Points','Location','northeast');
grid on;
set(gca, 'FontSize', 10);

