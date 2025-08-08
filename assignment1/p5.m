%% AUTHOR: Sahil Raj
%% Program to solve the time independent Shrodinger Equation using Gauss-Jordan Elimination

clc; clear all;

dt = 0.01;
tmax = 0.1;
N = round(tmax/dt);

M = zeros(N, N);
R = zeros(N, 1);


E = 1.6e-18;
h_ = 6.626e-34;
psi0 = 0.5 + 0.5i;

del = E * dt * i / h_ - 1;

M(1, 1) = 1;
for k = 2:N
    M(k, k-1) = del;
    M(k, k) = 1;
endfor
R(1) = -del * psi0;

A = [ M R ]; % Augmented matrix

printf("---------------------------------------------------\n")
printf("Steps:\n")
for p = 1:N
  pe = A(p, p);
  for r = 1:N
    if r == p
      continue
    endif
    A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
  endfor
  printf("Step %d\n", p);
  disp("---------------------------");
  disp(A);
endfor

disp("The augmented matrix after computation.");
disp(A);

RES = zeros(1, N);
for p= N:-1:1
  RES(p) = A(p, end)/A(p, p);
endfor

RES = RES';
printf("---------------------------------------------------\n")
%disp(RES);
