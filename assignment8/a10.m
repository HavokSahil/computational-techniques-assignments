clc; clear all;

% Constants
m = 1.0;
h = 1.0;
w = 1.0;
dx = 0.01;

function phi = compphi(dx, j)
  phi = 2 + power(dx, 4) * j * j - dx*dx;
endfunction

% Initial values to arbitrary scale
% NOTE: the scale are to be fixed while normalization
psi0even = 1.0;
psi1even = 1.0;

Xmax = 2;
Xs = 0:dx:Xmax;
N = length(Xs);

psieven = zeros(N, 1);

psieven(1) = psi0even;
psieven(2) = psi1even;

for i = 3:N
  psieven(i) = compphi(dx, i) * psieven(i-1) - psieven(i-2);
endfor

% Lets compute the Integral of the function
% since the ground state function is even,
% the factor will be 2.

weights = [
  sqrt(pi)/2;
  sqrt(pi)/2;
];

nodes = [
   -1/sqrt(2);
    1/sqrt(2);
];

index = floor(nodes(2) / dx);
fx = psieven(index);
I = 2 * fx * weights(2);

psieven = psieven / I;

fprintf("The normalization constant was: %f\n", I);

figure('Color','w');                 % clean white background
plot(Xs, psieven, 'LineWidth', 2);   % thicker line for visibility
grid on;                             % grid improves readability

xlabel('x','FontSize',12,'FontWeight','bold');
ylabel('\psi(x)','FontSize',12,'FontWeight','bold');
title('Wavefunction','FontSize',14,'FontWeight','bold');

xlim([0 Xmax]);                      % enforce proper axis
ylim([min(psieven)-0.1, max(psieven)+0.1]);

set(gca, 'FontSize', 12, 'LineWidth', 1.2);   % nicer axes

