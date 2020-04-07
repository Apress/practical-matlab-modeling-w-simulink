% BVP_EX3.m
% Problem 1. Given: y"+2y=0
% Part 1. BCs: y(0)=1, dy(pi)=0. Robin BC.
clearvars; clc; close all
dy=@(t, y)([y(2), -2*y(1)]);
% Define residues of BCs:
Res=@(yl, yr)([yl(1)-1, yr(2)]);
% Create guess structures:
SOLin1 = bvpinit(linspace(0,pi,40),[1 0]);
% Another initial guess:
SOLin2 = bvpinit(linspace(0,pi,40),[2 1]);
% Obtain the solutions of the problem: 
SOL1guess = bvp4c(dy,Res,SOLin1);
SOL2guess = bvp4c(dy,Res,SOLin2);
t = linspace(0,pi, 40);
y1 = deval(SOL1guess,t);
y2 = deval(SOL2guess,t);
plot(t, y1(1,1:end), 'mp', t, y2(1, :),'k-', 'linewidth', 2.0), 
grid on; axis tight; hold on
% Problem 2. Given: y"+2y=0
% Part 2. BCs: y(0)=1, y(pi)=0. Dirichlet BC
%{
Rewrite the given problem equation as a set of 1st order ODEs:
dydt=[y2, 2*y1];
Define dydt with an anonymous function:
%}
dy=@(t,y)([y(2), -2*y(1)]);
% Define residues of BCs:
Res=@(yl, yr)([yl(1)-1, yr(1)]);
%{
Create a guess structure consisting of an initial mesh 
of 40 (opts) equally spaced points in [0,pi] (in the range of BCs) 
and a guess of constant values y1=1  and y2=0 as follows:
%}
SOLin1 = bvpinit(linspace(0,pi,40),[1 0]);
% Another initial guess is taken: y1=2 and y2=1 
SOLin2 = bvpinit(linspace(0,pi,40),[2 1]);
% NOTE: there are many problems very much dependent on 
% initial guesses.  
% Obtain solutions of the problem: 
SOLs1GUESS = bvp4c(dy,Res,SOLin1);
SOLs2GUESS = bvp4c(dy,Res,SOLin2);
t = linspace(0,pi, 40);
y1 = deval(SOLs1GUESS,t);
y2 = deval(SOLs2GUESS,t);
plot(t, y1(1,1:end), 'bo', t, y2(1, :), 'r', 'linewidth',2) 
legend('\it Prob1: Guess #1 [y1=1 & y2=0] ',...
'\it Prob1: Guess #2 [y1=2 & y2=1]', ...
'\it Prob2: Guess #1 [y1=1 & y2=0] ', ...
'\it Prob2: Guess #2 [y1=2  & y2=1]', ...
'location', 'southwest')
xlabel '\it t', ylabel '\it y(t) solution values'
title('Solution of BVP: $\frac{d^2y}{dt^2}+2y=0$', 'interpreter', 'latex')
gtext('Problem 1: y(0)=1, y(\pi)=0')
gtext('Problem 2: ; y(0)=1,dy(\pi)=0')
hold off

