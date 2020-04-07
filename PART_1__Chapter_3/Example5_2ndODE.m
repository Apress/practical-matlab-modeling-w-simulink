% Example5_2ndODE.m
%% EXAMPLE 5.  u"=-u'+sin(t*u) with ICs: u(0)=1 & u'(0)=2
% solved by Forward EULER  Method
clearvars; clc; close all
h1=0.025;            % Time step size
tmax=13;             % End of simulations
t0=0;                    % Start of simulations
t=t0:h1:tmax;       % Time space
steps=length(t);   % How many steps of evaluations
u(1,:)=[1 2];          % Initial Conditions
% NB: Size of the u(t) is two-dimensional 
% Direct method (direct expression)
for k=1:steps-1
    f1=[u(k,2), -u(k,2)+sin(t(k)*u(k,1))];
    u(k+1,:)=u(k,:)+f1*h1;
end
plot(t, u(:,1),'b-', 'linewidth', 2), grid minor
hold on
clearvars t u
h2=0.05;              % Time step size
t=t0:h2:tmax; 
steps=length(t);   
u(1,:)=[1 2];          % Initial Conditions
% Way # 2. Anonymous function (@)
F = @(t, u1, u2)([u2, -u2+sin(t*u1)]);
for k=1:steps-1
      u(k+1,:)=u(k,:)+F(t(k), u(k,1), u(k,2))*h2;
end
plot(t, u(:,1),'g-.', 'linewidth', 2), grid on
clearvars t u
h3=0.1;                   % Step size
t=t0:h3:tmax;          % Time space
steps = numel(t);    % Number of steps
u(1,:)=[1 2];             % Initial Conditions
% Way # 3. MatlabFunction
syms T u1 u2 
 F=[u2, -u2+sin(T*u1)];
 matlabFunction(F, 'file', 'F5');
for k=1:steps-1
    u(k+1,:)=u(k,:)+h3*feval(@F5, t(k), u(k,1), u(k,2));
end
plot(t, u(:,1),'r:', 'linewidth', 2), grid on
clearvars t u
h4=0.2;                   % Step size
t=t0:h4:tmax;           % Time space
steps = numel(t);     % Number of steps
u(1,:)=[1 2];              % Initial Conditions
% Way # 4. Function File: FuFu5.m
for k=1:steps-1
     u(k+1,:)=u(k,:)+h4*feval(@FuFu5, t(k), u(k,1), u(k,2));
end
plot(t, u(:,1),'k--', 'linewidth', 2), grid on
title('\it Numerical Solutions of: $$ \frac{d^2u}{dt^2}=sin(t*u)-\frac{du}{dt}, u_0 = 1, du_0 = 2 $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, u(t)')
xlim([0, 23])
legend('h = 0.025', 'h = 0.05', 'h = 0.1', 'h = 0.2', 'location', 'southeast')
axis tight
 function du = FuFu5(T, u1, u2)
du = [u2, -u2+sin(T*u1)];
end
