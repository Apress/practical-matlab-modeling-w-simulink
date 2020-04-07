% IMPLICIT_2ODE_EX4.m
%{
EXAMPLE 4. Truly IMPLICIT problem: exp(x")+x"+x=0 with ICs: x(0)=1, x'(0)=0.
In this case we can't define the given problem in the explicit form.
Thus, we can't employ ode45 or any other explicit ode solvers except for ode15i.
NOTE: that Fimp anonymous function is defined as two first order ODEs. 
Find out differences in expressing implicit ODEs (solved by ode15i) 
by function files or function handles with expressions (function files 
or function handles) of explicit ODEs to solve with ODEx solvers,
 viz. ode45, ode23, ode113, etc. 
%}
close all; clearvars
Fimp = @(t, x, dx)([dx(1)-x(2); exp(dx(2))+dx(2)+x(1)]);
x0=[1, 0]; dx0=[0, 0];               % ICs        
F_atx0=[0,exp(0)+1]; F_atdx0=[ ];    % Function values at x0 and dx0
% Find Consistent Initial values:
[x0, dx0]=decic(Fimp, 0, x0, dx0, F_atx0, F_atdx0);  
[t, ft]=ode15i(Fimp, [0,13], x0,dx0);
plot(t, ft(:,1), 'bx-', t, ft(:,2), 'kd-')
hold on
Out=sim('IMPLICIT_2ODE_EX4_sim.mdl');
plot(Out.yout{1}.Values.Time, Out.yout{1}.Values.Data, 'r--', 'linewidth', 1.5)
plot(Out.yout{2}.Values.Time, Out.yout{2}.Values.Data, 'g--', 'linewidth', 1.5)
legend('x(t) with ode15i','dx(t) with ode15i', ...
    'x(t) with Simulink','dx(t) with Simulink','location', 'best')
title('\it ODE15i solutions of:  $$ e^{\frac{d^2x}{dt^2}}+\frac{d^2x}{dt^2}+x=0 $$',  'interpreter', 'latex')
xlabel('\it t')
ylabel('\it $$ x(t), \frac{dx}{dt} $$', 'interpreter', 'latex')
grid on; 
axis tight; shg
