%% Program to Solve the Particle in a Box Equation using Central Difference
%% and compare it with analytical solution by normalizing both solution using
%% numerical integration
%% AUTHOR: Sahil Raj
%% Assignment 6 Problem 2

clc; clear all; close all;

% CONSTANTS AND PARAMETERS
x0 = 0.0;          % left boundary
xN = 4.0;          % right boundary
N  = 300;          % number of intervals
dx = (xN - x0) / N; % grid spacing
Xs = linspace(x0, xN, N+1)'; % grid points (N+1 points including boundaries)

M = N - 1;         % number of internal points (excluding boundaries)

% CREATE THE TRIDIAGONAL MATRIX
A = zeros(M, M);
for i = 1:M
  A(i, i) = 2;
endfor

for i = 1:M-1
  A(i, i+1) = -1;
  A(i+1, i) = -1;
endfor

% FIND THE SMALLEST EIGENVALUE USING INVERSE ITERATION
A_inv = inv(A);
wf = rand(M, 1);   % random initial wavefunction guess
niter = 20;        % number of iterations

for i = 1:niter
  nwf = A_inv * wf;
  wf = nwf / norm(nwf); % normalize at each step
endfor

% COMPUTE THE EIGENVALUE FROM THE EIGENVECTOR
lambda_min = (wf' * A * wf) / (wf' * wf);

% WAVE FUNCTION WITH ADDED BOUNDARY CONDITIONS
WF = [0.0; wf; 0.0];

% NORMALIZE THE NUMERICAL WAVE FUNCTION
I = 0.0;
for i = 1:N
  I = I + (dx/2) * (WF(i)^2 + WF(i+1)^2);
endfor
a = sqrt(1/I);
normalized_wf = WF * a;

% COMPUTE THE ANALYTICAL WAVE FUNCTION AND NORMALIZE
function y = psi_analytical(x)
  y = sin(pi * x / 4.0);
endfunction

tI = 0.0;
for i = 1:N
  x1 = x0 + (i-1)*dx;
  x2 = x0 + i*dx;
  tI = tI + (dx/2) * (psi_analytical(x1)^2 + psi_analytical(x2)^2);
endfor

aa = sqrt(1/tI);
twf = zeros(N+1, 1);
for i = 1:N+1
  twf(i) = psi_analytical(Xs(i)) * aa;
endfor

% VISUALIZATION
figure(1);
plot(Xs, normalized_wf, 'r-', 'LineWidth', 2);
hold on;
plot(Xs, twf, 'k--', 'LineWidth', 2);
hold off;
xlabel('x');
ylabel('\psi(x)');
title('Numerical vs Analytical Wave Function');
legend('Numerical (Finite Difference)', 'Analytical (sin(\pi x / L))');
grid on;

% DISPLAY RESULTS
fprintf('Smallest Eigenvalue (Numerical) = %.6f\n', lambda_min);

