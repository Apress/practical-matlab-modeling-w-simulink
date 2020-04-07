clearvars; close all
% ODE2_solvers.m
t0=0;       % Start of calc's/simulations
tmax=13;    % End of calc's/simulations
t=[t0, tmax];
u(1,:)=[1 2];      % Initial Conditions

%% RUNGGE-KUTTA 4/5 Order based MATLAB ode45 solver 
Fun1 = inline('[u(2); 4*t-2*u(1)-u(2).*(4/5)]','t', 'u');
[T1, U1]=ode45(Fun1, t, u, []);
plot(T1, U1(:,1), 'r-', 'linewidth', 2), grid minor
hold on

%% RUNGGE-KUTTA 2/3 Order based MATLAB ode23 solver
Fun2=@(t, u)([u(2); 4*t-u(1).*2-u(2).*(4/5)]);
[T2, U2]=ode23(Fun2, t, u);
plot(T2, U2(:,1), 'b--', 'linewidth', 2)

%% ADAMS Higher Order based MATLAB ode113 solver
[T3, U3]=ode113(@Fun3, t, u);
plot(T3, U3(:,1), 'k-.', 'linewidth', 2)
legend('ode45', 'ode23', 'ode113', 0)
title('Simulation: (1/2)ddy+(2/5)dy+y=2t. ode45, ode23, ode113')
xlabel('Time, t')
ylabel('Solution, u(t)')
