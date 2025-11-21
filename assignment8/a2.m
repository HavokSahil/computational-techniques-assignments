clc; clear all;

%% Program to compute the integral of 1/(x+1) in
% the range 0 -> 1 by gauss-legendre 5 point technique
% by change of coordinate
%
% Author: Sahil Raj
% Assignment 8 Problem 2

nodes = [
  -0.90618;
  -0.538469;
  0;
  0.538469;
  0.90618;
];

weights = [
  0.236927;
  0.478629;
  0.568889;
  0.478629;
  0.236927;
];

fn = @(x)  1 / (3+x);

I = 0.0;
for i = 1:5
  I = I + weights(i) * fn(nodes(i));
endfor

fprintf("THe integral value is: %f\n", I);
