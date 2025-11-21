clc; clear all;

%% Program to compute the integral of 1/(2 + 2x + x^2) in
% the range 0 -> inf by gauss-laguerre 3 point technique
% by change of coordinate
%
% Author: Sahil Raj
% Assignment 8 Problem 5

nodes = [
  0.415775;
  2.29428;
  6.28995;
];

weights = [
  0.711093;
  0.278518;
  0.0103893;
];

fn = @(x) exp(x) / (2 + 2 * x + power(x, 2));

I = 0.0;
for i = 1:3
  I = I + weights(i) * fn(nodes(i));
endfor

fprintf("The integral of the given function is: %f\n", I);
