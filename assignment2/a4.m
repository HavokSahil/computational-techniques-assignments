%% Program to solve the system of linear equation using jacobi iteration
% Author: Sahil Raj
% Assignment 2 Problem 4

clc; clear all;

% Define the coefficient matrix
A = [
  10 2 1
  2 20 -2
  -2 3 10
];

% Define the constants matrix
b = [
  9;
  -44;
  22
];

% Dimension of the matrix
N = size(A, 1);

% Extract the diagonal matrix
D = zeros(size(A));
for i = 1:N
  D(i,i) = A(i,i);
endfor

% Extract the non diagonal matrix
Q = D - A;

K = 1000; % Number of iteration in jacobi iteration

% Start with a random solution
X = rand(N,1);
iD = inverse(D);
for i = 1:K
  X = iD * (b + Q*X);
endfor


% Plot the convergence
% Compute the true solution
trueX = inverse(A) * b;
baseK = 1
mpK = 10
avgarr = zeros(mpK, 1);
for i = 1:mpK
  X = rand(N, 1);
  for j = 1:baseK
    X = iD * (b + Q*X);
  endfor
  % Compute the error
  avgarr(i) = norm(X - trueX);
  baseK += 1;
endfor

% Plot the solution
plot((1:mpK), avgarr, 'k-');
title("Convergence of the solution with number of iterations");
xlabel("Iterations (N)");
ylabel("Mean Squared Error (MSE)");
xticks((1:mpK));
