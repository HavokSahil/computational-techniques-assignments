%% Program to solve the time dependent Shrodinger Equation using Gauss-Jordan Elimination

%% NOTE: This code takes about a minute to run,
%% TO GET FATER RESULT: reduce the tmax value
%% AUTHOR: Sahil Raj

clc; clear all;

dt = 0.01;
% change the values here
tmax = 5.0;
N = round(tmax/dt);
t = (0:dt:tmax)(1:N);

M = zeros(N, N);
R = zeros(N, 1);


h_ = 6.626e-34;
E = -10*h_;
psi0 = 0.5 + 0.5i;

% COMPUTE the base of the exponent
del = E * dt * i / h_ - 1;

% SETUP the matrix
M(1, 1) = 1;
for k = 2:N
    M(k, k-1) = del;
    M(k, k) = 1;
endfor

% SETUP the initial value
R(1) = -del * psi0;

% CREATE the augmented matrix
A = [ M R ];

% PERFORM gauss-jordan elimination
for p = 1:N
  pe = A(p, p);
  for r = 1:N
    if r == p
      continue
    endif
    A(r, :) = A(r, :) - A(r, p) * A(p, :) / pe;
  endfor
endfor

% OBTAIN the values of Variables psi_{k}
RES = zeros(1, N);
for p= N:-1:1
  RES(p) = A(p, end)/A(p, p);
endfor

RES = RES';
subplot(2, 1, 1);
plot(t, abs(RES), 'k-');
xlabel("TIme (s)");
ylabel("Magnitude |psi(t)|");
title("Magnitude of the Solution");
subplot(2, 1, 2);
plot(t, angle(RES), 'k-');
xlabel("TIme (s)");
ylabel("Magnitude <psi(t)");
title("Phase of the Solution");
