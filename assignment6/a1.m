% Program to perform Numerical Ingration of the given Polynomial Function
% Author: Sahil Raj
% Assignment 6 Problem 1

clc; clear all;

% CONSTANTS AND PARAMETERS
x0 = 1.0;
xN = 10.0;
N = 1000;
dx = (xN - x0) / N;

% FUNCTION TO INTEGRATE
function y = fx(x)
  y = power(x, 3) + 1;
endfunction


% NUMERICAL INTEGRATION
I = 0.0;
for i = 1:N-1
  I = I + (dx/2) * (fx(x0 + i*dx) + fx(x0 + (i+1)*dx));
endfor

fprintf("The numerical integration (N = %d): %f\n", N, I);

% EXACT INTEGRATION
Ie = (power(xN, 4) - power(x0, 4)) / 4 + xN - x0;

fprintf("The exact integration: %f\n", Ie);

% ABSOLUTE ERROR
e = abs(Ie - I);

fprintf("The absolute error for the numerical integration: %f\n", e);
