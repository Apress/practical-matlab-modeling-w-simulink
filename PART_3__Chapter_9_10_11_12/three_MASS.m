% three_MASS.m
% HELP. Simulation of highly coupled three degree of freedom system. 
clearvars; clc
t=0:.01:120;  % Simulation time span
IC=[0;0;0;0;0;0];           % Case # 1
% IC=[0.5; 0; 0; 0; 0; 0];  % Case # 2

F1=20*sin(120*t);F2=0; t0=0; F3=20*stepfun(t,t0); % Case # 1
% F1=0; F2=F1; F3=F1;                             % Case # 2  
k1=25; k2=5; k3=30; k4=k3; c1=2.5; c2=.5; c3=3.5;
m1=2.5; m2=2; m3=3;
[t, xyz]=ode45(@third_DOF, t, IC, []);
% SIMULINK model: ThreeDOFsys.slx with ODE113 & relative error tol. 1e-6
OPTs=simset('reltol', 1e-6, 'solver', 'ode113');
[tt, YOUT, X123]=sim('ThreeDOFsys', [0, 120], OPTs); % Simulates: ThreeDOFsys.slx

figure('name', 'Matlab vs. Simulink')
plot(t(1:2000),xyz(1:2000,1),'bo',t(1:2000),xyz(1:2000,3), ...      
    'rx', t(1:2000), xyz(1:2000,5), 'ks', ...
    tt(1:5000),X123(1:5000,1),'r-',tt(1:5000),X123(1:5000,2), ...      
    'b--', tt(1:5000), X123(1:5000,3), 'g-.','linewidth',1.5), grid on
legend('Mass 1: x_1(t) (Matlab)','Mass 2: x_2(t) (Matlab)','Mass 3: x_3(t) (Matlab)', ...
    'Mass 1: x_1(t) (Simulink)', 'Mass 2: x_2(t) (Simulink)', 'Mass 3: x_3(t) (Simulink)')
title('\it Three DOF SMD (coupled) system')
xlabel('\it time, [sec]'), 
ylabel('\it Displacement, x_1(t), x_2(t), x_3(t)')
xlim([0, 20])
figure('name', 'Animation')

for k=1:t(end)-20
% Note: Displacement magnitudes of x1, x2, x3 increased 
% by the factor of 10 for better visualization
plot(-20,0,'*', 20,0, '*', -10+10*xyz(k+20,1), 0, 'r-o',...
 -5+10*xyz(k+20,3),0,'g-o',...
10+10*xyz(k+20,5),0,'b-o','markersize', 35, ...
 'markerfacecolor', 'c');
grid on; Motion(k)=getframe;
end
movie(Motion)
function  dx = third_DOF(t, y)
% HELP: three degree of freedom system
k1=25; k2=5; k3=30; k4=k3; c1=2.5; c2=.5; c3=3.5;
m1=2.5; m2=2; m3=3;
 F1=20*sin(120*t);F2=0; t0=0; F3=20*stepfun(t,t0); % Case # 1
% F1=0; F2=0; F3=0;                                   % Case # 2
dx=zeros(6,1);
dx(1)=y(2);
dx(2)=(1/m1)*(F1-(k1+k2)*y(1)+k2*y(3)-(c1+c2)*y(2)+c2*y(4)); 
dx(3)=y(4);
dx(4)=(1/m2)*(F2+k2*y(1)-(k2+k3)*y(3)+k3*y(5)-... 
    (c2+c3)*y(4)+c2*y(2)+c3*y(6));
dx(5)=y(6);
dx(6)=(1/m3)*(F3+k3*y(3)-(k3+2*k4)*y(5)+c3*y(4)-c3*y(6));
end
%end
