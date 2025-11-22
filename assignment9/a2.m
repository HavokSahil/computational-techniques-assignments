%% Program to solve the 1D heat flow equation
%
% Author: Sahil Raj
% Assignment 9 Problem 2

clc; clear all;

alph = 0.01;

dx   = 0.05;
xmin = 0.0;
xmax = 1.0; % LENGTH OF THE ROD

dt   = 0.1;
tmin = 0.0;
tmax = 32.0;

c = alph * dt / power(dx, 2);

Xs = xmin:dx:xmax;
Ts = tmin:dt:tmax;

Nx = length(Xs);
Nt = length(Ts);

U  = zeros(Nx, Nt);

% INITIAL AND BOUNDARY CONDITIONS
U(:, 1) = sin(pi*Xs);
U(1, :) = 0;
U(Nx, :) = 0;


for j = 2:Nt
  for i = 2:Nx-1
    U(i, j) = c*U(i+1, j-1) + c*U(i-1, j-1) + (1-2*c)*U(i, j-1);
  endfor
endfor

% VISUALIZATION
surf(Ts, Xs, U)
view(45,30)
shading interp
xlabel('Time'); ylabel('Space'); zlabel('U');
title('Temperature evolution');

