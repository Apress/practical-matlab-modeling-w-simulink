% Example1.m
%% Euler's Forward Method. 
% Part 1
clc; clearvars; close all;
t0=0;                       % Initial time 
tend=10;                 % End time
h=.05;                     % Time step size
t=t0:h:tend;             % Simulation time ranges
steps=length(t)-1;   % Number of steps
y0=1;                       % Initial Condition y0 at t0
f=zeros(size(t));      % Memory allocation
y1=[y0, f(1, end-1)]; % Memory allocation
for ii=1:steps
    f(ii)=3+exp(-t(ii))-2*y1(ii);
    y1(ii+1)=y1(ii)+f(ii)*h;
end
plot(t, y1, 'b-', 'linewidth', 1.5), grid on
xlabel('\it t')
ylabel('\it y(t)')
hold on
%% Euler's Improved method or Heun's method. 
% Part 2
%{ 
y(n+1)=y(n)+( f(tn,y(n)) + f(tn+h, y(n)+h*fn) )*0.5*h;
or different expression (STEP 6 changed from Euler's method):
k1 =f(t,y) = 3+exp(-t(ii))-2*y(ii);
k2 =f(t+h, y+h*k1) = 3 + exp(-(t(ii)+h))-2*(y(ii)+h*k1);
y(ii+1) = y(ii)+(h/2)*(k1(ii)+k2(ii))
%}
f(1) = 3 + exp(-t(1))-2*y0;
f=[f(1), zeros(1, steps-1)];   % Memory allocation
y2=[y0, zeros(1, steps-1)];    % Memory allocation
for jj=1:steps
    f(jj+1)=3+exp(-(t(jj)+h))-2*(y2(jj)+h*f(jj));
    y2(jj+1)=y2(jj)+(f(jj)+f(jj+1))*.5*h;
end
plot(t,y2, 'k--', 'linewidth',1.5)
%% Example1.m: EULER's backward method (1st order implicit)
% Part 3
f=zeros(1,steps);              % Memory allocation
T=zeros(1, steps);            % Memory allocation
yNEW=zeros(1,steps+1); % Memory allocation
y3=[y0, zeros(1,steps-1)];  % Memory allocation
for ii=1:steps
   T(ii+1)=T(ii)+h;
    f(ii)=3-2*y3(ii)+exp(-T(ii));
    yNEW(ii)=y3(ii)+h*f(ii);
    f(ii+1)=3-2*yNEW(ii)+exp(-T(ii+1));
    y3(ii+1)=y3(ii)+f(ii+1)*h;   
end
plot(T, y3, 'm-.','linewidth', 1.5),grid on
title('\it Solutions with Euler methods: $$ \frac{dy}{dt}+2*y-e^{-t}=3, y_0=1 $$', 'interpreter', 'latex')
legend('\it Euler forward ', '\it Euler improved', '\it Euler backward')
xlabel '\it t'; ylabel('\it Solution, y(t)'), shg

%% Euler's Backward Method (Another approach). Example1.m
% Part 4
% Memory allocation to speed up computation 
T=zeros(1, steps);             % Memory allocation
y4=[y0, zeros(1,steps-1)];  % Memory allocation
for ii=1:steps
    T(ii+1)=T(ii)+h;
    y4(ii+1)=(y4(ii)+h*(3+exp(-T(ii+1))))/(1+2*h);   
end
%%  2nd ORDER(explicit): Mid-Point Rule method 
% Example1.m: dy/dt=3-2*y+exp(-t); with ICs: y(0)=1.0
% Part 5
yp=zeros(1,steps);         % Memory allocation
y5=[y0, zeros(1,steps-1)];  % Memory allocation
f1=3-2*y5(1)+exp(-t(1));    
f=[f1, zeros(1, steps-1)];  % Memory allocation
for ii=1:steps
    yp(ii)=y5(ii)+(h/2)*f(ii);
    f(ii+1)=3-2*yp(ii)+exp(-(t(ii)+h/2));
    y5(ii+1)=y5(ii)+h*f(ii+1);
end
plot(t, y5, 'g:', 'linewidth', 2.2) 
title('\it Solutions of: $$ \frac{dy}{dt}+2*y-e^{-t}=3, y_0=1 $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, y(t)')
% Compute the analytical solution:
syms u(x) x
Du=diff(u, x);
Equation=Du==3+exp(-x)-2*u;
IC = u(0)==1;
u_sol=dsolve(Equation, IC);
Solution=vectorize(u_sol);
x=t;
Solution=eval(Solution);
plot(t, Solution, 'r-.', 'linewidth', 2)
legend('\it Euler forward ', '\it Euler improved', '\it Euler  backward',... 
    '\it Mid-point rule','\it Analytical Solution', 'location', 'SouthEast')
xlim([0, 5])
hold off
%% Combine all data of simulations from four methods
DATA = [t; y1; y2; y3; y4; y5; Solution];
fid = fopen('Example1_Out.dat','w');
fprintf(fid,'%2.2f  %4.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n',DATA);
fclose(fid);
type Example1_Out.dat  % View output data file

%% Ralston Method
% Part 6
k1=zeros(1,steps);         % Memory allocation
k2=zeros(1,steps);          % Memory allocation 
y6=[y0, zeros(1,steps)];  % Memory allocation
for jj=1:steps
    k1(jj) = 3 + exp(-t(jj))-2*y6(jj);
    k2(jj) = 3 + exp(-(t(jj)+3*h/4))-2*(y6(jj)+3*h*k1(jj)/4);
    y6(jj+1)=y6(jj)+(k1(jj)+2*k2(jj))*h/3;
end
figure
plot(t, y6, 'b-',t, y1, 'r--','linewidth', 2)
legend('\it Ralston method','\it Euler forward method'), grid on
title('\it Solutions of: $$ \frac{dy}{dt}+2*y-e^{-t}=3, y_0=1 $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, y(t)')
shg

%% 4th-Order RUNGE-KUTTA Method. Example1.m
% Part 7
% EXAMPLE. y'+2*y-exp(-t)=3 with ICs: y(0)=1. t=0...10.
%{
Step 6 changed from Euler's Method
      k_n1=f(t(n), y(n))
      k_n2=f(t(n)+h/2, yn+k_n1*h/2)
      k_n3=f(t(n)+h/2, yn+k_n2*h/2)
      k_n4=f(t(n)+h, yn+k_n3*h)
      y(n+1)=y(n)+h*(k_n1+2*k_n2+2*k_n3+k_n4)/6;
%}
k1=zeros(1,steps);         % Memory allocation
k2=k1;                             % Memory allocation 
k3=k1;                             % Memory allocation 
k4=k1;                             % Memory allocation 
y7=[y0, zeros(1,steps)];  % Memory allocation
for ii=1:steps
    k1(ii)=3+exp(-t(ii))-2*y7(ii);
    k2(ii)=3+exp(-(t(ii)+h/2))-2*(y7(ii)+k1(ii)*h/2);
    k3(ii)=3+exp(-(t(ii)+h/2))-2*(y7(ii)+k2(ii)*h/2);
    k4(ii)=3+exp(-(t(ii)+h))-2*(y7(ii)+k3(ii)*h);
    y7(ii+1)=y7(ii)+h*(k1(ii)+2*k2(ii)+2*k3(ii)+k4(ii))/6;
end
figure
plot(t, y7, 'k-.x', 'linewidth', 1.5), grid on
hold on
plot(t, Solution, 'r-', 'linewidth', 1.5)
legend('\it Runge-Kutta Method','\it Analytic solution')
title('\it Numerical Solutions of: $$ \frac{dy}{dt}+2*y-e^{-t}=3, y_0 = 1 $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, y(t)')
xlim([0, 5]), shg
hold off
%% Runge-Kutta-Gill method 
% EXAMPLE. y'+2*y-exp(-t)=3 with ICs: y(0)=1. t=0...10.
% Part 8
a=(sqrt(2)-1)/2; b=(2-sqrt(2))/2; c=-sqrt(2)/2; d=1+sqrt(2)/2;
y8=[y0, zeros(1, steps-1)]; 
for ii=1:steps
    k1(ii)=h*(3+exp(-t(ii))-2*y8(ii));
    k2(ii)=h*(3+exp(-(t(ii)+h/2))-2*(y8(ii)+k1(ii)*h/2));
    k3(ii)=h*(3+exp(-(t(ii)+h/2))-2*(y8(ii)+a*k1(ii)+b*k2(ii)));
    k4(ii)=h*(3+exp(-(t(ii)+h/2))-2*(y8(ii)+c*k2(ii)+d*k3(ii)));
   y8(ii+1)=y8(ii)+(k1(ii)+k4(ii))/6+(b*k2(ii)+d*k3(ii))/3;
end
DATA1 = [t; y1; y7; y8; Solution];
% Data export
fid1 = fopen('Example1_Out2.dat', 'w');
fprintf(fid1, 'time  Euler-F  Runge-K  RK-Gill Analytic \n');
fprintf(fid1,'%2.2f  %4.5f %4.5f %4.5f %4.5f\n',DATA1);
fclose(fid1);
type Example1_Out2.dat    % View the imported data on the command window

%% Runge-Kutta-Fehlberg Method implemented in Example1.m
% EXAMPLE. y'+2*y-exp(-t)=3 with ICs: y(0)=1. t=0...10.
% Part 9
F=@(t,y)(3-2*y+exp(-t));
y9=[y0, ones(1,steps-1)];  % Memory allocation
e=zeros(1, steps);             % Memory allocation
for n=1:steps
    k_n1=h*F(t(n), y9(n));
    k_n2=h*F(t(n)+h/4, y9(n)+k_n1/4);
    k_n3=h*F(t(n)+3*h/8, y9(n)+3*k_n1/32+9*k_n2/32);
    k_n4=h*F(t(n)+12*h/13, y9(n)+1932*k_n1/2197-...
        7200*k_n2/2197+7296*k_n3/2197);
    k_n5=h*F(t(n)+h, y9(n)+439*k_n1/216-8*k_n2+...
        3680*k_n3/513-845*k_n4/4104);
    k_n6=h*F(t(n)+h/2,y9(n)-8*k_n1/27+2*k_n2-...
        3544*k_n3/2565+1859*k_n4/4104-11*k_n5/40);
    y9(n+1)=y9(n)+(16*k_n1/135+6656*k_n3/12825+...
        28561*k_n4/56430-9*k_n5/50+2*k_n6/55);
    e(n)=k_n1/360-128*k_n3/4275-2197*k_n4/7524+k_n5/50+2*k_n6/55;
end
subplot(211)
% Analytical Solution of the problem using dsolve 
plot(t, y9, 'ko', t, Solution, 'r-', 'linewidth', 1.5)
legend('\it Runge-Kutta-Fehlberg Method','\it Analytic solution', 'location', 'southeast')
title('\it Numerical Solutions of: $$ \frac{dy}{dt}+2*y-e^{-t}=3, y_0 = 1 $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, y(t)')
xlim([0, 5]), grid on
subplot(212)
plot(e, 'r-', 'linewidth', 1.5), grid on
title('\it Global error: \epsilon')
xlabel('\it t'), ylabel('\it \epsilon(t)')
shg
