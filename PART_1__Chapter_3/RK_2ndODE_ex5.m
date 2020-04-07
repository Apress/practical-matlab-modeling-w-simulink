% RK_2ndODE_ex5.m
% EXAMPLE 5.  u"=-u'+sin(t*u) with ICs: u(0)=1 & u'(0)=2
clearvars; close all; clc
h=0.05;                % Step size
t0=0;                    % Start of simulations
tmax=15;             % End of simulations
t=t0:h:tmax;         % Simulation time space
steps=length(t);   % Simulation steps
u(1,:)=[1, 2];         % Initial Conditions
% Runge-Kutta Method: h = 0.05
for ii=1:steps-1
k1=[u(ii,2),             sin(u(ii,1)*t(ii))-u(ii,2)];
k2=[u(ii,2)+k1(:,1)*h/2, sin(u(ii,1)*t(ii)+h/2)-... 
    u(ii,2)+k1(:,2)*h/2]; 
k3=[u(ii,2)+k2(:,1)*h/2, sin(u(ii,1)*t(ii)+h/2)- ...
    u(ii,2)+k2(:,2)*h/2];
k4=[u(ii,2)+k3(:,1)*h,   sin(u(ii,1)*t(ii)+h)-u(ii,2)+k3(:,2)*h];
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
subplot(211)
plot(t(:)', u(:,1), 'k--x'), grid on; hold on
title('Runge-Kutta vs. Euler Solutions of: $$ \frac{d^2u}{dt^2}+\frac{du}{dt}=sin(t*u) $$', 'interpreter', 'latex')
xlabel '\it t'; ylabel '\it Solution, u(t)'
 
clearvars t u k1 k2 k3 k4
h=0.01;            % Step size
t=t0:h:tmax; steps=length(t);    u(1,:)=[1, 2]; 
% Runge-Kutta Method: h = 0.01
for ii=1:steps-1
k1=[u(ii,2),             sin(u(ii,1)*t(ii))-u(ii,2)];
k2=[u(ii,2)+k1(:,1)*h/2, sin(u(ii,1)*t(ii)+h/2)-... 
    u(ii,2)+k1(:,2)*h/2]; 
k3=[u(ii,2)+k2(:,1)*h/2, sin(u(ii,1)*t(ii)+h/2)-... 
    u(ii,2)+k2(:,2)*h/2];
k4=[u(ii,2)+k3(:,1)*h,   sin(u(ii,1)*t(ii)+h)-u(ii,2)+k3(:,2)*h];
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
subplot(212)
plot(t(:)', u(:,1), 'k--x'), hold on
clearvars -except t0 tmax
h=0.05;            % Step size
t=t0:h:tmax; 
steps=length(t);    
u(1,:)=[1, 2]; 
% Euler forward method: h = 0.05
for ii=1:steps-1
u(ii+1,:)=u(ii,:)+h*[u(ii,2), sin(u(ii,1)*t(ii))-u(ii,2)];
end
subplot(211)
plot(t(:)', u(:,1), 'r-', 'linewidth', 1.5), grid on
legend('RK: h = 0.05', 'EM: h = 0.05')
clearvars t u 
h=0.01;            % Step size
t=t0:h:tmax; 
steps=length(t);     
u(1,:)=[1, 2]; 
% Euler forward method: h = 0.01
for ii=1:steps-1
u(ii+1,:)=u(ii,:)+h*[u(ii,2), sin(u(ii,1)*t(ii))-u(ii,2)];
end
subplot(212)
plot(t(:)', u(:,1), 'r-', 'linewidth',1.5), grid on
xlabel '\it t'; ylabel '\it Solution, u(t)'
legend( 'RK: h = 0.01',  'EM: h = 0.01')
hold off; axis tight; shg
