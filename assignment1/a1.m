%% Program to solve a System of Linear Equation using Gaussian Elimination
%%
%% AUTHOR: Sahil Raj
%% Assignment 1 Problem 1


clc; clear all;

M = [ 1 1 1; 1 -2 2; 1 2 -1 ];
R = [ 0 4 2 ]';

printf("Equations:\n")
for i = 1:size(M, 1)
  printf("%dx + %dy + %dz = %d\n", M(i, 1), M(i, 2), M(i, 3), R(i));
endfor

N = size(M, 1);
A = [ M R ]; % Augmented matrix

printf("---------------------------------------------------\n")
printf("The augmented matrix for gaussian elimination:\n");
disp(A);

printf("---------------------------------------------------\n")
printf("Steps:\n")
for p = 1:N-1
  pe = A(p, p);
  for r = p+1:N
    A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
    disp(A)
    printf("\n")
  endfor
endfor

RES = zeros(1, N);
for p = N:-1:1
  RES(p) = (A(p, end) - sum(A(p, p+1:end-1) .* RES(p+1:end)))/A(p, p);
endfor

RES = RES';
printf("---------------------------------------------------\n")
printf("Solutions obtained through back-substitution:\nx = %.2f\ny = %.2f\nz = %.2f\n", ...
RES(1), RES(2), RES(3));
