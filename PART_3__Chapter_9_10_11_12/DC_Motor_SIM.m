function DC_Motor_SIM
h=0.001;             % Time step 
t=0:h:5;             % Simulation time  
theta0 = [0, 0];     % Initial conditions
ia0    = 0;          % Initial conditions
u=[theta0, ia0];
for m=1:length(t)-1
k1(m,:)=DC_Motor(t(m), u(m,:));
k2(m,:)=DC_Motor(t(m), u(m,:)+h*k1(m,:)./2);
k3(m,:)=DC_Motor(t(m), u(m,:)+h*k2(m,:)./2);
k4(m,:)=DC_Motor(t(m), u(m,:)+h*k3(m,:));
u(m+1,:)=u(m,:)+h*(k1(m,:)+2*k2(m,:)+2*k3(m,:)+k4(m,:))./6;
end
close all
figure(1)
plot(t,u(:,1),'b',t,u(:,2),'r--',t,u(:,3),'k:','linewidth', 1.5)
title('\it Simulation of DC Motor for V_a = 12 [V] input')
xlabel('\it Time, t [s]'), ylabel('\it \theta_i(t), i_a(t)')
legend('\theta_m(t)','\omega(t)','i_a(t)', 'location', 'northwest')
grid on
ylim([0, 320])
function dudx=DC_Motor(t, u)
% DC_Motor(u) is a nested function.
% Parameters used in this simulation are:
Jm=0.01;    % [kgm^2]
C=0.1;      % [Nms]
Ke=0.01;    % [Nm/A]
Kt=1;       % [Nm/A]
Ra=1.25;    % [Ohm]
La=0.5;     % [H] 
Va=12*stepfun(t, 1);   % [V]
dudx=zeros(1,3); 
dudx(1)=u(2);
dudx(2)=(1/Jm)*(u(3)*Kt-C*u(2)); 
dudx(3)=(1/La)*(Va-Ke*u(2)-Ra*u(3));
return
