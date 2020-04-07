% IMPLICIT_2ODE_EX5.m
%{
EXAMPLE 5. Implicitly defined problem:  y*(y")^2=exp(2*x) with ICs:y(0)=0, y'(0)=0.
In this case, we can define the given problem in the explicit form, but for demonstration purposes 
we define this problem as an implicit problem and solve it by using ode15i. Then we define it explicitly and solve it by using ode45.

NOTE: that Fimp anonymous function is defined as two 1st order DEs. Compare Fimp with Fexp that defines DEs for an explicit ODE solver ode45.
%}
clearvars; close all
Fimp = @(t, y, dy)([dy(1)-y(2); y(1)*dy(2).^2-exp(2*t)]);
y0=[0.001, 0]; dy0=[0,0];          % ICs        
F_aty0=[0,sqrt(1e3)]; F_atdy0=[];  % Function values at y0 and dy0

% Consistent Initial values
[y0, dy0]=decic(Fimp, 0, y0, dy0, F_aty0, F_atdy0); 
[t, ft]=ode15i(Fimp, [0.001,1], y0,dy0);
plot(t, ft(:,1), 'bx-', t, ft(:,2), 'kd-')
title('Solutions of: $$ y*(\frac{d^2y}{dx^2})^2=e^{2*x} $$', 'interpreter', 'latex')
xlabel('\it x'), ylabel('\it y(x), dy(x)')
grid on, hold on
Fexp=@(t, y)([y(2); sqrt(exp(2*t)./y(1))]);
ICs=[0.001, 0];
timespan=[0, 1];
[t, yt]=ode45(Fexp, timespan, ICs, []);
plot(t, yt(:,1),'ro-', t, yt(:,2), 'g+-')
Out=sim('IMPLICIT_2ODE_EX5_sim.slx', [1e-3, 1]);
plot(Out.yout{1}.Values.Time, Out.yout{1}.Values.Data, 'r--', 'linewidth', 1.5)
plot(Out.yout{2}.Values.Time, Out.yout{2}.Values.Data, 'k--', 'linewidth', 1.5)
legend('y(x) with ode15i','dy(x) with ode15i','y(x) with ode45', ... 
    'dy(x) with ode45', 'y(x) with Simulink', ...
    'dy(x) with Simulink', 'location', 'best'); 
hold off; shg
