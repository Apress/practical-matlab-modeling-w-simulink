% IMPLICIT_1ODE_EX1.m
%{
EXAMPLE 1. Problem: t^2*y'+t*(y')^2+2*cos(t)=1/y with ICs: y(0)=1/2;
Part 1. 
The problem function is defined via function handle under name of Yin. 
A new variable is introduced: dy=yp.
%}
clearvars; close all
Yin=@(t,y, yp)(t^2*yp+t*yp^2+2*cos(t)-1/y);
y0=1/2; yp0=0;  % Initial conditions
[t, yt]=ode15i(Yin, [0, 6*pi], y0, yp0);
plot(t, yt, 'bo-')
title('\it Simulation of: $$ t^2*\frac{dy}{dt}+t*(\frac{dy}{dt})^2+2*cos(t)=y^{-1}, y_0=\frac{1}{2} $$', 'interpreter', 'latex')
grid on; 
xlabel('\it t'), 
ylabel( '\it Solution, y(t)'), 
hold on

% Part 2. Another way of solving this problem is SIMULINK with    
% simulation start time  set at 1e-3 and end time set at 6*pi.
[t, Y_t]=sim('IMPLICIT_1ODE_EX1_sim', [1e-3 6*pi]);
plot(t, Y_t(:,1), 'rx--') 
legend('ode15i (script)', 'Simulink ode15s', 'location', 'best')
