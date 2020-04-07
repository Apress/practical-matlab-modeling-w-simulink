% Example2.m
%% ADAMS or ADAMS-Bashforth 2-step Method
% EXAMPLE 2. dy/dt=-2*t*(y^2); with ICs: y(0)=0.5
% Part 1.
Fn=0.5;              % ICs: u0 at t0
tend=10;             % max. time limit
h=.01;                 % time step size
t=0:h:tend;          % time space 
steps=length(t);  % number of steps
% NB: Dy = f(y,t)=-2*y^2*t defined via Function Handle 
Fcn=@(Fn,t)(-2*(Fn.^2).*t); 
% Memory allocation:
Fn=[Fn(1), zeros(1,steps-1)];
fn=[Fcn(Fn(1), t(1)),zeros(1,steps-1)];
for ii=1:steps-2
% EULER's method starts from here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii),t(ii));
% Adams-Bashforth method starts from here
fn(ii+2)=Fcn(Fn(ii+1),t(ii+1));
Fn(ii+2)=Fn(ii+1)+(h/2)*(3*fn(ii+1)-fn(ii));
end
figure
plot(t, Fn, 'r:+', 'linewidth', 2), hold on
syms u(T) T
Du = diff(u, T);
Equation=Du==-2*u^2*T;
IC=u(0)==0.5;
u=dsolve(Equation, IC);      % Analytical Solution:
U=vectorize(u);
T=t;
U=eval(U);   
A =plot(T, U);
A.Color=[.2 .5 .5];
A.LineWidth=A.LineWidth+1.5;
title('Solution of: $$ \frac{dy}{dt}+2*y^2*t=0,  y_0=0.5 $$', 'interpreter', 'latex')
legend('\it Adams-Bashforth Method 2-step solver', '\it Analytical solution') 
xlabel('\it t')
ylabel('\it Solution, y(t)')
grid on; shg
%% ADAMS-Bashforth 3-step Method
% EXAMPLE 2. dy/dt=-2*t*(y^2); with ICs: y(0)=0.5
% Part 2.
% NB: Dy = f(y,t)=-2*y^2*t defined via Function Handle 
Fcn=@(Fn,t)(-2*(Fn.^2).*t); 
% Memory allocation with ZERO matrices
Fn=[Fn(1), zeros(1,steps-1)];
fn=[Fcn(Fn(1),t(1)), zeros(1,steps-1)];
for ii=1:steps-3
% EULER's method is used here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii),t(ii));
% 2-step ADAMS-Bashforth method is used here
Fn(ii+2)=Fn(ii+1)+h*(1.5*Fcn(Fn(ii+1),t(ii+1))-0.5*Fcn(Fn(ii),t(ii)));
fn(ii+2)=Fcn(Fn(ii+2),t(ii+2)); 
% ADAMS-Bashforth method: 3-step starts from here
Fn(ii+3)=Fn(ii+2)+h*((23/12)*fn(ii+2)-(4/3)*fn(ii+1)+(5/12)*fn(ii));
end
plot(t, Fn, 'g:x', 'linewidth', 2), grid on
% ADAMS or ADAMS-Bashforth 4-step Method
Fcn=@(Fn,t)(-2*(Fn.^2).*t); 
% Memory allocation with ZERO matrices
Fn=[Fn(1), zeros(1,steps-1)];
fn=[Fcn(Fn(1),t(1)), zeros(1,steps-1)];
for ii=1:steps-4
% EULER's method is used here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii),t(ii));
% ADAMS-Bashforth method: 2-step
Fn(ii+2)=Fn(ii+1)+h*(1.5*Fcn(Fn(ii+1),t(ii+1))-0.5*Fcn(Fn(ii),t(ii)));
% ADAMS-Bashforth method: 3-step
Fn(ii+3)=Fn(ii+2)+h*((23/12)*fn(ii+2)-(4/3)*fn(ii+1)+(5/12)*fn(ii));
fn(ii+3)=Fcn(Fn(ii+3),t(ii+3));
% ADAMS-Bashforth method: 4-step starts from here
Fn(ii+4)=Fn(ii+3)+h*((55/24)*fn(ii+3)-... 
    (59/24)*fn(ii+2)+(37/24)*fn(ii+1)-(3/8)*fn(ii));
end
plot(t, Fn, 'm--', 'linewidth', 2), grid on
%  ADAMS-Bashforth 5-step Method
Fcn=@(Fn,t)(-2*(Fn.^2).*t); 
% Memory allocation with ZERO matrices
Fn=[Fn(1), zeros(1,steps-1)];
fn=[Fcn(Fn(1), t(1)), zeros(1,steps-1)];
for ii=1:steps-5
% EULER's method is used here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii),t(ii));
% ADAMS-Bashforth method: 2-step
Fn(ii+2)=Fn(ii+1)+h*(1.5*Fcn(Fn(ii+1),t(ii+1))-0.5*Fcn(Fn(ii),t(ii)));
% ADAMS-Bashforth method: 3-step
Fn(ii+3)=Fn(ii+2)+h*((23/12)*fn(ii+2)-(4/3)*fn(ii+1)+(5/12)*fn(ii));
% ADAMS-Bashforth method: 4-step
Fn(ii+4)=Fn(ii+3)+h*((55/24)*fn(ii+3)-(59/24)*fn(ii+2)+... 
    (37/24)*fn(ii+1)-(3/8)*fn(ii));
fn(ii+5)=Fcn(Fn(ii+4),t(ii+4));
% ADAMS-Bashforth method: 5-step starts from here
Fn(ii+5)=Fn(ii+4)+h*((1901/720)*fn(ii+4)-... 
    (1387/360)*fn(ii+3)+(109/30)*fn(ii+2)-... 
    (637/360)*fn(ii+1)+(251/720)*fn(ii));
end
plot(t, Fn, 'k-', 'linewidth', 2), grid on
title('Solution of: $$ \frac{dy}{dt}+2*y^2*t=0,  y_0=0.5 $$', 'interpreter', 'latex')
legend('AB Method 2-step', 'Analytical solution', 'AB Method 3-step',...
'AB Method 4-step', 'AB Method 5-step'), shg
