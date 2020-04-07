% RK_2ndODE_ex1.m
% EXAMPLE 1. (1/2)*u"+(2/5)*u'+u=2*t with ICs: u(0)=1 & u'(0)=2
% by 4th Order RUNGE-KUTTA Method and DSOLVE
clearvars; close all
h=0.1;                    % time step size
t0=0;                      % Start of calc's/simulations
tmax=5;                 % End of calc's/simulations
t=t0:h:tmax;           % Time space
steps=length(t);     % Number of steps
u(1,:)=[1 2];            % Initial Conditions
% NB: Size of u(t) is two-dimensional.
% Way #1. Anonymous Function (@)
FuFu=@(t, u1, u2)([u2, 4*t-2*u1-(4/5)*u2]);   
%%% for Way #1 Anonymous Function (@) FuFu: 
for ii=1:steps-1
k1=FuFu(t(ii), u(ii,1), u(ii,2));
k2=FuFu(t(ii)+h/2, u(ii,1)+h*k1(:,1)/2,u(ii,2)+h*k1(:,2)/2);
k3=FuFu(t(ii)+h/2,u(ii,1)+h*k2(:,1)/2,u(ii,2)+h*k2(:,2)/2);
k4=FuFu(t(ii)+h,u(ii,1)+h*k3(:,1),u(ii,2)+h*k3(:,2));
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t(:)', u(:,1), 'b:o', 'markersize', 9), grid on, hold on
clearvars t u
h=0.2;       % time step size
t=t0:h:tmax; steps=length(t);    u(1,:)=[1 2];   
% Way #2. Function file called: F_RK_ex1.m  
%%% with the function file called F.m  % Way #2  
for ii = 1:steps-1
k1=feval(@RK_ex1,t(ii), u(ii,1), u(ii,2));
k2=feval(@RK_ex1,t(ii)+h/2,u(ii,1)+h*k1(:,1)/2,u(ii,2)+h*k1(:,2)/2);
k3=feval(@RK_ex1,t(ii)+h/2,u(ii,1)+h*k2(:,1)/2,u(ii,2)+h*k2(:,2)/2);
k4=feval(@RK_ex1,t(ii)+h,u(ii,1)+h*k3(:,1),u(ii,2)+h*k3(:,2));
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t(:)', u(:,1), 'g-p')
clearvars  t u
h=0.3;       % time step size
t=t0:h:tmax; steps=length(t);    u(1,:)=[1 2];   
% Way #3. matlabFunction 
 syms T u1 u2 
 f=[u2, 4*T-2.0*u1-(4/5)*u2];
 matlabFunction(f, 'file', 'F_ex1');
%%% with a function file F
for ii = 1:steps-1
k1 = feval(@F_ex1, t(ii), u(ii,1), u(ii,2));
k2 = feval(@F_ex1, t(ii), u(ii,1)+h*k1(:,1)/2,u(ii,2)+h*k1(:,2)/2);
k3 = feval(@F_ex1, t(ii), u(ii,1)+h*k2(:,1)/2,u(ii,2)+h*k2(:,2)/2);
k4 = feval(@F_ex1, t(ii), u(ii,1)+h*k3(:,1),u(ii,2)+h*k3(:,2));
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t(:)', u(:,1), 'r--h', 'linewidth', 2)
clearvars  t u
h=0.4;       % time step size
t=t0:h:tmax; steps=length(t);    u(1,:)=[1 2];   
% Way # 4. Direct Way 
for ii = 1:steps-1
k1 = [u(ii,2), 4*t(ii)-2*u(ii,1)-(4/5)*u(ii,2)];
k2 = [u(ii,2)+h*k1(:,1)/2, 4*(t(ii)+h/2)-... 
    2*(u(ii,1)+h*(k1(:,1))/2)-(4/5)*(u(ii,2)+h*k1(:,2)/2)]; 
k3 = [u(ii,2)+h*k2(:,1)/2,    4*(t(ii)+h/2)- ... 
    2*(u(ii,1)+h*k2(:,1)/2)-(4/5)*(u(ii,2)+h*k2(:,2)/2)]; 
k4 = [u(ii,2)+h*k3(:,1), 4*(t(ii)+h)-2*(u(ii,1)+h*k3(:,1))- ... 
    (4/5)*(u(ii,2)+k3(:,2)*h)];         
u(ii+1,:)=u(ii,:)+h*(k1+2*k2+2*k3+k4)/6;
end
plot(t(:)', u(:,1), 'm-.d', 'linewidth', 1.5)
% Analytical solution of the problem:
y=dsolve('D2x=-(4/5)*Dx-2*x+(4*t)', 'x(0)=1, Dx(0)=2','t');
Y=double(subs(y,'t',t));
plot(t, Y, 'k-', 'linewidth', 1.5)
legend('h = 0.1','h = 0.2','h = 0.3','h = 0.4', 'Analytical Solution', 'location', 'southeast')
title('\it Runge-Kutta Solutions vs. Analytical Solutions: $$ \frac{1}{2}*\frac{d^2u}{dt^2}+\frac{2}{5}*\frac{du}{dt}=2*t$$', 'interpreter', 'latex')
xlim([0, 5]) 
xlabel('\it t') 
ylabel('\it Solution, u(t)')
hold off

function f=RK_ex1(t, u1, u2) 
f = [u2,4*t-2.0*u1-(4/5)*u2];
end