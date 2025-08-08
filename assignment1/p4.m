%% AUTHOR: Sahil Raj
%% Program to solve a System of Linear Equation using Gaussian Elimination

clc; clear all;

dt = 0.01;
tmax = 20;
N = round(tmax/dt);
lambda = 0.3;
N0 = 100;

M = zeros(N, N);
R = -lambda * (0:N-1)' * dt * dt;

for i = 1:N-1
  M(i, i) = -1;
  M(i, i+1) = 1;
endfor
M(N, N) = -1;

N = size(M, 1);
A = [ M R ]; % Augmented matrix

for p = 1:N-1
  pe = A(p, p);
  for r = p+1:N
    A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
  endfor
endfor

RES = zeros(1, N);
for p = N:-1:1
  RES(p) = (A(p, end) - sum(A(p, p+1:end-1) .* RES(p+1:end)))/A(p, p);
endfor

RES = RES';
plot(RES);
