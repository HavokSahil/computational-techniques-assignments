%% Program to find the eigenvalues and eigenvector of the given matrix
%
% Author: Sahil Raj
% Assignment 10 Problem 2

clc; clear all;

I = [
  1.0 0.2 0.1;
  0.2 2   0.3;
  0.1 0.3 3.0;
];

% FUNCTION TO COMPUTE THE LARGEST NON DIAGONAL ELEMENT
function res = argmaxNZ(M)
  N = size(M, 1); % the input matrix is square matrix
  mx = 0.0;
  i = 0;
  j = 0;
  thres = 1e-6;
  for n = 1:N
    for m = 1:N
      if n == m
        continue
      endif
      % non-diagonal element
      value = abs(M(n, m));
      if value > mx && value > thres
        mx = abs(M(n, m));
        i = n;
        j = m;
      endif
    endfor
  endfor
  res = [i j];
endfunction

% DIAGONALIZE THE MATRIX BY ROTATING IT ABOUT ITS MOST UNSTABLE AXIS
% Note: the matrix is assumed to be symmetric, which is true for moment
% of intertia matrix
% compute the angle of rotation

Q = eye(3);     % cumulative rotation (principal-axis basis)

D = I;
while true
  res = argmaxNZ(D);
  pI = res(1);
  pJ = res(2);
  if pI == 0 || pJ == 0
    break;
  endif

  pnum = 2 * D(pI, pJ);
  pden = D(pI, pI) - D(pJ, pJ);

  if pden == 0.0
    ang = pi/4;
  else
    ang = 0.5 * atan(pnum/pden);
  endif

  R = eye(3);
  R(pI, pI) =  cos(ang);
  R(pJ, pJ) =  cos(ang);
  R(pI, pJ) =  sin(ang);
  R(pJ, pI) = -sin(ang);

  R_ = inverse(R);

  % update the matrix
  D = R * D * R_;

  % accumulate principal-axis rotation
  Q = Q * R;
endwhile

fprintf("Eigenvalues:\n");
eigval = [D(1, 1) D(2, 2) D(3, 3)];
disp(eigval);

fprintf("Eigenvectors: \n");
disp(Q);
