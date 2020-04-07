%% Part II.
%%  Linearized model of the double pendulum solved by ODE15i
%   DOUBLE_Pedulum_Linear_2.m
L1= 5; L2 = L1;    % m
g = 9.81;             % m/s^2
m1=10;               % kg
m2=10;               % kg
M=m1+m2;
test=@(t, theta, dtheta)([ dtheta(1)-theta(2); 
       (m1+m2)*L1*dtheta(2)+m2*L2*dtheta(4)+(m1+m2)*g*theta(1); 
dtheta(3)-theta(4); m2*L2*dtheta(4)+m2*L1*dtheta(2)+m2*g*theta(3)]);
tspan=[0, 2*pi];
% Initial Conditions:
theta10=-.5; dtheta10=-1; theta20=1; dtheta20=2; 
the0=[theta10, dtheta10, theta20, dtheta20];
thep0=[0;0;0;0]; theF0=[1 1 1 1]; dtheF0=[];
[the0, dthep0]=decic(test,0, the0,theF0,thep0, dtheF0);
[time, theta]=ode15i(test, tspan, the0,dthep0);
plot(time, theta(:,1), 'k', time, theta(:,2), 'bs-',...
time, theta(:,3),'m--', time, theta(:,4), 'go-','linewidth', 1.5)
title('Linearized model simulation of double pendulum')
xlabel('time'), ylabel('\theta(t)'), axis tight; grid on; hold on; shg
legend('\theta_1', 'd\theta_1', '\theta_2', 'd\theta_2', 'location', 'southeast')
%% Analytic Solution of the Linearized Model with DSOLVE
clearvars t
syms theta1(t)  theta2(t)
Dtheta1=diff(theta1, t, 1);
Dtheta2=diff(theta2, t, 1);
D2theta1=diff(theta1, t,2);
D2theta2=diff(theta2, t,2);
EQN = [D2theta1==(-1/(M*L1))*(m2*L1*D2theta2+M*g*theta1), ...
            D2theta2==(-1/(m2*L1))*(m2*L1*D2theta1+m2*g*theta2)];
ICs = [theta1(0)==-.5,Dtheta1(0)==-1, theta2(0)==1, Dtheta2(0)==2];
Theta=dsolve(EQN, ICs);
t=0:pi/20:2*pi;
Theta1=(vectorize(Theta.theta1)); Theta2=(vectorize(Theta.theta2));
% Compute values of Theta1 & Theta2: 
theta1=eval(Theta1); theta2=eval(Theta2);
plot(t, theta1, 'mx', t, theta2, 'k*', 'linewidth', 1.5)
legend('\theta_1(t) via ODE15i','d\theta_1(t) via ODE15i',...
'\theta_2(t) via ODE15i','d\theta_2(t) via ODE15i',...        
'\theta_1 dsolve','\theta_2 dsolve'), grid on; hold off
figure('name', 'Phase plot')
plot(theta(:,1), theta(:,2), 'b-',theta(:,3),theta(:,4), 'r-.','linewidth', 1.5)
legend('\theta_1 vs. d\theta_1', '\theta_2 vs. d\theta_2', 'location', 'southeast')
title('Phase plot')
xlabel('\theta_1, \theta_2')
ylabel('d\theta_1, d\theta_2')
axis square