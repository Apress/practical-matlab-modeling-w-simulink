% Motor_Pump_Model_2.m
K1=1200;           % [Nm/rad]
K2prime=8000;  % [Nm/rad]
J1=1.5;              % [kgm^2]
J2prime=4.5;      % [kgm^2]
J3prime=2.0;      % [kgm^2]
t=[0, 1.5];              % Simulation time  
theta0=[.005; 0; 0]; % Initial conditions
dtheta0=[0; 0; 0];    % Initial conditions
KJ=[-K1/J1, K1/J1, 0; 
   K1/J2prime, -(K1/J2prime+K2prime/J2prime), K2prime/J2prime;
   0, K2prime/J3prime, -K2prime/J3prime;];
A=[zeros(3), eye(3); KJ, zeros(3)]; Fun=@(t, theta)(A*theta);
opts=odeset('reltol', 1e-6, 'abstol', 1e-9);
[time, THETA]=ode113(Fun, t, [theta0; dtheta0], opts);
figure; plot(time, THETA(:,1), 'b',time, THETA(:,2), 'm--', ...
    time, THETA(:,3), 'k:', 'linewidth', 1.5)
legend('\it \theta_1(t)','\theta_2(t)','\theta_3(t)', 'location', 'southeast'), grid on
title('Motor-pump model simulation MATLAB'), xlabel('t, time'), 
ylabel('\it \theta_1(t), \theta_2(t), \theta_3(t) ')
figure; plot(THETA(:,1), THETA(:,4), 'b',...
    THETA(:,2), THETA(:,5), 'm--', THETA(:,3),...
    THETA(:,6), 'k:', 'linewidth', 1.5)
legend('\it \omega_1(t)','\omega_2(t)','\omega_3(t)', 'location', 'southeast')
title('Motor-pump model simulation MATLAB') 
xlabel('\it \theta_1(t), \theta_2(t), \theta_3(t)') 
ylabel('\it \omega_1(t), \omega_2(t), \omega_3(t)'), axis square
grid on
