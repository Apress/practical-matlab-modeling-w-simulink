function SOLVE_4order_ODE 
% HELP: EXE4orderODE.m (main function) and f4ode (nested function)
%      simulate the problem. 
close all
time=[0, 2*pi]; y0=[50, 40, 30, 20];
[t, y]=ode45(@f4ode, time, y0, odeset('reltol', 1e-8));
figure('name', 'Simulate with ODE45'), 
plot(t,y(:,1), 'b-', t,y(:,2), 'r--',t,y(:,3), 'k:',t,y(:,4), 'm-.','linewidth', 1.5)
legend('\it y(t)', '\it dy','\it ddy','\it dddy', 'location','best')
title('ODE45 Simulation of: $$ \frac{d^4y}{dt^4}+3*\frac{d^3y}{dt^3}-sin(t)*\frac{dy}{dt}+8*y=t^2 $$', 'interpreter', 'latex')
grid on, ylim([-700 300]), xlim([0, 2*pi])
xlabel('\it t')
ylabel('\it Solutions: $$ \frac{d^3y}{dt^3}, \frac{d^2y}{dt^2}, \frac{dy}{dt}, y(t) $$', 'interpreter', 'latex')
grid on
figure('name','Simulate with ODE23'); 
ode23(@f4ode, time, y0, odeset('reltol', 1e-8))
ylim([-700 300]), xlim([0, 2*pi])
legend('\it y(t)', '\it dy','\it ddy','\it dddy', 'location','best')
title('ODE23 Simulation of: $$ \frac{d^4y}{dt^4}+3*\frac{d^3y}{dt^3}-sin(t)*\frac{dy}{dt}+8*y=t^2 $$', 'interpreter', 'latex')
xlabel('\it t')
ylabel('\it Solutions: $$ \frac{d^3y}{dt^3}, \frac{d^2y}{dt^2}, \frac{dy}{dt}, y(t) $$', 'interpreter', 'latex')
grid on
function f=f4ode(t,y)
% The given 4th order ODE is: y""+3*y"'-sin(t)*y'+8*y=t^2
f=[y(2); y(3); y(4); t.^2-3.*y(4)+sin(t).*y(2)-8.*y(1)];
end
end