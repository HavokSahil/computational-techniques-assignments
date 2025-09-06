%% Interpolating a polynomial for energy levels of
%% hydrogen atom for the values of principal quant
%% um numbers.
%%
%% Author: Sahil Raj
%% Assignment 4 Problem 2

clc; clear all;

T = [1; 2; 3; 4; 5];
En = [-13.6; -3.40; -1.51; -0.85; -0.54];

scatter(T, En, 'k', 'filled');
hold on;

% Compute the polynomial or degree |Y| - 1
N = length(En);
D = zeros(N, N);

% fill the entries with the y values
for i = 1:N
  D(i,1) = En(i);
endfor

% Precompute the coefficient matrix for each term
for j = 2:N
  for i = j:N
    D(i,j) = (D(i,j-1) - D(i-1,j-1)) / (T(i) - T(i-j+1));
  endfor
endfor

% set the time sampling step as 10 miliseconds
dt = 0.01;
interpT = 0:dt:max(T);
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
      xj = T(j); % Product of x factors
      _tmp = _tmp * (x - xj);
    endfor
    res = res + _tmp;
  endfor
  interpY(i) = res;
endfor

% Plot the interpolated polynomial
plot(interpT, interpY, 'k-');

xlabel("Time (t)");
ylabel("En(t)");
title("En(t) vs t Plot");
legend(["True Points"; "Interpolated Curve"]);
hold off;

hold off;
