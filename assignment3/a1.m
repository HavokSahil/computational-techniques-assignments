%% Program to interpolate a polynomial with different
%% orders of Lagrange interpolation function.
%% Author: Sahil Raj
%% Assignment 3 Problem 1

clc; clear all;

data = [
  0.5 1.625;
  1.5 5.875;
  3.0 31.0;
  5.0 131.0;
  6.5 282.125;
  8.0 521.0;
];

Xs = data(:,1);
Ys = data(:,2);

scatter(Xs, Ys, 'k', "filled");
xlabel("x");
ylabel("f(x)");
title("Plot of the Given Data Points with Lagrange Interpolation of Several Orders1");
hold on;

% Function to compute the Lagrange basis function value
function l = lagrangeI(X, i, k, x)
  l = 1.0;
  for j = 0:k
    if j ~= i
      l *= (x - X(j+1)) / (X(i+1) - X(j+1));
    endif
  endfor
endfunction

% Compute the interpolating function, for
% given order k, k must be at most O-1, where O is
% the order of the interpolating function
function y = Pk(Y, X, k, x)
  y = 0.0;
  for i = 0:k
    y += Y(i+1) * lagrangeI(X, i, k, x);
  endfor
endfunction


% Compute the interpolating function for any order and plot it
function interpolateNplot(Xs, Ys, N, order, color)
  xmin = min(Xs);
  xmax = max(Xs);
  xs = linspace(xmin, xmax, N);
  ys = zeros(N, 1);
  for i = 1:N
    ys(i) = Pk(Ys, Xs, order, xs(i));
  endfor
  plot(xs, ys,color);
endfunction

% Plot the interpolating function of all order
N = 100;
mord = length(Xs) - 1;
lgnds = ["True"];
colors = ['b-', 'r-', 'g-']
for i = 1:3
  interpolateNplot(Xs, Ys, N, i, colors(i));
  lgnds = [lgnds; strcat("Order: ", num2str(i))];
  % Calculate the value of f(7), for each order and print in the console
  f7 = Pk(Ys, Xs, i, 7.0);
  printf("[Order: %d] f(7) = %f\n", i, f7);
endfor

legend(lgnds);
hold off;
