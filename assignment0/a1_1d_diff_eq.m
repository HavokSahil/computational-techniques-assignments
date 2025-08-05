% Author: Sahil Raj
% Date: 02/08/2025
% Solution of Assignment 1 Problem 1
% Description: Compute the solution of 1d first
%              order ordinary differential equa
%              -tion numerically
% Equation:
%         x'(t) = -kx; where k is a positive constant


clc; clear all;

%% Function to compute the numerical solution of diff equation
%   x'(t) = -kx; for x(0) is given and k is a constant for 0 < t <= tmax
% Input:
%       dt: the time step
%       x0: initial value of position x(0)
%       k:  coefficient value
%       t_{max}: the maximum time for simulation
% Output:
%       t: time vector of the solution
%       res: solution vector x(t)
function [t, res] = solveEqn(dt, x0, k, tmax);
  t = (0:dt:tmax);
  N = length(t);
  res = zeros(1, N);

  for i = 1:N
    if i == 1
      res(i) = x0;
    else
      res(i) = res(i-1) * (1 - k * dt);
    endif
  endfor
endfunction


x0 = 4.0;
k = 2.0; % coefficient
tmax = 2.5;

subplot(2, 1, 1);
% Compute solution for dt = 0.5
[t1, res1] = solveEqn(0.5, x0, k, tmax);
plot(t1, res1, 'g-');
hold on;
% Compute solution for dt = 0.1
[t2, res2] = solveEqn(0.1, x0, k, tmax);
plot(t2, res2, 'b-');
% Compute solution for dt = 0.01
[t3, res3] = solveEqn(0.01, x0, k, tmax);
plot(t3, res3, 'm-');
% Compute solution for dt = 0.001
[t4, res4] = solveEqn(0.001, x0, k, tmax);
plot(t4, res4, 'c-');
% Compute the analytical solution
ares = x0 * exp(-k * t4);
plot(t4, ares, 'k-');
hold off;
legend(["dt = 0.5"; "dt = 0.1"; "dt = 0.01"; "dt = 0.001"; "analytic"]);
title("Solution of Diff. Equation for Different Values of dt");
ylabel("Position(x(t))");
xlabel("Time (t)");

subplot(2, 1, 2);
% Compute the deviation for dt = 0.5
errnum1 = x0 * exp(-k*t1) - res1;
plot(t1, log(errnum1), 'g-');
hold on;
% Compute the deviation for dt = 0.1
errnum2 = x0 * exp(-k*t2) - res2;
plot(t2, log(errnum2), 'b-');
% Compute the deviation for dt = 0.01
errnum3 = x0 * exp(-k*t3) - res3;
plot(t3, log(errnum3), 'm-');
% Compute the deviation for dt = 0.001
errnum4 = x0 * exp(-k*t4) - res4;
plot(t4, log(errnum4), 'c-');
hold off;
legend(["dt = 0.5"; "dt = 0.1"; "dt = 0.01"; "dt = 0.001"]);
title("Log deviation of the numerical solution from the analytic solution");
ylabel("log(x_{ana}(t) - x_{dt}(t))");
xlabel("Time(t)");
