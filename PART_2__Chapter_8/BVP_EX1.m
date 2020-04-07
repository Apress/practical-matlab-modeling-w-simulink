clc; clearvars; close all
% BVP_EX1.m
%{
EXAMPLE 1. Given: y"+2y=exp(t) with BCs: y(0)=0, y(pi)=1.
HELP: 1st we need to rewrite the given problem equation 
as a set of 1-st order ODEs likewise to 2nd order IVP problems. 
Thus, we re-write it as:  dy/dt=[y2, exp(t)-2*y1]; 
dy/dt can be defined via a function file or inline or anonymous function.
%}
% Defined by anonymous function:
dy=@(t, y)([y(2); exp(t)-2*y(1)]);
% Define residues of BCs (Dirichlet BCs) via an anonymous function:
Res=@(yl, yr)([yl(1), yr(1)-1]);
% Create time space for simulation:
t = linspace(0, pi, 40);
% Create a guess structure consisting of an initial mesh 
% of 40 (opts) equally spaced points within [0,pi] and
% a guess of constant values y1=0  and y2=1 with this command: 
SOLin1 = bvpinit(t,[0 1]);
% Another initial guess (for fun): y1=2 and y2=1 
SOLin2 = bvpinit(t,[2 1]);
%{
NOTE: there are many problems that depend on initial guesses. 
Their behavior within BCs depend on how good/bad/lucky/unlucky guesses made. 
Making good initial guesses requires some considerable theoretical studies.
%}
% Obtain numerical solutions of the problem: 
SOL1 = bvp4c(dy,Res,SOLin1);
SOL2 = bvp4c(dy,Res,SOLin2);
y1 = deval(SOL1,t);
y2 = deval(SOL2,t);
figure 
plot(t, y1(1,1:end), 'ro-', t, y2(1, :),'bx-', 'linewidth', 1.5), 
grid minor; 
legend('\it Guess #1: y_1=1  & y_2=0 ',...
'\it Guess #2: y_1=2  & y_2=1', 'location', 'SouthWest')
xlabel( '\it t, time') 
ylabel( '\it y(t) solution values')
axis tight
syms y t d dt e
EQN = d^2*y/dt^2+2*y==e^t;
title('\it Solution of BVP: $\frac{d^2y}{dt^2}+2y=e^t$' , 'Interpreter',  'latex')
