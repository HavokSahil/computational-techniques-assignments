%% Progrm to solve for particle in a breathing potential
%
% Author: Sahil Raj
% Assignment 9 Problem 4

clc; clear all; close all;

% PARAMTERS
Nx = 200;             % Number of spatial points
xmax = 5; xmin = -5;  % Spatial domain
dx = (xmax - xmin)/(Nx-1);
x = linspace(xmin, xmax, Nx)';

T = 1;                % Oscillation period of the potential
dt = 0.0005;          % Time step (must be small for stability)
Nt = 2000;            % Number of time steps

%% Initial wavefunction: ground state of harmonic oscillator (k=1)
psi = (1/pi)^(1/4) * exp(-0.5*x.^2);

%% Preallocate for visualization (optional)
psi_record = zeros(Nx, Nt);

%% Time evolution
for n = 1:Nt
    t = n*dt;

    % Time-dependent spring constant
    k_t = cos(2*pi*t/T)^2;

    % Potential
    V = 0.5 * k_t * x.^2;

    % Second derivative (Laplacian)
    d2psi = zeros(size(psi));
    d2psi(2:end-1) = (psi(3:end) - 2*psi(2:end-1) + psi(1:end-2)) / dx^2;

    % TDSE update (explicit Euler-like)
    psi_new = psi - 1i*dt*(-0.5*d2psi + V.*psi);

    % Boundary conditions
    psi_new(1) = 0;
    psi_new(end) = 0;

    % Update wavefunction
    psi = psi_new;

    % Store for visualization
    psi_record(:, n) = psi;
end

%% Visualization: |psi(x,t)|^2 as a heatmap
imagesc(1:Nt, x, log10(abs(psi_record).^2 + 1e-16)); % add small number to avoid log(0)
xlabel('Time step'); ylabel('x'); title('log_{10}(|psi(x,t)|^2)');
colorbar;


