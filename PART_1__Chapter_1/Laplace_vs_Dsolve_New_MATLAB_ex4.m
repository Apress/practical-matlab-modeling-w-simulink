% ODE_Laplace_New_MATLAB_vers.m
clearvars; clc; close all
% Step #1. Define symbolic variables' names
syms t s Y y(t) Dy(t)
assume([t, Y]>0);
Dy=diff(y,t);
ODE1=Dy==-2*y(t);
% Step #2. Laplace Transforms
LT_A=laplace(ODE1, t, s);
% Step #3. Substitute the arbitrary unknown Y and IC(s)
LT_A=subs(LT_A,laplace(y,t, s),Y);
LT_A=subs(LT_A, y(0), 0.5);
% Step #4. Solve for the arbitrary unknown Y 
Y=solve(LT_A, Y);
disp('Laplace Transforms of the given ODE with ICs'); disp(Y)
% Step #5. Evaluate the Inverse Laplace Transform
Solution_Laplace=ilaplace(Y);
disp('Solution found using Laplace Transforms: ')
pretty(Solution_Laplace)
% Step #6. Compute numerical values and plot them 
t=0:.01:2.5; LTsol=eval(vectorize(Solution_Laplace));
figure, semilogx(t, LTsol, 'ro-')
xlabel('t'), ylabel('solution values')
title('laplace/ilaplace vs. dsolve ')
grid on; hold on
% Compare with dsolve solution method
IC=y(0)==0.5;
Y_d=dsolve(ODE1, IC); 
disp('Solution with dsolve')
pretty(Y_d); Y_sol=eval(vectorize(Y_d));
plot(t,Y_sol, 'b-', 'linewidth', 2), grid minor
legend('laplace+ilaplace', 'dsolve') 
hold off; axis tight
