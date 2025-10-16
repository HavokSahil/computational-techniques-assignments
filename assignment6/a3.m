%% PROGRAM TO COMPUTE INTEGRAL OF Sin(x) / x, for 0 -> inf USING SIMPSON'S METHOD
%% Author: Sahil Raj
%% Assignment 6 Problem 3

clc; clear all;

function y = fn(x)
  if x == 0
    y = 1;        % limit sin(x)/x = 1 as x->0
  else
    y = sin(x) / x;
  endif
endfunction

% TRUE VALUE
true_val = pi / 2;
thres = 1e-6;
dx = 1e-1;
x0 = 0;

% --- SIMPSON'S 1/3 RULE ---
I1 = 0.0;
x = x0;
I_prev = 0.0;

while true
  diff = (dx / 3) * (fn(x) + 4*fn(x + dx) + fn(x + 2*dx));
  I1 = I1 + diff;
  if abs(I1 - I_prev) < thres
    break;
  endif
  I_prev = I1;
  x = x + 2*dx;
  if x > 100       % safety stop
    break;
  endif
endwhile

err1 = abs(true_val - I1);
fprintf("Simpson's 1/3 Rule: I = %.6f, error = %.3e\n", I1, err1);

% --- SIMPSON'S 3/8 RULE ---
I2 = 0.0;
x = x0;
I_prev = 0.0;

while true
  diff = (3*dx/8) * (fn(x) + 3*fn(x + dx) + 3*fn(x + 2*dx) + fn(x + 3*dx));
  I2 = I2 + diff;
  if abs(I2 - I_prev) < thres
    break;
  endif
  I_prev = I2;
  x = x + 3*dx;
  if x > 100
    break;
  endif
endwhile

err2 = abs(true_val - I2);
fprintf("Simpson's 3/8 Rule: I = %.6f, error = %.3e\n", I2, err2);

