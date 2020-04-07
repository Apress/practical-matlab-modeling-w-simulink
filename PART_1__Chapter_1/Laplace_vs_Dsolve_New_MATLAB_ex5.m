% Laplace_vs_Dsolve_New_MATLAB_ex5.m
% %%   LAPLACE TRANSFORMS 
% Given: y"+y'=sin(t) with ICs: [1, 2] for y(0) & y'(0).
clearvars, clc, close all
% Step 1. Define names of the symbolic variables
syms t s Y y(t) Dy(t)
Dy=diff(y, t);
D2y=diff(y, t, 2);
assume([t, Y]>0);
% Define the given ODE equation
Equation=D2y+Dy==sin(t);
% Step 2. Laplace Transform
LT_A=laplace(Equation, t, s);
% Step 3. Substitute the arbitrary unknown Y and ICs
LT_A=subs(LT_A,laplace(y(t),t, s),Y);
LT_A=subs(LT_A,y(0),1);                             % IC: y(0)=1
LT_A=subs(LT_A,subs(diff(y(t), t), t, 0), 2);   % IC: dy(0)=2
% Step 4.  Solve for the arbitrary unknown Y 
Y=solve(LT_A, Y); 
disp('Laplace Transforms of the given ODE with ICs'); disp(Y)
% Step 5.  Compute the inverse of laplace Transform 
Solution_Laplace=ilaplace(Y);
disp('Solution found using Laplace Transforms: ')
pretty(Solution_Laplace); t=0:.01:13;
LTsol=eval(vectorize(Solution_Laplace));
figure, plot(t, LTsol, 'ro-'); xlabel('\it t'), 
ylabel('\it Solution y(t)')
title('\it laplace/ilaplace vs. dsolve Solutions: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}=sin(t)$$', 'interpreter', 'latex');
hold on
% dsolve solution method
syms t y(t) 
Dy=diff(y, t);
D2y=diff(y, t, 2);
% Define the given ODE equation
Equation=D2y+Dy==sin(t);
% Define Initial Conditions
ICs = [y(0)==1, Dy(0)==2];
Y=dsolve(Equation, ICs);
disp('Solution with dsolve:  '); 
pretty(Y); 
t=0:.01:13;
Y_sol=eval(vectorize(Y));
plot(t,Y_sol, 'b-', 'linewidth', 2); grid minor
legend('\it laplace+ilaplace', '\it dsolve', 'location', 'southeast'); hold off
