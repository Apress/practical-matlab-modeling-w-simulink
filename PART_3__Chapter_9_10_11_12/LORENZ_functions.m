function LORENZ_functions(t,ICs)
% LORENZ Functions
if nargin<1
ICs=[-8, 8, 27]; t=0:.005:25;
end
Sigma=10; Beta=8/3; Ro=28;
% Dx/Dt=-Sigma*X+Sigma*Y;
% Dy/Dt=- Y-X*Z;
% Dz/Dt=-Beta*Z+X*Y-Beta*Ro;
Lorenz_sys = @(t, X)([-Sigma*X(1)+Sigma*X(2);-X(2)-X(1).*X(3); ...
-Beta*X(3)+X(1).*X(2)-Beta*Ro]);
[time, fOUT]=ode45(Lorenz_sys, t, ICs, [ ]);
close all; figure 
plot3(fOUT(:,1), fOUT(:,2), fOUT(:,3)), grid
xlabel('x(t)'), ylabel('y(t)'), zlabel('z(t)')
title('LORENZ functions x(t) vs. y(t) vs. z(t)'), axis tight
figure; comet3(fOUT(:,1), fOUT(:,2), fOUT(:,3))% WATCH Animations
figure; subplot(311); plot(time, fOUT(:,1), 'b','linewidth', 3), grid minor; title('LORENZ functions x(t), y(t), z(t)'), xlabel('time'), ylabel('x(t)')
subplot(312); plot( time', fOUT(:,2), 'r', 'linewidth', 2 ), 
grid minor; xlabel 'time', ylabel 'y(t)'
subplot(313); plot(time, fOUT(:,3),'k', 'linewidth', 2), 
grid minor
xlabel('time'), ylabel('z(t)')
figure; plot(fOUT(:,1), fOUT(:,2), 'b', 'linewidth', 1.5)
grid minor, title('LORENZ functions'), xlabel('x(t)')
ylabel('y(t)'), axis square
figure; plot(fOUT(:,1), fOUT(:,3), 'k', 'linewidth', 1.5)
grid minor, title('LORENZ functions'), xlabel('x(t)') 
ylabel('z(t)'),axis square
figure; plot(fOUT(:,2), fOUT(:,3), 'm', 'linewidth', 1.5)
grid minor, title('LORENZ functions'), xlabel('y(t)')
ylabel 'z(t)',axis square
end