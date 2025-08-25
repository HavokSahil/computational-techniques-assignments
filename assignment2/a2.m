clc; clear all;

dt = 0.01;
k = 5.0;
m = 0.01;
tmax = 2;
t = 0:dt:tmax;
N = length(t);

x0 = 0.0;             % initial position
v0 = 0.5;             % initial velocity
x1 = x0 + v0 * dt;    % second initial parameter
c = (k*dt*dt/m - 2);  %  The sub diagonal coefficient

A = zeros(N-2,N-2);
for i = 1:N-2
  for j = 1:N-2
    if i == j
      A(i,j) = 1;
     elseif i == j + 1
      A(i,j) = c;
     elseif i == j + 2
      A(i,j) = 1;
    endif
  endfor
endfor

B = zeros(N-2, 1);  % Target vector
B(1) = -x0 -c*x1;
B(2) = -x1;

Z = zeros(N);
Z(1) = x0;
Z(2) = x1;

L = zeros(size(A)); % Reserve space for L matrix
U = zeros(size(A)); % Reserve space for U matrix

M = size(A, 1);     % Dimension of the matrix A

% Compute the L and U matrix entries
for c = 1:M
  for r = 1:M
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

%% Solve the two equations through back-substitution
%   LY = B
%   UX = Y
Y = zeros(M, 1);
for i = 1:M
  if i == 1
    Y(i) = B(i) / L(i,i);
  else
    Y(i) = (B(i) - L(i,1:i-1)*Y(1:i-1)) / L(i,i);
  endif
endfor

% Use the Y vector to solve for the X vector
X = zeros(M, 1);
for i = M:-1:1
  if i == M
    X(i) = Y(i) / U(i,i);
  else
    X(i) = (Y(i) - U(i,i+1:M)*X(i+1:M)) / U(i,i);
  endif
endfor

for i=1:N-2
  Z(i+2) = X(i);
endfor

plot(Z, 'k-');

