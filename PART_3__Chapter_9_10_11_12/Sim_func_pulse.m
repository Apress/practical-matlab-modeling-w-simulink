% F = func_pulse(t, n) produces rectangular periodic pulses. 
% DDx = @(t,x) anonymous function handle.
clearvars; close all
M = 10; C = 0.5; K = 1000; % System parameters
t=0:pi/1000:13;          % Time  
n=113;                   % Terms for Fourier Series  
ICs=[0,0];               % Initial Conditions
F=func_pulse(t,n);       % Fourier Series values 
% System model equation is expressed by two 1st order ODEs
DDx=@(t,x)([x(2); (1/10)*(func_pulse(t,n)-C*x(2)-K*x(1))]);
opts_ODE=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[time, Xt]=ode45(DDx, t, ICs, opts_ODE);
subplot(211) 
yyaxis left
plot(t, F, 'k-');  
ylabel('Input F(t), [N]')
yyaxis right
plot(t, Xt(:,1), 'r--')
ylabel('Output x(t), [m]') 
legend('F(t) Input', 'x(t) Output'), grid on
title(['\it SMD system excited ',...
'by periodic pulse force'])
axis tight
subplot(212) 
yyaxis left
plot(t,Xt(:,1),'k-')
ylabel('Displacement x(t), [m]')
yyaxis right
plot(t, Xt(:,2),'b-.','linewidth', 1.5)
legend('x(t)','dx(t)')
ylabel('Velocity dx(t), [m/s]') 
xlabel('time [sec]'), grid on, axis tight
figure 
plot(Xt(:,1), Xt(:,2)), 
xlabel('x(t)'), ylabel('dx(t)')
title('Phase plot; x vs. dx'), grid on
axis square
function F=func_pulse(t,n)
%HELP. t is time vector. n is number of terms in pulse approximation. 
F(1,:)=(200/pi)*(1-cos(pi))*sin(pi*t);
for ii=2:n
    F(:,:)=F(:,:)+(200/(ii*pi))*(1-cos(ii*pi))*sin(ii*pi*t);
end
end
