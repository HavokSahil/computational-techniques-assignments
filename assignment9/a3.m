%% Program to solve the 2D Poisson Equation
%
% Author: Sahil Raj
% Assignment 9 Problem 3

clc; clear all;

N = 50;
h = 1/(N+1);
x = linspace(0,1,N+2);
y = linspace(0,1,N+2);

[X,Y] = meshgrid(x,y);

U = zeros(N+2,N+2);
F = -2*pi^2*sin(pi*X).*sin(pi*Y);

tol = 1e-6;
maxIter = 10000;

for iter = 1:maxIter
    U_old = U;
    for i = 2:N+1
        for j = 2:N+1
            U(i,j) = 0.25*( U_old(i+1,j) + U_old(i-1,j) + U_old(i,j+1) + U_old(i,j-1) - h^2 * F(i,j) );
        end
    end

    % compute error
    err = max(max(abs(U-U_old)));
    fprintf('Iteration %d, Error = %.6e\n', iter, err);

    % check convergence
    if max(max(abs(U-U_old))) < tol
        fprintf('Converged at iteration %d\n', iter);
        break;
    end
end

surf(X,Y,U)
shading interp
xlabel('x'); ylabel('y'); zlabel('u')
title('2D Poisson equation solution')

