%% Program to solve a First order differential-equation
%% using Gauss elimination method (full matrix approach)
%%
%% AUTHOR: Sahil Raj
%% Assignment 1 Problem 4

clc; clear all;

dt = 0.01;
tmax = 5;
N = round(tmax/dt);
lambda = 0.3;
N0 = 100;

% SETUP the matrix M and RHS vector R
M = zeros(N, N);
R = zeros(N, 1);

% Initial condition: N1 = N0
M(1,1) = 1;
R(1) = N0;

% Discretization for k = 2,...,N
for k = 2:N
    M(k, k-1) = -(1 - lambda*dt);
    M(k, k)   = 1;
    R(k) = 0;
endfor

% CREATE the augmented matrix
A = [M R];

% PERFORM Gauss elimination
for p = 1:N-1
    pe = A(p, p);
    for r = p+1:N
        A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
    endfor
endfor

% BACK-SUBSTITUTION
RES = zeros(1, N);
for p = N:-1:1
    RES(p) = (A(p, end) - sum(A(p, p+1:end-1) .* RES(p+1:end)))/A(p, p);
endfor

RES = RES';

% PLOT
plot((0:dt:tmax)(1:N), RES, 'k-');
xlabel("Time (s)");
ylabel("Counts N(t)");
title("Solution of dN/dt = -λN using Gaussian Elimination");

