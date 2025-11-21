%% Program to compute the definite integral of the function using
%% Gauss Quadrature Technique (4-points)
%%
%% Author: Sahil Raj
%% Assignment 7 Problem 1

clc; clear all;

% Precomputed Node points from the table
x0 = -0.86114;
x1 = -0.33998;
x2 =  0.33998;
x3 =  0.86114;

% Precomputed weights from the table
w0 = 0.34785;
w1 = 0.65215;
w2 = 0.65215;
w3 = 0.34785;

function y = f(x)
   y = (8 * (x+3)) / (16 + power(x+3, 4));
endfunction

I = w0*f(x0) + w1*f(x1) + w2*f(x2) + w3*f(x3);

printf("Integral of the function in [-1, 1] is: %f\n", I);
