%%  MARS Lander Vehicle velocity and acceleration while landing
%   MARS_lander.m
t=0:.05:6;
u0=[20, 67.0556];
g=3.885;
k=1.2;
m=150;
% F=inline('[u(2); g-(k/m)*(u(2).^2)]', 't', 'u');
Flander=@(t, u)([u(2); g-(k/m)*(u(2).^2)]);
[time, Uout]=ode45(Flander, t, u0, []);

% Acceleration is a derivative of velocity!
% diff command is used to produce the derivative of velocity   
% values for acceleration data

acc = diff(Uout(:,2))/(time(2)-time(1)); 
plot(t,Uout(:,2),'ro',t(2:end),acc,'bs')
hold on
% Time derivative:
Ttt=[diff(t);diff(t)]; 
% Velocity:
Utt=diff(Uout);  
% Velocity and its derivative, viz. Acceleration:
UT=Utt./Ttt';    

plot(t(2:end), UT(:,1),'b-',t(2:end), UT(:,2),'m--','linewidth', 2.5); 
legend({'Velocity1 [m/s]';'Acceleration1 [m^2/s]';...
'Velocity2'; 'Acceleration2'},0); grid minor 
title('Mars lander"s velocity and acceleration during landing')
xlabel('time'), ylabel('v, a'), shg
