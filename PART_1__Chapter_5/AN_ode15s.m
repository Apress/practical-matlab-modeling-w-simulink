% AN_ode15s.m with ODE15S solver
% Coefficients:
k1=18.7; k2=.58; k3=.09; k4=.42; 
K=34.4; klA=3.3; Ks=115.83; pCO2=.9; H=737;    
% Anonymous Function:
F_NAN=@(t, y)([-2*k1*y(1)^4*y(2)^.5+k2*y(3)*y(4)-...
    ((k2/K)*y(1)*y(5))-(k3*y(1)*y(4)^2);
    -0.5*(k1*y(1)^4*y(2)^.5)-(k3*y(1)*y(4)^2)-...
    .5*(k4*y(6)^2*y(2)^.5)+(klA*(pCO2/H-y(2)));
    (k1*y(1)^4*y(2)^.5)-k2*y(3)*y(4)+(k2/K*y(1)*y(5));
    -k2*y(3)*y(4)+(k2/K*y(1)*y(5))-2*(k3*y(1)*y(4)^2);
    k2*y(3)*y(4)-(k2/K*y(1)*y(5))+(k4*y(6)^2*y(2)^.5); ...
    Ks*y(1)*y(4)-y(6)]);
% ICs:
y0=[.437, .00123, 0, .007, 0, Ks*.437*.007];
tstart=0; 
hstep=.1; 
tend=180; 
t=tstart:hstep:tend;
[tout, Yout]=ode15s(F_NAN, t, y0);
plot(tout, Yout, 'linewidth', 1.5), 
legend('y_1', 'y_2','y_3','y_4','y_5','y_6'), grid on, 
title('AKZO-NOBEL Problem simulation with ODE15s ')
xlabel('time'), ylabel('y_i(t)')
figure
subplot(411), plot(tout, Yout(:,1), 'r-', 'linewidth', 1.5), 
title('AKZO-NOBEL Problem: variable y(1)'), grid on
subplot(412), plot(tout, Yout(:,2), 'b-', 'linewidth', 1.5),
title('AKZO-NOBEL Problem: variable y(2)'), grid on
subplot(413), plot(tout, Yout(:,3), 'k-', 'linewidth', 1.5), 
title('AKZO-NOBEL Problem: variable y(3)'), grid on
subplot(414), plot(tout, Yout(:,4), 'm-', 'linewidth', 1.5),
title('AKZO-NOBEL Problem: variable y(4)'), grid on
figure,
subplot(211), plot(tout, Yout(:,5), 'b-', 'linewidth', 1.5),
title('AKZO-NOBEL Problem: variable y(5)'), grid on
subplot(212), plot(tout, Yout(:,6), 'm-', 'linewidth', 1.5),
title('AKZO-NOBEL Problem: variable y(6)'), grid on
figure, plot(tout, Yout(:,2), 'b-', 'linewidth', 1.5), 
title('AKZO-NOBEL Problem: variable y(2) to view change in [0,3]') 
grid on; xlim([0, 3])
