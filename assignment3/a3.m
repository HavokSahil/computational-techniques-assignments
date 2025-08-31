%% Progam to print the error function for
%% approximation of the e^x by lagrange interpolation
%% function
%
%% Author: Sahil Raj
%% Assignment 3 Problem 3

clc; clear all;

%% Data points
Xs = [
  0.1;
  0.2;
  0.3;
  0.4;
  0.5;
  0.6;
];

%% Function to compute the upper bound
%% of the error function
function y = err_bound(Xs, x)
  N = length(Xs);
  y = exp(max(Xs)) / factorial(N+1);
  for i = 1:N
    y *= abs(x - Xs(i));
  endfor
endfunction

%% Sampled points in the range
points = 0.1:0.01:0.6;
Np = length(points);
err = zeros(Np, 1);
for i = 1:Np
  err(i) = err_bound(Xs, points(i));
endfor

%% Plot the points
plot(points, err, 'k');
xlabel("x");
ylabel("err(x)");
title("Error Function for Interpolation of exp(x)");
