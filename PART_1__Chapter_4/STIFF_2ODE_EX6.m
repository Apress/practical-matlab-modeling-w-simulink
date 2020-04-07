% STIFF_2ODE_EX6.m
% EXAMPLE: Second order ODEs ~ Rectifier Circuit Voltage
clearvars; close all
u(1,:)=[0, 0];            % Initial Conditions
h=1e-4;                   % Time step
t=0:h:.1;                  % Simulation time space
steps=length(t);      % Number of steps  
f=@(t, u1,u2)([u2, 1e4*abs(sin(333*t))-1e4*u1-100*u2]);
tic;
for ii=1:steps-1
    F=f(t(ii), u(ii,1), u(ii,2));
    u(ii+1,:)=u(ii,:)+h*F;
end
t_EF=toc;
plot(t, abs(sin(333*t)),'r', t, u(:,1), 'bd')
axis([0, .1 0, 1.2]), 
xlabel( '\it t') 
ylabel('\it Output voltage, u(t)')
title('Simulation of: $$ \frac{d^2u}{dt^2}+100*\frac{du}{dt}+10^4*u=10^4*|sin(333*t)| $$', ...
    'Interpreter', 'latex')
hold on
fprintf('Sim. time with Euler forward is:  %3.5f\n', t_EF)
% ODE23s
clearvars 
t=[0,.1];ICs=[0, 0];
FFm=@(tm, um)([um(2); 1e4*abs(sin(333*tm))-1e4*um(1)-100*um(2)]);
options=odeset('reltol', 1e-4);
tm=t;
tic
[Tm, Um]=ode23s(FFm, tm', ICs, options);
t_ode23s=toc;
fprintf('Sim. time with ode23s:         %3.5f\n', t_ode23s)
plot(Tm,Um(:,1),'k--+'),
% via SIMULINK    
% Simulink model: EL_circuit.mdl is created in two versions 
% Relative Tolerance is set at: 1e-4
clearvars
 options=simset('reltol', 1e-4);
 tic
 [tout, yout]=sim('EL_Circuit', [0, .1], options);
 t_SIM=toc;
 plot(tout, yout(:,1), 'm-', 'linewidth', 1.5)
 legend('Input: |sin(333*t)|','EULER forward script', ...
'ode23s', 'Simulink: ode15s','location', 'northeast'), shg
fprintf('Sim. time with Simulink ode15s: %3.5f\n', t_SIM)
