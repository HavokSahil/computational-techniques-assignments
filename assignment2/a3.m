clc; clear all;

a = 1.0;
N = 100;
m = 1.0;
dx = a / (N+1);
xs = -a/2+dx:dx:a/2-dx; % The values of x
h_= 1.0; % Plank's constant

A = zeros(N,N);

p = h_*h_ / (2*m*dx*dx);
for i = 1:N
  for j = 1:N
    if i == j
      A(i,j) = 2*p;
    elseif j == i - 1
      A(i,j) = -p;
      A(j,i) = -p;
    endif
  endfor
endfor

% Choose a shift variable that should be close to the eigenvalue to found
sigma = 2;
K = 1000 % Number of iterations for computing the eigenvalue
psi = rand(N,1);
psi = psi / norm(psi); % Normalize the vector

%% Compute A - sigma * I
A_ = A - sigma * eye(N);

% Compute the L for A_ = LL'
L = zeros(N,N);
for r = 1:N
  for c = 1:N
    if r == c
      L(r,c) = sqrt(A_(r,c) - L(r,1:c-1) * L(r,1:c-1)');
    elseif r > c
      L(r,c) = (A_(r,c) - L(r,1:c-1) * L(1:c-1,c)) / L(c,c);
    endif
  endfor
endfor

%% Use the L and L' to solve the intermediate equations in the eigensolver iterations
for i = 1:K
  %% Solve for A_ w = psi => LL'w = psi
  %% or LY = psi and L'w = Y
  Y = zeros(N, 1);
  for i = 1:N
    if i == 1
      Y(i) = psi(i) / L(i,i);
    else
      Y(i) = (psi(i) - L(i,1:i-1)*Y(1:i-1)) / L(i,i);
    endif
  endfor

  W = zeros(N, 1);
  for i = N:-1:1
    if i == N
      W(i) = Y(i) / L(i,i);
    else
      W(i) = (Y(i) - L(i+1:N,i)'*W(i+1:N)) / L(i,i);
    endif
  endfor
  psi = W / norm(W);
endfor

%% Compute the eigen values
lambda = psi' * A * psi;
printf("Energy: %f\n", lambda);
psi = psi / norm(psi);
plot(xs, psi, 'k-');
title("Ground State Wavefunction for Particle in a Box");
xlabel("Position (x)");
ylabel("Wavefunction psi(x)");
