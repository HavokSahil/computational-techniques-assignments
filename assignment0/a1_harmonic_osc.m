% Author: Sahil Raj
% Date: 02/08/2025
% Solution of Assignment 1 Problem 2
% Description: Compute the solution of 1d second
%              order ordinary differential equa-
%              tion numerically.
% Equation:
%         m.x''(t) = -k.x(t); where k is a positive constant


clc; clear all;

%% Compute the numerical solution of the equation for the equation
%   m.x''(t) = -k.x(t)
% Input:
%       dt: time-step
%       k: spring constant
%       m: mass constant
%       x0: initial value of position
%       v0: initial velocity
%       tmax: Time for simulation
% Output:
%       t: Time-vector
%       res: Solution vector x(t)
function [t, res] = solveHarmonic(dt, k, m, x0, v0, tmax)

  t = (0:dt:tmax);
  N = length(t);
  res = zeros(1, N);

  x1 = v0 * dt + x0;
  res(1) = x0;
  res(2) = x1;
  for i = 3:N
    res(i) = res(i-1) * (2 - k*dt*dt/m) - res(i-2);
  endfor

endfunction

dt = 0.1;
m = 0.5;
k = 2.0;
x0 = 1.0;
v0 = 0.5;
tmax = 10.0;

subplot(2, 1, 1);

% Compute the solution for dt = 0.5
[t1, res1] = solveHarmonic(0.5, k, m, x0, v0, tmax);
plot(t1, res1, 'c-');
hold on;

% Compute the solution for dt = 0.1
[t2, res2] = solveHarmonic(0.1, k, m, x0, v0, tmax);
plot(t2, res2, 'm-');

% Compute the solution for dt = 0.01
[t3, res3] = solveHarmonic(0.01, k, m, x0, v0, tmax);
plot(t3, res3, 'r-');

% Compute the solution for dt = 0.001
[t4, res4] = solveHarmonic(0.001, k, m, x0, v0, tmax);
plot(t4, res4, 'b-');

% Compute the analytical solution
A = sqrt(m*v0*v0/k + x0*x0);
freq = sqrt(k/m);
phase = asin(x0/A);
ares = A * sin(freq * t4 + phase);
plot(t4, ares, 'k-');
hold off;

title("Position-Time graph for different values of dt");
xlabel("Time(t)");
ylabel("Position(x(t))");
legend(["dt=0.5"; "dt=0.1"; "dt=0.01"; "dt=0.001"; "analytical"]);

subplot(2, 1, 2);
err1 = abs(A * sin(freq * t1 + phase) - res1);
plot(t1, log(err1), 'c-');
hold on;
err2 = abs(A * sin(freq * t2 + phase) - res2);
plot(t2, log(err2), 'm-');
err3 = abs(A * sin(freq * t3 + phase) - res3);
plot(t3, log(err3), 'r-');
err4 = abs(A * sin(freq * t4 + phase) - res4);
plot(t4, log(err4), 'b-');
hold off;
title("Absolute deviation of numerical solution from analytical solution for different value of dt");
xlabel("Time(t)");
ylabel("Log Absolute deviation log(|x_{ana}(t) - x_{dt}(t)|)");
legend(["dt=0.5"; "dt=0.1"; "dt=0.01"; "dt=0.001"; "analytical"]);

