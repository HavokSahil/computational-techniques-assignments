%% Program to interpolate the position of earth around
%% the sun on weekly basis from the given the first week
%% observation of each month

%% Author: Sahil Raj
%% Assignment 3 Problem 2

%% Note: the polynomial approximation is oscillating at the starts
%% and the end, I read about it, the internet says that its the
%% Runge phenomenon, I am not sure though.

clc; clear all;

% Program to plot the position of earth around the sun

% Data for first day of each month
D = [
  0.97 0.25;
  0.80 0.60;
  0.55 0.83;
  0.22 0.98;
  -0.15 0.99;
  -0.50 0.87;
  -0.78 0.63;
  -0.97 0.26;
  -0.99 -0.10;
  -0.85 -0.51;
  -0.62 -0.78;
  -0.31 -0.95;
];

% all the weeks, whose observations are recorded
weeks = [
  1;
  5;
  9;
  13;
  18;
  22;
  26;
  31;
  35;
  40;
  44;
  48;
];

allweeks = 1:1:48;

Xs = D(:,1);
Ys = D(:,2);

% Function to compute the Lagrange basis function value
function l = lagrangeI(X, i, k, x)
  l = 1.0;
  for j = 0:k
    if j ~= i
      l *= (x - X(j+1)) / (X(i+1) - X(j+1));
    endif
  endfor
endfunction

% Compute the interpolating function, for
% given order k, k must be at most O-1, where O is
% the order of the interpolating function
function y = Pk(Y, X, k, x)
  y = 0.0;
  for i = 0:k
    y += Y(i+1) * lagrangeI(X, i, k, x);
  endfor
endfunction

N = length(allweeks);
pXs = zeros(N, 1);
pYs = zeros(N, 1);
for i = 1:N
  pXs(i) = Pk(Xs, weeks, 11, allweeks(i));
  pYs(i) = Pk(Ys, weeks, 11, allweeks(i));
endfor

% Original data points
subplot(2, 2, 3);
scatter(Xs, Ys, 'k', 'filled');
hold on;
scatter(0, 0, 'r', 'filled'); % Sun
title("(c) Earth's observed monthly positions");
axis equal;
hold off;

% Interpolated orbit
subplot(2, 2, 4);
plot(pXs, pYs, 'k-'); % smoother curve
hold on;
scatter(0, 0, 'r', 'filled');
title("(d) Interpolated Earth orbit");
axis equal;
hold off;

% Raw X and Y vs weeks
subplot(2, 2, 1);
plot(weeks, Xs, 'o-');
hold on;
plot(weeks, Ys, 'o-');
title("(a) Original data vs weeks");
hold off;

subplot(2, 2, 2);
plot(allweeks, pXs, '-');
hold on;
plot(allweeks, pYs, '-');
title("(b) Interpolated values vs weeks");
hold off;
