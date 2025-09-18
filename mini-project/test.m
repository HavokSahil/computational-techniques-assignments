%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Sahil Raj (2301CS41)
% Program: Numerical Simulation of Foucault Pendulum
% Description: This program simulates the motion of a Foucault pendulum
% at a given latitude using a finite difference method. The x and y
% displacements are calculated numerically, accounting for Coriolis
% force due to Earth's rotation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all; close all;

%% PARAMETERS
LATITUDE = 90;          % Latitude in degrees
ANGVAL = 10 * 360 / 86400;   % Earth's angular velocity in deg/s
G = 9.81;               % Acceleration due to gravity (m/s^2)
dt = 0.1;               % Time step (s)
l = 1.0;                % Pendulum length (m)
m = 1.0;                % Pendulum mass (kg)
T = 3600;               % Time max (seconds)

%% CONVERSIONS
lat = deg2rad(LATITUDE);       % Convert latitude to radians
av = deg2rad(ANGVAL);          % Convert angular velocity to rad/s

%% EFFECTIVE ROTATION COMPONENT
Omeg = av * sin(lat);           % Effective angular velocity at given latitude

%% FINITE DIFFERENCE COEFFICIENTS
phi = (G*dt^2/l - 2);
mu_p = Omeg^2 * dt^2 + 1;
mu_n = Omeg^2 * dt^2 - 1;

c1 = mu_n / mu_p;
c2 = -phi / mu_p;
c3 = 2 * Omeg * dt / mu_p;
c4 = Omeg * dt * phi / mu_p;

%% TIME VECTOR
t = 0:dt:T;                   % Simulate for 10 seconds
N = length(t);

%% INITIAL CONDITIONS
x = zeros(N, 1);
y = zeros(N, 1);

x(1) = 1.0;   % initial displacement in x (m)
x(2) = 1.0;   % second step (same as initial for simplicity)
y(1) = 0.0;   % initial displacement in y (m)
y(2) = 0.0;   % second step (same as initial)

%% NUMERICAL INTEGRATION USING FINITE DIFFERENCE
for i = 3:N
    y(i) = c1 * y(i-2) + c2 * y(i-1) + c3 * x(i-2) + c4 * x(i-1);
    x(i) = c1 * x(i-2) + c2 * x(i-1) - c3 * y(i-2) - c4 * y(i-1);
end

%% PLOT RESULTS
figure;
plot(x, y, 'b', 'LineWidth', 1.5);
grid on;
axis equal;
xlabel('X Displacement (m)');
ylabel('Y Displacement (m)');
title('Foucault Pendulum Trajectory at 25° Latitude');
hold on;
plot(x(1), y(1), 'ro', 'MarkerFaceColor', 'r');  % start point
legend('Pendulum Path', 'Start Position');

% ANIMATE PENDULLUM MOTION
%figure;
%for i = 1:5:N
%    plot(x(1:i), y(1:i), 'b', 'LineWidth', 1.5); hold on;
%    plot(x(i), y(i), 'ro', 'MarkerFaceColor', 'r');
%    grid on;
%    axis equal;
%    xlabel('X Displacement (m)');
%    ylabel('Y Displacement (m)');
%    title('Foucault Pendulum Motion Animation');
%    pause(0.01);
%    clf;
%end

