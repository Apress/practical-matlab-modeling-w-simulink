% Thrown_Ball_All.m
h =1;        % [m];
v0=25;      % [m*s^-1];
theta=15;  % [deg];
ro=1.29;    % [kg*m^-3];
g=9.81;     % [m/s^2]
d=.063;     % [m];
m=.05;      % [kg];
w=20;        % [m*s^-1]; angular velocity of a spinning ball
eta=1;        % describes direction(+-) and presence of rotation; 
                  % eta=1 is for top-spin.
alfa=ro*pi*d^2/(8*m); time=0:.01:1.5;
ICs=[0, 1, v0*cos(theta*pi/180), v0*sin(theta*pi/180)];
u  = @(t,x)sqrt(x(3).^2+x(4).^2);
CD = @(t,x)(0.508+(1./(22.053+4.196*(u(t,x)./w).^(5/2))).^(2/5));
CM = @(t,x)(1/(2.022+.981*(u(t,x)./w)));
vacuum = @(t,x)([x(3); x(4); 0; -g]);
nospin = @(t,x)([x(3); x(4); (-1)*CD(t,x)*alfa*u(t,x)*x(3);
          (-1)*g-CD(t,x)*alfa*u(t,x)*x(4)]);
topspin= @(t,x)([x(3); x(4);
    (-1)*CD(t,x)*alfa*u(t,x)*x(3)+eta*CM(t,x)*alfa*u(t,x)*x(4);
    (-1)*g-CD(t,x)*alfa*u(t,x)*x(4)-eta*CM(t,x)*alfa*u(t,x)*x(3)]);
[tvac, XZvac]= ode45(vacuum, time, ICs, []);
[tns, XZns]  = ode45(nospin, time, ICs, []);
[tts, XZts]  = ode23(topspin, time, ICs, []);

% Case #1. Ball is hitted in the Vacuum 
z_i=find(abs(XZvac(:,2))<=min(abs(XZvac(:,2))));
t_gr=XZvac(z_i,1); t_t = time(z_i);
% Case #2. Ball is hitted without a spin 
z1_i =find(abs(XZns(:,2))<=min(abs(XZns(:,2))));
t_gr1=XZns(z1_i,1); t_t1 = time(z1_i);
% Case #3. Ball is hitted with a Top-spin 
z2_i =find(abs(XZts(:,2))<=min(abs(XZts(:,2))));
t_gr2=XZts(z2_i,1); t_t2 = time(z2_i);
plot(XZvac(:,1), XZvac(:,2), 'bo', 'linewidth', 1), grid; hold on
plot(XZns(:,1), XZns(:,2), 'm', 'linewidth', 2)
plot(XZts(:,1), XZts(:,2), 'ko-', 'linewidth', 1.0)
legend('In Vacuum','No-Spin in Air','Top-Spin in Air'), 
ylim([0, 3.35])
title 'Trajectory of a Tennis Ball hit under \theta=15^0, h=1 m'
xlabel 'Length, [m]', ylabel 'Height, [m]'
tt1=['Vacuum: Ball hits the ground (x-axis):' num2str(t_gr) ' [m]'];
gtext(tt1, 'backgroundcolor', 'w');
tt1a=['Vacuum: Ball hits the ground after: ' num2str(t_t) ' [s]'];
gtext(tt1a, 'backgroundcolor', 'w');
tt2=['No-spin: Ball hits the ground: ' num2str(t_gr1) ' [m]'];
gtext(tt2, 'backgroundcolor', 'w');
tt2a=['No-spin: Ball hits the ground: ' num2str(t_t1)  ' [s]'];
gtext(tt2a, 'backgroundcolor', 'w');
tt3=['Top-spin: Ball hits the ground: ' num2str(t_gr2) ' [m]'];
gtext(tt3, 'backgroundcolor', 'w');
tt3a=['Top-spin: Ball hits the ground: ' num2str(t_t2) ' [s]'];
gtext(tt3a, 'backgroundcolor', 'w'); hold off

