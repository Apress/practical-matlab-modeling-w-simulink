% Given: y"-2y'+5y=0, y(pi/2)=0, y'(pi/2)=2
% NB: Computation starts at pi/2 that is a set point of the ICs.
% ODEx_solvers_EX4.m

u(1,:)=[0, 2];    %ICs
tstart=pi/2;      %!!! NB: Computation starts at pi/2 
tstep=pi/20;
tend=2*pi;
t=tstart:tstep:tend;
steps=length(t);

%% Analytical Solution: via dsolve

y=dsolve('D2y=2*Dy-5*y', 'y(pi/2)=0', 'Dy(pi/2)=2', 'x');
display('y(t) is');
pretty(y)
y=vectorize(y);
x=t;
Yt=eval(y);
plot(t, Yt, 'gx', 'linewidth', 3.5), grid on
hold on

%% SIMULINK Solution
%!!! NB: Computation starts at pi/2 
opts=simset('reltol',1e-5,'solver', 'ode23');
[time, Yout]=sim('NON_zero_ICs_2ODE1', [pi/2,2*pi],opts);
plot(time, Yout(:,1), 'mo-', 'linewidth',1.5)

%% RUNGE-KUTTA Solution
U(1,:)=[0, 2];
FF=inline('[u2, 2*u2-5*u1]','t','u1','u2');
for ii=1:steps-1
k1=FF(t(ii), U(ii,1), U(ii,2));
k2=FF(t(ii)+tstep/2,U(ii,1)+tstep*k1(:,1)/2,U(ii,2)+tstep*k1(:,2)/2);
k3=FF(t(ii)+tstep/2,U(ii,1)+tstep*k2(:,1)/2,U(ii,2)+tstep*k2(:,2)/2);
k4=FF(t(ii)+tstep,U(ii,1)+tstep*k3(:,1),U(ii,2)+tstep*k3(:,2));
U(ii+1,:)=U(ii,:)+tstep*(k1+2*k2+2*k3+k4)/6;
end
plot(t(:)', U(:,1), 'kd-.', 'linewidth', 1.5)
legend('Analytic (dsolve)','Simulink(ode23 ~var)',...
'RK 4th order script', 0)
title('ddy-2dy+5y=0, y(\pi/2)=0, dy(\pi/2)=2')
xlabel('t, time'), ylabel('y(t), solution'), hold off; shg
