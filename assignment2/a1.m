%% Program to Solve the system of linear equation using LU decomposition
%% Author: Sahil Raj
%% Assignment 2 Problem 1

clc; clear all;

A = [
      1 1 1;
      4 3 -1;
      3 5 3;
    ]; % The target matrix

% Display the A Matrix
printf("A Matrix:\n");
disp(A);

B = [ 1; 6; 4 ];

L = zeros(size(A)); % Reserve space for L matrix
U = zeros(size(A)); % Reserve space for U matrix

N = size(A, 1);     % Dimension of the matrix A

% Compute the L and U matrix entries
for c = 1:N
  for r = 1:N
    if c >= r % Compute u_rc
        if r == c
          L(r,c) = 1; % Set the diagonal of L matrix
        endif
        U(r,c) = A(r,c) - L(r,1:r-1) * U(1:r-1,c);
    else % Compute l_rc
        L(r,c) = (A(r,c) - L(r,1:c-1) * U(1:c-1,c)) / U(c,c);
    endif
  endfor
endfor

%%  ========= DISPLAY the Final L and U matrix =============
printf("L Matrix:\n");
disp(L);
printf("U Matrix:\n");
disp(U);

%% Solve the two equations through forward-substitutionn
%   LY = B
%   UX = Y
Y = zeros(N, 1);
for i = 1:N
  if i == 1
    Y(i) = B(i) / L(i,i);
  else
    Y(i) = (B(i) - L(i,1:i-1)*Y(1:i-1)) / L(i,i);
  endif
endfor

% Use the Y vector to solve for the X vector (back-substitution)
X = zeros(N, 1);
for i = N:-1:1
  if i == N
    X(i) = Y(i) / U(i,i);
  else
    X(i) = (Y(i) - U(i,i+1:N)*X(i+1:N)) / U(i,i);
  endif
endfor

% ========= Print the resultant vector X ===============
printf("Resultant X\n");
for i = 1:N
  printf("X%d = %.6f\n", i, X(i));
endfor
