function Motor_Pump_Demo
h=0.01;                  % Time step     
t=0:h:1.5;                 % Simulation time  
theta0  = [0.005, 0, 0]; % Initial conditions
dtheta0 = [0, 0, 0];     % Initial conditions
u=[theta0, dtheta0];     % Whole Initial conditions 
for m=1:length(t)-1
k1(m,:)=Motor_pump_shaft(u(m,:));
k2(m,:)=Motor_pump_shaft(u(m,:)+h*k1(m,:)./2);
k3(m,:)=Motor_pump_shaft(u(m,:)+h*k2(m,:)./2);
k4(m,:)=Motor_pump_shaft(u(m,:)+h*k3(m,:));
u(m+1,:)=u(m,:)+h*(k1(m,:)+2*k2(m,:)+2*k3(m,:)+k4(m,:))./6;
end
close all; figure(1)
plot(t,u(:,1),'b',t,u(:,3),'k:',t,u(:,5),'m-.','linewidth', 1.5)
title('Angular displacements of Inertia Masses')
xlabel('Time, t'), ylabel('\theta_1(t), \theta_2(t), \theta_3(t)')
legend('\theta_1(t)','\theta_2(t)','\theta_3(t)','location', 'southeast'), grid on
figure(2)
plot(t,u(:,2),'b',t,u(:,4),'k:',t,u(:,6),'m-.','linewidth', 1.5)
title('Angular velocities of Inertia Masses')
xlabel('Time, t'), ylabel('\omega_1(t), \omega_2(t), \omega_3(t)')
legend('\omega_1(t)','\omega_2(t)','\omega_3(t)','location', 'southeast'), grid on
figure(3); plot(u(:,1), u(:,2), 'b', u(:,3), u(:,4), 'm--',...
    u(:,5), u(:,6), 'k:', 'linewidth', 1.5),
axis square, axis tight; title('Phase plots of Inertia Masses')
xlabel('\theta_1(t), \theta_2(t), \theta_3(t)') 
ylabel('\it \omega_1(t), \omega_2(t), \omega_3(t)')
legend('\omega_1(t)','\omega_2(t)','\omega_3(t)','location', 'southeast')
function dudx=Motor_pump_shaft(u)
K1=1200;       % [Nm/rad]
K2prime=8000;  % [Nm/rad]
J1=1.5;        % [kgm^2]
J2prime=4.5;   % [kgm^2]
J3prime=2.0;   % [kgm^2]
dudx=zeros(1,6);
dudx(1)=u(2); 
dudx(2)=(-K1/J1)*u(1)+(K1/J1)*u(3); 
dudx(3)=u(4); 
dudx(4)=(K1/J2prime)*u(1)-(K1/J2prime+K2prime/J2prime)*u(3)+...
    (K2prime/J2prime)*u(5);
dudx(5)=u(6); 
dudx(6)=(K2prime/J3prime)*u(3)-(K2prime/J3prime)*u(5);
return
