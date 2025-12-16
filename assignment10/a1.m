%% Program to compute the Principal axis and the moment of inertia about the
%  principal axis of a given mass arrangement
%
% Author: Sahil Raj
% Assignment 10 Problem 1

clc; clear all;

m = 1.0;
b = 1.0;

ms = [m; m];
pos = [
  -b  b 0;
   b -b 0;
];

N = length(ms);

% MOMENT OF INERTIA MATRIX
I = zeros(3, 3);

for i = 1:3
  for j = 1:3
    M = 0.0;
    for n = 1:N
      M = M + ms(n) * pos(n, i) * pos(n, j);
    endfor
    I(i, j) = M;
  endfor
endfor

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

fprintf("Principal moments:\n");
disp(D);

fprintf("Principal axes (columns are eigenvectors):\n");
disp(Q);

% --- VISUALIZE PRINCIPAL AXES ---
figure;
hold on;
axis equal;
grid on;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Principal Axes');

% origin
o = [0 0 0];

% scale for visibility
s = 1.5;

% each column of Q is an eigenvector (principal axis)
px = Q(:,1) * s;
py = Q(:,2) * s;
pz = Q(:,3) * s;

quiver3(o(1), o(2), o(3), px(1), px(2), px(3), 'LineWidth', 2);
quiver3(o(1), o(2), o(3), py(1), py(2), py(3), 'LineWidth', 2);
quiver3(o(1), o(2), o(3), pz(1), pz(2), pz(3), 'LineWidth', 2);

legend('Principal Axis 1','Principal Axis 2','Principal Axis 3');
camzoom(1.2);
rotate3d on;
