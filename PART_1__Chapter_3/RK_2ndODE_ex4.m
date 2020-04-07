% RK_2ndODE_ex4.m
% EXAMPLE 4. y"+y'=sin(t) with ICs: [1, 2]
clearvars; close all; clc
h=0.25;                 % Step size
t0=0;                     % Start of simulations
tmax=13;              % End of simulations
t=t0:h:tmax;          % Simulation time space
steps=length(t);    % Simulation steps
y(1,:)=[1, 2];          % Initial Conditions
% Runge-Kutta method:
for ii=1:steps-1
k1=[y(ii,2),             sin(t(ii))-y(ii,2)];
k2=[y(ii,2)+k1(:,1)*h/2, sin(t(ii)+h/2)-y(ii,2)+k1(:,2)*h/2]; 
k3=[y(ii,2)+k2(:,1)*h/2, sin(t(ii)+h/2)-y(ii,2)+k2(:,2)*h/2];
k4=[y(ii,2)+k3(:,1)*h,   sin(t(ii)+h)-y(ii,2)+k3(:,2)*h];
y(ii+1,:)=y(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t, y(:,1), 'k--', 'linewidth', 1.5) 
grid on; hold on 
% Euler forward method:
for ii=1:steps-1
y(ii+1,:)=y(ii,:)+h*[y(ii,2), sin(t(ii))-y(ii,2)];
end
plot(t, y(:,1), 'r-.+', 'linewidth', 1.5)
% Analytical solution:
y=dsolve('D2y=-Dy+sin(t)', 'y(0)=1, Dy(0)=2','t');
Y=double(subs(y,'t',t)); 
plot(t, Y, 'm-', 'linewidth', 1.5)
title('\it Runge-Kutta, Euler Methods vs. Analytical Solution of: $$ \frac{d^2u}{dt^2}=sin(t)-\frac{du}{dt} $$', 'Interpreter', 'latex')
xlabel '\it t'; ylabel '\it Solution, u(t)'
legend('Runge-Kutta: h = 0.25', 'Euler: h = 0.25', 'Analytical Solution', 'location', 'southeast')
hold off; axis tight; shg
