% EXAMPLE 3. Non-zero starting initial condition based problem         
% simulated via ODE23s.
% ODEx_solvers_EX3.m
% Given:  t*y"+2y'+4y=4 with ICs: y(1)=1, y'(1)=1
% NB: simulation start point is not "0" but 1
t=[1,50];  % NB: Simulation is to start at 1.
y_s=inline('[y(2); (1/t)*(4-2*y(2)-4*y(1))]', 't', 'y');
ICs=[1, 1];
options=odeset('reltol', 1e-6);
[time, y_sol]=ode45(y_s, t, ICs, options);
plot(time, y_sol(:,1),'r', 'linewidth', 2), grid on
title('Simulation of t*ddy+2dy+4y=4 with ICs y(1)=1, dy(1)=1')
xlabel('Time, t'), ylabel('Solution, y(t)'), ylim([.8 1.35]), shg
hold on
% Simulation via SIMULINK: ode23
opts=simset('reltol',1e-6,'solver', 'ode23');
K=4;
sim('ICs_non_Zero_2ODE', [1, 50], opts);
plot(SIM_outs(:,1), SIM_outs(:,2), 'bo-' ,'linewidth', 1)
legend('ode45', 'Simulink ode23', 0)
hold off
