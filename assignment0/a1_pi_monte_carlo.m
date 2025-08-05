% Author: Sahil Raj
% Date: 02/08/2025
% Solution of Assignment 1 Problem 1
% Description: Show the convergence of value of PI in
%              Monte-carlo simulation with increasing
%              number of iterations.

clc; clear all;

%% Function to compute the value of pi using monte carlo simulation
% input:
%     iterations: number of monte carlo iterations
% output:
%     res: the computed value of PI
%     inpoints: sampled points that lied inside the unit circle
%     outpoints: sample points that lied outside the unit circle
function [res, inpoints, outpoints] = computePI(iterations)

  count_in = 0;
  count_all = 0;

  inpoints = [];
  outpoints = [];

  for i = 1:iterations
    x = rand; % randomly sample the x-coordinate
    y = rand; % randomly sample the y-coordinate
    d = norm([x; y]);

    if d <= 1.0 % increase the inside count if point lies inside
      count_in += 1;
      inpoints = [inpoints, [x; y]];
    else
      outpoints = [outpoints, [x; y]];
    endif
      count_all += 1;
  endfor

  res = 4 * count_in / count_all;

endfunction

% start with base count 64
iterations = 64;

for i = (1:4)
  subplot(2, 2, i);
  [res, inpoints, outpoints] = computePI(iterations);
  scatter(inpoints(1,:), inpoints(2,:), "filled");
  hold on;
  scatter(outpoints(1,:), outpoints(2,:), "filled");
  hold off;
  titlestring = sprintf("Iterations: %d", iterations);
  title(titlestring);
  labelstring = sprintf("PI = %.6f", res);
  xlabel(labelstring);
  iterations *= 10;
endfor

