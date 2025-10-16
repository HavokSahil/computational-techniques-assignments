%% Program to Plot the Potential due to Charged Solid Sphere
%% Author: Sahil Raj
%% Assignment 6 Problem 4

clc; clear all;

R = 1.0;
Q = 1.0;
mr = 10 * R;
N = 1000;

r0 = 0.01;          % Initial radius
dr = (mr - r0) / N; % Step radius value

Rs = r0 + (1:N) * dr;
V = zeros(N, 1);

rhoN = ceil((R - r0) / dr); % Index for the Sphere Radius

function I = computeIntegral(Q, Rs, dr, i, j)
  epsilon = 1e-6;
  if nargin != 5
    % Compute integral till convergence (till infinity)
    I = 0.0;
    r = Rs(i); % Starting r
    while 1 == 1
      diff = (dr / 2) * (power(r, -2) + power(r+dr, -2));
      if diff < epsilon
        break
      endif
      I = I + diff;
      r = r + dr;
    endwhile
  else
    % Definite Integral
    I = 0.0;
    cur = i;
    while cur < j
      r = Rs(cur); % Starting r
      diff = (dr/2) * (power(r, -2) + power(r+dr, -2));
      if diff < epsilon
        break
      endif
      I = I + diff;
      cur = cur + 1;
    endwhile
  endif
endfunction

V(N) = computeIntegral(Q, Rs, dr, N);
for i = N-1:-1:rhoN
  V(i) = V(i+1) + computeIntegral(Q, Rs, dr, i, i+1);
endfor
for i = rhoN-1:-1:1
  V(i) = V(i+1) + (Q/power(R, 3)) * (dr / 2) * (Rs(i) + Rs(i+1));
endfor

% Visualization Section
plot(Rs, V, 'LineWidth', 2); % Plot potential vs radius
hold on;

% Enhance visualization
xlabel('Radial distance r');
ylabel('Potential V(r)');
title('Potential due to a Uniformly Charged Solid Sphere');


r_theory = linspace(r0, mr, 500);
V_theory = zeros(size(r_theory));
for k = 1:length(r_theory)
    if r_theory(k) <= R
        V_theory(k) = (Q/(2*R)) * (3 - (r_theory(k)/R)^2);
    else
        V_theory(k) = Q ./ r_theory(k);
    end
end
plot(r_theory, V_theory, '--k', 'LineWidth', 1);
legend(['Numerical Potential'; 'Sphere Boundary'; 'Analytical Solution'; ...
       'Location'; 'northeast']);
hold off;
