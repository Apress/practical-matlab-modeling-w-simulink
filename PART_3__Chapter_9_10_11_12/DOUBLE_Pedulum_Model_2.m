%%  ODE15i IMPLICIT ODE Solver
% HELP:  This simulates a double pendulum model 
% theta1(0)=-0.5; dtheta1(0)= -1 
% theta2(0)= 1; dtheta2(0) = 2. 
L1= 5; L2 = L1;      % meter
g = 9.81;               % meter/second^2
m1=10;                 % kg
m2=10;                 % kg
M=m1+m2;
test=@(t, theta, dtheta)([ -dtheta(1)+theta(2);
    M*L1*dtheta(2)+m2*L2*cos(theta(3)-theta(1))*dtheta(4)-...
    m2*L2*(theta(4)*(theta(4)-theta(2)))*sin(theta(3)-...
    theta(1))+M*g*sin(theta(1));
    -dtheta(3)+theta(4);
    m2*L2*dtheta(4)+m2*L1*cos(theta(3)-theta(1))*dtheta(2)-...
    m2*L1*(theta(2)*(theta(4)-theta(2)))*sin(theta(3)- ... 
    theta(1))+m2*g*sin(theta(3))]);
% theta10=-.5; dtheta10=-1; theta20=1; dtheta20=2; 
tspan=[0:pi/30:5*pi];     % Simulation time with a fixed time step 
the0=[-.5, -1, 1, 2];
dthe0=[0; 0; 0; 0];        % dtheta0 determined from theta0
theF0=[1 1 1 1]; dtheF0=[];
[the0, dthe0]=decic(test, 0, the0,theF0, dthe0, dtheF0);
[time, theta]=ode15i(test, tspan, the0, dthe0);
figure('name', 'Double pendulum 1')
plot(time, theta(:,1), 'b-', time, theta(:,2), 'k-.', 'linewidth', 1.5), hold on
plot(time, theta(:,3),'r--',time,theta(:,4), 'm:', 'linewidth', 2)
legend('\theta_1(t)','d\theta_1(t)','\theta_2(t)','d\theta_2(t)', 'location', 'southeast')
title('A double pendulum problem solved with ODE15i')
xlabel('time'), ylabel('\theta(t)'), grid on

figure('name', 'Double pendulum 2'), yyaxis left
plot(theta(:,1), theta(:,2),'b-', 'linewidth', 1.5)
ylabel('d\theta_1'), yyaxis right
plot(theta(:,3), theta(:,4), 'm-.', 'linewidth', 1.5)
legend('\theta_1 vs. d\theta_1','\theta_2 vs. d\theta_2(t)', 'location', 'southeast')
title('Phase plot of a double pendulum problem')
xlabel('\theta_1, \theta_2'), ylabel('d\theta_2'), 
axis tight; grid on; shg
