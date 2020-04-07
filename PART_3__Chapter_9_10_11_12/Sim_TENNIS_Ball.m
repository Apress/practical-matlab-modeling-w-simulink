% Sim_TENNIS_Ball.m
% SIMULINK models with a fixed step solver ode8 
set_param('TENNIS_ball','Solver','ode8','StopTime','1.5')
out=sim('TENNIS_ball'); 
plot(out.yout{2}.Values.Data,out.yout{1}.Values.Data, 'g',...
    out.yout{4}.Values.Data,out.yout{3}.Values.Data, 'c:',...
    out.yout{6}.Values.Data,out.yout{5}.Values.Data,'r-.', 'linewidth', 3 ), grid on
legend('In Vacuum via SIM','NoSpin in Air via SIM',...
'TopSpin in Air via SIM'), ylim([0, 3.35])
title('Trajectory of Tennis Ball hit under \theta=15^0 & h=1 m')
xlabel('Length, [m]'), ylabel('Height, [m]')
