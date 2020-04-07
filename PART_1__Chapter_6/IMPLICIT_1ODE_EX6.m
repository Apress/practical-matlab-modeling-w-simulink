% IMPLICIT_1ODE_EX6.m 
% EXAMPLE 6. exp(.01*t)+y'*exp(y)=2 with ICs: y(0)=2
%
clearvars; close all
Fun=@(t, y, dy)(2-(exp(.01*t)+dy*exp(y)));
y0=2; dy0=1/2; t0=0; F_aty0=1;
[y0, dy0]=decic(Fun,t0, y0, dy0, F_aty0, [] );
tspan=[0, 130];
[time, y]=ode15i(Fun, tspan, y0, dy0, []);
plot(time, y, 'bd-'), grid minor
title('Solutions of: $$ e^{0.01*t}+\frac{dy}{dt}*e^y=2 $$', 'interpreter', 'latex')
xlabel '\it t', ylabel '\it y(t)'
% dsolve
yt=dsolve('2-(exp(.01*t)+Dy*exp(y))=0', 'y(0)=2');
Yt=vectorize(yt);
t=time;
Yt=eval(Yt);
hold on; plot( t, Yt, 'mx--', 'linewidth', 1.5), ylim([-.4 4])
% Simulink model executed for time span of 0…130 sec.
[time,y]=sim('IMPLICIT_1ODE_EX6_sim', [0, 130]); 
plot(time, y, 'k-', 'linewidth', 1.5)
legend('ode15i','dsolve: Analytical solution','SIMULINK', 'location', 'best'), shg
