clearvars, close all
% ODE2_solversEX2.m
t0=0;              % Start of calc's/simulations
tmax=9;            % End of calc's/simulations
t=[t0, tmax];
u(1,:)=[2 0];      % Initial Conditions
% 4/5 order RUNGGE-KUTTA based MATLAB ode45 solver 
Fun1 = inline('[u(2); -6*u(1)-9*u(2)]','t', 'u');
[T1, U1]=ode45(Fun1, t, u, []);
plot(T1, U1(:,1), 'rx'), grid on
hold on

%% ode15s stiff problem solver:
Fun2=@(t, u)([u(2); -6*u(1)-9*u(2)]);
[T2, U2]=ode15s(Fun2, t, u,[]);
plot(T2, U2(:,1), 'bo')
%% ADAMS Higher Order MATLAB ode113 solver
[T3, U3]=ode113(Fun2, t, u,[]);
plot(T3, U3(:,1), 'k-.', 'linewidth', 2)
legend('ode45', 'ode15s', 'ode113',0)
title('Simulation: ddy+9dy+6y=0. ode45, ode15s, ode113')
xlabel('Time, t')
ylabel('Solution, u(t)')
