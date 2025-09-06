%% Interpolating the Equation of Trajectory
%% from the observed vertical  displacement
%% data points and Computing initial veloci
%% ty.
%%
%% Author: Sahil Raj
%% Assignment 4 Problem 1

clc; clear all;

T = [ 0; 1; 2; 3; 4; ];   % time steps
Y = [ 0; 12; 18; 16; 0];  % vertical displacement of the
                          % projectile

% Show the scatter plot for the given points
subplot(2, 1, 1);
scatter(T, Y, 'k', 'filled');
hold on;

% Compute the polynomial or degree |Y| - 1
N = length(Y);
D = zeros(N, N);

% fill the entries with the y values
for i = 1:N
  D(i,1) = Y(i);
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

% Compute the actual trajectory
actualY = zeros(interpN, 1);
for i = 1:interpN
  t = interpT(i);
  actualY(i) = 15*t - 3*t*t;
endfor

% Plot the actual polynomial
plot(interpT, actualY, 'r-');

% Plot the interpolated polynomial
plot(interpT, interpY, 'k-');

xlabel("Time (t)");
ylabel("y(t)");
title("Projective Height v/s Time Plot");
legend(["True Points"; "Interpolated Curve"]);
hold off;

% Plot the absolute error function
subplot(2, 1, 2);
errY = abs(interpY - actualY);
disp(errY)
plot(interpT, errY, 'r-');
xlabel("Time (t)");
ylabel("|err(t)|");
title("Projectile Absolute Deviation v/s Time Plot");


% Compute the projectile height at t = 2.5 seconds
idx = round(length(interpT) * 2.5 / max(interpT));
y_t = interpY(idx);
printf("Y(t=2.5) = %f\n", y_t);

% Compute the initial velocity of the projectile
v0 = (interpY(2) - interpY(1))/dt;
printf("V0 = %f\n", v0);
