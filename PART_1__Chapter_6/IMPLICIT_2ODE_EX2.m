% IMPLICIT_2ODE_EX2.m
%{
EXAMPLE 2. IMPLICITLY expressed ODE problem: y"(t)+y(t)=0 with ICs: 
 y(0)=0, y'(0)=1.

In fact, the given problem is an explicitly defined IVP of a second order.
But for the sake of better understanding and easiness to explain 
the use of ODE15i, we have treated this problem as an IMPLICIT ODE. 
We first define the given ODE as two 1st order ODEs (as a state space 
representation).
F(t, y1,y2, dy1,dy2)=>dy1=y2;=>dy2+y1=0] ==>>{dy1-y2; dy2+y1}; 
NOTE: the difference(s) in defining functions (function file or handle)
 between implicit ODEs and explcit ODEs.                     
%}
clearvars; close all
% Part 1. ODE15i

 Fex2=@(t, y, dy)([dy(1)-y(2); dy(2)+y(1)]);
 y0=[0, 1]; dy0=[1, 0];          % ICs
 F_aty0=[0, 0]; F_atyd0=[];  % Function values at y0 and dy0
 Tspan=[0, 2*pi];                  % Time span

 % Find Consistent Initial Values:
 [y0, dy0]=decic(Fex2, 0, y0, dy0, F_aty0, F_atyd0);  

% Compute solutions of the problem with ode15i:
[t, y]= ode15i(Fex2, Tspan, y0, dy0);
 plot(t, y(:,1), 'bd-',t, y(:,2), 'rx-')
 hold on

% Part 2. ODE45
%%%% NOTE: differences between Fex2 and FEX2 anonymous. 
% function handles:

 FEX2=@(t, y)([y(2); -y(1)]);
 y0=0; dy0=1;                                 % ICs
 Tspan=[0, 2*pi];                             % Time span
 [time, Y]=ode45(FEX2,Tspan, [y0, dy0], []);
 plot(time, Y(:,1), 'kh--',time, Y(:,2), 'go--')
 title('\it ode15i vs. ode45: Solutions of y"(t)+y(t)=0')
 xlabel('\it t'), ylabel('\it Solutions:  y(t), $$ \frac{dy}{dt}$$', 'interpreter', 'latex'), grid

% Part 3. DSOLVE: Analytic solution 

 yt=dsolve('D2y+y=0', 'y(0)=0','Dy(0)=1', 't');
 Yt=vectorize(yt);
 Yt=subs(Yt, t);  % Alternative:  eval(Yt, t);
plot(t, Yt, 'c-', 'linewidth', 1.5)
legend('y(t) found via ode 15i',...
'dy found via ode15i','y(t) found via ode45',...
'dy found via ode45','y(t) Analytical solution', 'location', 'best')
