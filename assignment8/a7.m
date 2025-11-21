clc; clear all;

%% Program to compute the integral of exp(-x^2) / (1 + x + x^2)
% using Gauss-Hermite 5 point technique;
%
% Author: Sahil Raj
% Assignment 8 Problem 7

fn = @(x) 1/(1 + x + power(x, 2));

nodes = [
  -2.02018;
  -0.958572;
   0;
   0.958572;
   2.02018;
];

weights = [
  0.0199532;
  0.393619;
  0.945309;
  0.393619;
  0.0199532;
];

I = 0.0;

for i = 1:5
  I = I + weights(i) * fn(nodes(i));
endfor

fprintf("The integral of the function is: %f\n", I);
