% RK_2ndODE_ex3.m
% EXAMPLE 3. u"=-sin(t) with ICs: u(0)=0 & u'(0)=0
clearvars; close all; clc
h=0.3;                 % Step size
t0=0;                    % Start of simulations
tmax=13;             % End of simulations
t=t0:h:tmax;         % Simulation time space 
steps=length(t);   % Simulation steps
u(1,:)=[0, 0];         % Initial Conditions
% Runge-Kutta Method:
FF=@(t, u1, u2)([u2,-sin(t)]);   
for ii=1:steps-1
k1=FF(t(ii), u(ii,1), u(ii,2));
k2=FF(t(ii)+h/2, u(ii,1)+h*k1(:,1)/2,u(ii,2)+h*k1(:,2)/2);
k3=FF(t(ii)+h/2,u(ii,1)+h*k2(:,1)/2,u(ii,2)+h*k2(:,2)/2);
k4=FF(t(ii)+h,u(ii,1)+h*k3(:,1),u(ii,2)+h*k3(:,2));
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t, u(:,1), 'k--+'), grid on; hold on
% Euler forward method:
for ii=1:steps-1
u(ii+1,:)=u(ii,:)+h*[u(ii,2), -sin(t(ii))];
end
plot(t, u(:,1), 'r-.p')
% Analytical solution:
y=dsolve('D2y=-sin(t)', 'y(0)=0, Dy(0)=0','t');
Y=double(subs(y,'t',t)); 
plot(t, Y, 'm-', 'linewidth', 1.5)
title('Runge-Kutta, Euler Forward vs. Analytical Solutions of: $$ \frac{d^2}{dt^2}+sin(t)=0 $$', 'interpreter', 'latex')
xlabel '\it t'; ylabel '\it Solution, u(t)'
legend('RK: h = 0.3', 'EM: h = 0.3', 'DSOLVE')
hold off; axis tight; shg
