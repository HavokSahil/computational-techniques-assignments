%% AUTHOR: Sahil Raj
%% Program to solve a First order differential-equation
%% using Gauss elimination method

clc; clear all;

dt = 0.01;
tmax = 5;
N = round(tmax/dt);
lambda = 0.3;
N0 = 100;

M = zeros(N, N);

% SETUP the target column vector
R = -lambda * (0:N-1)' * dt * dt;
R(1) = N0;

% SETUP the matrix for the problem
M(1, 1) = 1;
for i = 2:N
  M(i, i-1) = -1;
  M(i, i) = 1;
endfor

N = size(M, 1);
% CREATE the augmented matrix
A = [ M R ];

% PERFORM Gauss elimnimation
for p = 1:N-1
  pe = A(p, p);
  for r = p+1:N
    A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
  endfor
endfor

% PERFORM back-substitution
RES = zeros(1, N);
for p = N:-1:1
  RES(p) = (A(p, end) - sum(A(p, p+1:end-1) .* RES(p+1:end)))/A(p, p);
endfor

RES = RES';
plot((0:dt:tmax)(1:N), RES, 'k-');
xlabel("Time (S)");
ylabel("Counts N(t)");
title("Solution of Differential Equation");
