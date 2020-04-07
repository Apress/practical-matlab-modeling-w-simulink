%% STIFF_1ODE_EX2.m
close all; clearvars
%{
NOTE: The solution of this problem decays to zero. If a solver
produces a negative approximate solution, it begins to track the
solution of the ODE through this value, the solution goes off to
minus infinity, and the computation fails. Thus, using the NonNegative property of ODESET prevents this from happening. 
Nonnegativity is available for ode45, ode113 and not available for ode15i, ode15s, ode23s, ode23t, ode23tb.
%}
% x1=1; time=[0, 15];
tic;
opts=odeset('NonNegative',1,'reltol', 1e-3, 'abstol', 1e-5);
[t1, xODE45]=ode45(@(t,x)(-1000*x), [0, 15], 1, opts);
Time_ODE45=toc; fprintf('Time_ODE45 = %2.6f\n', Time_ODE45)
%% ODE15s MATLAB Stiff problem Solver 
clearvars 
tic;
opts=odeset('reltol', 1e-3, 'abstol', 1e-5);
[t, xODE15s]=ode15s(@(t,x)(-1000*x), [0, 15], 1, opts);
Time_ODE15s=toc; fprintf('Time_ODE15s = %2.6f\n', Time_ODE15s)
