% Author: Sahil Raj
% Date: 02/08/2025
% Solution of Assignment 1 Problem 3
% Description: Compute the solution of 1d second
%              order ordinary differential equa-
%              tion numerically
% Equation:
%         m.x'' = -kx - lx^3 - bx' + F0cos(wt);
%           where k is a positive constant


clc; clear all;

x0 = 1.0; % initial position
v0 = 0.5; % initial velocity
k = -0.4; % k < 0
m = 1.0;
l = 0.3;  % l > 0
b = 0.3;  % b > 0
F0 = 1.0; % arbitrary
w = 1.0;
dt = 0.01; % adjustable
tmax = 50.0;

t = (0:dt:tmax);
N = length(t);
res = zeros(1, N);              % reserve the solution vector

res(1) = x0;
res(2) = x0 + v0 * dt;

c = 1+b*dt/m;                   % coefficient of x(t+1)
c1 = (2 - k*dt/m + b*dt/m)/c;   % coefficient of x(t)
c2 = -l*dt*dt/(c*m);            % coefficient of x(t)^3
c3 = -1/c;                      % coefficient of x(t-1)
c4 = F0*dt*dt/(c*m);            % coefficient of cosine term

for i = (3:N)
  res(i) = c1*res(i-1)+...
           c2*power(res(i-1), 3)+...
           c3*res(i-2)+...
           c4*cos(w*t(i));
endfor

plot(t, res, 'k-');
xlabel("Time(t)");
ylabel("Position(x(t))");
title("Position-time solution curve for non-linear second order ode");
