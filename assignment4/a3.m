%% Interpolating the Sin function from the 10 degree
%% spaced support data, to find the value of Sin(35)
%% degree
%%
%% Author: Sahil Raj
%% Assignment 4 Problem 3

clc; clear all;

% Get the support data for 0 -> 180 degrees
h = pi * 10/180;
thetas = 0:h:pi;
Y = sin(thetas);

scatter(thetas, Y, 'k', 'filled');
hold on;

% Compute the polynomial or degree |Y| - 1
N = length(Y);
D = zeros(N, N);

% fill the entries with the y values
for i = 1:N
  D(i,1) = Y(i);
endfor

% Precompute the coefficient matrix for each term without division
for j = 2:N
  for i = j:N
    D(i,j) = (D(i,j-1) - D(i-1,j-1));
  endfor
endfor

% set the time sampling step as 0.01 radians
dt = 0.01;
interpT = 0:dt:max(thetas);
interpN = length(interpT);
interpY = zeros(interpN, 1);

% Compute the interpolated curve for the domain value
% using the precomputed polynomial coefficient
for i = 1:interpN
  res = 0.0;
  x = interpT(i);
  for k = 1:N
    _tmp = D(k,k); % coefficient
    for j = 1:k-1
      xj = thetas(j); % Product of x factors
      _tmp = _tmp * (x - xj);
    endfor
    res = res + _tmp / (power(h, k-1) * factorial(k-1));
  endfor
  interpY(i) = res;
endfor

% Plot the interpolated polynomial
plot(interpT, interpY, 'k-');

% Compute the value of Sin(35) from the interpolated curve
ang = pi * 35 / 180;
idx = round(interpN * ang / max(interpT));
y_t = interpY(idx);
scatter(interpT(idx), interpY(idx), 'r', "filled");


xlabel("x (in radians)");
ylabel("Sin(x)");
title("Sin Function Plot");
legend(["True Points"; "Interpolated Curve"; "Sin(35 deg)"]);
hold off;

printf("Sin(35degree) = %f\n", interpY(idx));
