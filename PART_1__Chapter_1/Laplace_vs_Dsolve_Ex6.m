% Laplace_vs_Dsolve_Ex6.m
clearvars, clc, close all
% Step 1. Introduce symbolic variables
syms t s Y y(t)  Dy(t)
assume([t  Y]>0);
Dy=diff(y, t);
D2y=diff(y, t, 2);
% Define Equation
Equation=2*D2y+3*Dy^3==cos(100*t)*abs(y(t))-2;
% Step 2. Laplace Transforms
LT_Y=laplace(Equation, t, s);
% Step 3. Substitute the arbitrary unknown Y and ICs
LT_Y=subs(LT_Y,laplace(y(t),t, s),Y);
LT_Y=subs(LT_Y,y(0),1);
LT_Y=subs(LT_Y,subs(diff(y(t), t), t),0);
% Step 4.  Solve for Y unknown
Y=solve(LT_Y, Y); 
% Step 5. Compute the inverse Laplace transform 
disp('Laplace Transforms of the given ODE with ICs'); disp(Y)
Solution_Laplace=ilaplace(Y);
disp('Solution found using Laplace Transforms: ')
pretty(Solution_Laplace)
%  Solution with dsolve():
syms t y(t) Dy(t)
Dy=diff(y, t);
D2y=diff(y, t, 2);
% Define Equation
Equation=2*D2y+3*Dy^3==cos(100*t)*abs(y(t))-2;
ICs = [y(0)==0, Dy(0)==0];
Solution=dsolve(Equation, ICs);
pretty(Solution)


