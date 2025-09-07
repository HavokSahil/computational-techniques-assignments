%% Interpolating the values of probability density of the Quantum
%% harmonic oscillator using Neville's Algorithm.
%%
%% Author: Sahil Raj
%% Assignment 4 Problem 4

clc; clear all;

X = [ 0; 0.5; 1; 1.5; 5 ];
Y = [ 0.5641; 0.4394; 0.2075; 0.0594; 0.0103 ];

% Recursive function to compute the interpolated value
% using neville's algorithm
% i: first index
% j: second index
% x: input domain value
% X: vector of observed domain values
% Y: vector of results at points in X
function res = Pij(i, j, x, X, Y)
  if i == j
    res = Y(i);
  else
    res = (x-X(i))*Pij(i+1, j, x, X, Y) - (x-X(j))*Pij(i,j-1,x,X,Y);
    res = res / (X(j) - X(i));
  endif
endfunction

% Wrapper around the interpolation function to interpolate with maximum
% degree polynomial
function res = interpNeville(x, X, Y)
  N = length(X);
  res = Pij(1, N, x, X, Y);
endfunction

% Interpolate some points between 1 and 3
points = 0:0.1:5;
N = length(points);
interpY = zeros(N, 1);
for i = 1:N
  interpY(i) = interpNeville(points(i), X, Y);
endfor

scatter(points, interpY, 'r', "filled");
hold on;
scatter(X, Y, 'k', "filled");
hold off;
xlabel("X(nm)");
ylabel("Probability");
title("Probability Density of the Quantum Harmonic Oscillator at different values of position");
legend(["Interpolated Points"; "Actual Points"]);
