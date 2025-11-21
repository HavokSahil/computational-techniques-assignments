clc; clear all;

%% Program to compute the integral of fn exp(-x) / (1 + x^2)
% using 5-point Gauss Laguerre technique
%
% Author: Sahil Raj
% Assignment 8 Problem 4

weights = [
  0.521756;
  0.398667;
  0.0759424;
  0.00361176;
  0.00002337;
];

nodes = [
  0.26356;
  1.4134;
  3.59643;
  7.08581;
  12.6408;
];

fn = @(x) 1/(1 + power(x, 2));

I = 0.0;
for i = 1:5
  I = I + weights(i) * fn(nodes(i));
endfor

fprintf("The value of the integral is: %f\n", I);
