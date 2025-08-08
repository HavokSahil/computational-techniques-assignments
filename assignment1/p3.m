%% AUTHOR: Sahil Raj
%% Program to solve a System of Linear Equation using Gaussian-Jordan Method

clc; clear all;

M = [ -76 25 50; 25 -56 1; 50 1 -106 ];
R = [ -10 0 0 ]';

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
for p = 1:N
  pe = A(p, p);
  for r = 1:N
    if r == p
      continue
    endif
    A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
    disp(A)
    printf("\n")
  endfor
endfor

RES = zeros(1, N);
for p = N:-1:1
  RES(p) = A(p, end)/A(p, p);
endfor

RES = RES';
printf("---------------------------------------------------\n")
printf("Solutions obtained through back-substitution:\nx = %.4f\ny = %.4f\nz = %.4f\n", ...
RES(1), RES(2), RES(3));
disp("Where x, y and z is current in loop 1, 2 and 3 respectively in clock-wise direction")
