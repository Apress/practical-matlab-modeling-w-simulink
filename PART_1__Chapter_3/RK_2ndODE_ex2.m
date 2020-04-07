% RK_2ndODE_ex2.m
% EXAMPLE 2. x"+9x'+6x=0 with ICs: x(0)=2, Dx(0)=0
% 4th Order RUNGE-KUTTA Method
clearvars; close all
h=0.2;                   % time step size
t0=0;                     % Start of calc's/simulations
tmax=3;                % End of calc's/simulations
t=t0:h:tmax;          % Time space
steps=length(t);    % How many steps of evaluations
u(1,:)=[2 0];           % Initial Conditions
% Runge-Kutta method
syms u1 u2          
f=[u2, -6.*u1-9*u2]; matlabFunction(f, 'file', 'RK_ex2');
for ii=1:steps-1
    k1=feval(@RK_ex2, u(ii,1), u(ii,2));
    k2=feval(@RK_ex2, u(ii,1)+h*k1(:,1)/2,u(ii,2)+h*k1(:,2)/2);
    k3=feval(@RK_ex2, u(ii,1)+h*k2(:,1)/2,u(ii,2)+h*k2(:,2)/2);
    k4=feval(@RK_ex2, u(ii,1)+h*k3(:,1),u(ii,2)+h*k3(:,2));
    u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t(:)', u(:,1), 'ko'), hold on
% Euler forward method
for k=1:steps-1
    f1=[u(k,2), -6*u(k,1)-9*u(k,2)];  
    u(k+1,:)=u(k,:)+f1*h;
end
plot(t, u(:,1), 'b--*')
% Analytical solution:
y=dsolve('D2x=-6*x-9*Dx', 'x(0)=2, Dx(0)=0','t');
Y=double(subs(y,'t',t)); plot(t, Y, 'g-', 'linewidth', 2)
grid on, xlabel('\it t'), ylabel('\it Solution, u(t)')
legend('RK: h = 0.2 ','EM: h = 0.2',  'Analytical (dsolve)')
title('Runge-Kutta, Euler Forward vs. Analytical Solutions of: $$ \frac{d^2}{dt^2}+9*\frac{du}{dt}+6*u=0 $$', 'interpreter', 'latex')
xlim([0, 3])
hold off; shg
