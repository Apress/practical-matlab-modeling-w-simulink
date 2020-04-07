function MASS3
% HELP. Simulation of three-degree-of-freedom system.
t=0:.01:120;          % Simulation time span
 IC=[0;0;0;0;0;0];     % Case # 1. Forced Motion
% IC=[0.5;0;0;0;0;0]; % Initial conditions
[t, x123]=ode45(@DOF3, t, IC, []);
figure('name', 'Matrix Approach')
H=plot(t, x123(:,1), t, x123(:,3), t, x123(:,5));
H(1).Color = [1 0 0];
H(2).Color = [0 1 0];
H(3).Color = [0 0 1];
H(1).LineStyle = '-';
H(2).LineStyle = '-.';
H(3).LineStyle = '--';
H(1).LineWidth = 1.5;
H(2).LineWidth = 2.0;
H(3).LineWidth = 2.0;
legend('Mass 1: x_1(t)', 'Mass 2: x_2(t)', 'Mass 3: x_3(t)')
ylabel('\it x_1(t), x_2(t), x_3(t)')
xlabel('\it time')
title('\it Forced Motion: Displacement'), grid on
% title('\it Free Motion: Displacement'), grid on
xlim([0, 20])
figure(2)
G=plot(t, x123(:,2), t, x123(:,4), t, x123(:,6));
G(1).Color = [1 0 0];
G(2).Color = [0 1 0];
G(3).Color = [0 0 1];
G(1).LineStyle = '-';
G(2).LineStyle = '-.';
G(3).LineStyle = '--';
G(1).LineWidth = 1.5;
G(2).LineWidth = 2.0;
G(3).LineWidth = 2.0;
legend('Mass 1: dx_1(t)', 'Mass 2: dx_2(t)', 'Mass 3: dx_3(t)')
title('\it Forced Motion: Velocity'), grid on
% title('\it Free Motion: Velocity'), grid on
xlabel('\it time'), ylabel('\it dx_1, dx_2, dx_3')
xlim([0, 20])
    function  dx = DOF3(t, x)
        % HELP: three-degree-of-freedom system simulation
        k1=25; k2=5; k3=30; k4=k3; c1=2.5; c2=.5; c3=3.5;
        m1=2.5; m2=2; m3=3; M=[m1 0 0; 0 m2 0; 0 0 m3];
        K=[k1+k2, -k2, 0; -k2, k2+k3, -k3; 0, -k3, k3+2*k4];
        C=[c1+c2, -c2, 0; -c2, c2+c3, -c3; 0, -c3, c3];
        % Case 1: External forces applied
         F1= 0; t0=0; F2=20*stepfun(t,t0); F3=0;
        % Case 2: Free vibration (No force applied)
        % F1=0;F2=0;F3=0;
        B=[F1;F2;F3]; A=[zeros(3) eye(3); -inv(M)*K, -inv(M)*C];
        f=(M\eye(3))*B; dx=A*x+[0;0;0;f];
    end
end
