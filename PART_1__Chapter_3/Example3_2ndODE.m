% Example3_2ndODE.m
%% EXAMPLE 3.  u"=-sin(t) with ICs: u(0)=0 & u'(0)=0 
% solved by forward EULER Method and DSOLVE
clc, clearvars; close all
h=0.1;                   % Time step size
tend=13;               % End of calc's/simulations
t0=0;                     % Start of calc's/simulations
t=t0:h:tend;           % Time space
steps=length(t);    % How many steps of evaluations
u(1,:)=[0 0];           % Initial Conditions
for k=1:steps-1
f1=[u(k,2), -sin(t(k))];  
u(k+1,:)=u(k,:)+f1*h;
end
plot(t', u(:,1),'bo') 
hold on, axis tight
clearvars u
% Analytical solution of the problem:
syms u(T) T
Du=diff(u, T);
D2u=diff(u, T, 2);
Equation=D2u==-sin(T);
ICs = [u(0)==0, Du(0)==0];
u=dsolve(Equation, ICs);
U=vectorize(u); 
T=t; 
U=eval(U);
plot(T, U, 'k-', 'linewidth', 2), grid on
legend('Euler forward', 'Analytic (dsolve)')
title('\it Solutions of: $$ \frac{d^2u}{dt^2}+sin(t)=0, u_0=0, du(0)=0 $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, u(t)')
shg