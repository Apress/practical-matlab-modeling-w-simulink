% Laplace_vs_Dsolve_old_MATLAB_ex5.m
% %%   LAPLACE TRANSFORMS 
% Given: y"+y'=sin(t) with ICs: [1, 2] for y(0) & y'(0).
clearvars, clc, close all
syms t s Y
ODE2nd='D(D(y))(t)+D(y)(t)-sin(t)';
% Step 1. Laplace Transforms
LT_A=laplace(ODE2nd, t, s);
% Step 2. Substitute ICs and initiate an unknown Y
LT_A=subs(LT_A,{'laplace(y(t),t, s)','y(0)','D(y)(0)'},{Y,1,2});
% Step 3.  Solve for Y unknown
Y=solve(LT_A, Y); 
disp('Laplace Transforms of the given ODE with ICs'); disp(Y)
Solution_Laplace=ilaplace(Y);
disp('Solution found using ilaplace/laplace: ')
pretty(Solution_Laplace); t=0:.01:13;
LTsol=eval(vectorize(Solution_Laplace));
figure, plot(t, LTsol, 'ro-'); 
xlabel('\it t'), 
ylabel('\it Solution y(t)')
ylabel('\it Solution y(t)')
title('\it laplace/ilaplace vs. dsolve Solutions: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}=sin(t)$$', 'interpreter', 'latex');
hold on
% dsolve solution method
Y=dsolve('D2y+Dy=sin(t)', 'y(0)=1, Dy(0)=2', 't');
disp('Solution with dsolve:  '); 
pretty(Y); Y_sol=eval(vectorize(Y));
plot(t,Y_sol, 'b-', 'linewidth', 2); grid minor
legend('laplace+ilaplace', 'dsolve', 'location', 'southeast'); hold off
