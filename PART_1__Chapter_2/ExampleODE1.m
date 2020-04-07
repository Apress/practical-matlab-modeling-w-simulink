%%  ExampleODE1.m 
% Part 1
% dy/dt=-2*t*(y^2); with ICs: y(0)=0.5
% We test methods for simulation time
clearvars; close all; clc;
F=@(t,y)(-2*y^2*t);
tmax=10;        % max. time limit
h=0.1;             % time step size is defined by a user!!!
t=0:h:tmax;     % time space 
y0=0.5;            % ICs: y0 at t0
[time Yode45]=ode45(F, t, y0);
[time Yode23]=ode23(F, t, y0);
[time Yode113]=ode113(F, t, y0);
plot(time, Yode45, 'ks-', time, Yode23, 'ro-.',time, Yode113,'bx--'), grid on
title('\it Solutions of: $$\frac{dy}{dt}+2*t^2=0, y_0 = 0.5$$', 'interpreter', 'latex')
legend ('ode45','ode23','ode113')
xlabel('\it t'), ylabel('\it Solution, y(t)'), shg

%%  ExampleODE1.m 
% Part 2
clearvars; close all
F=@(t,y)(-2*y^2*t);
tmax=10;           % max. time limit
t=[0,tmax];         % time space 
y0=0.5;              % ICs: y0 at t0
tic;
[time, Yode45]=ode45(F, t, y0);
Tode45=toc;
fprintf('Tode45= %2.6f  \n', Tode45)
clearvars 
%
F=@(t,y)(-2*y^2*t);
tmax=10;           % max. time limit
t=[0,tmax];         % time space 
y0=0.5;              % ICs: y0 at t0
tic
[time, Yode23]=ode23(F, t, y0);
Tode23=toc;
fprintf('Tode23= %2.6f  \n', Tode23)
clearvars 
%
F=@(t,y)(-2*y^2*t);
tmax=10;           % max. time limit
t=[0,tmax];         % time space 
y0=0.5;              % ICs: y0 at t0
tic
[time, Yode113]=ode113(F, t, y0);
Tode113=toc;
fprintf('Tode113= %2.6f \n', Tode113)

%%  ExampleODE1.m 
% Part 3
% Forward EULER method (1st order explicit)
% EXAMPLE #2: dy/dt=-2*t*(y^2); with ICs: y(0)=0.5
clearvars; close all
tic
tmax=10;              % max. time limit
h=0.001;               % time step size
t=0:h:tmax;           % time space 
steps=length(t)-1; % # of steps
y0=0.5;                  % ICs: y0 at t0
f=zeros(1,length(t));       % Memory allocation 
y=[y0, zeros(1,steps)];   % Memory allocation 
for ii=1:steps
    f(ii)=-2*y(ii).^2*t(ii);
    y(ii+1)=y(ii)+h*f(ii);
end
TEf=toc;
fprintf('TEf= %2.6f \n', TEf)
clearvars f y0 h t TEf steps tmax ii 
%%
tic
F=@(t,y)(-2*y^2*t);
tmax=10;            % max. time limit
h=.001;               % time step size
t=0:h:tmax;         % time space 
y0=0.5;               % ICs: y0 at t0
[time, Yode23]=ode23(F, t, y0);
Tode23=toc;
fprintf('Tode23= %2.6f \n', Tode23)
% Analytical solution:
syms u(T)  T
Du = diff(u, T);
Equation=Du==-2*u^2*T;
IC = u(0)==0.5;
u=dsolve(Equation,IC);
U=double(subs(u,'T',t));
plot(t, y, 'b-', t, Yode23, 'r-.', t, U, 'm:', 'linewidth',1.5)
xlim([1.399 1.3996])
grid on
legend('\it Euler forward', '\it ode23', '\it Analytical solution')
title('\it Solutions of: $$frac{dy}{dt}+2*t*y^2=0, y_0=0.5 $$', 'interpreter', 'latex')
shg
