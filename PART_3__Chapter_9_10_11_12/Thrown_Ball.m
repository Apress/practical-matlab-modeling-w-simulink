% Thrown_Ball.m. Case 1. Analytical solution in vacuum
clc; clearvars; close all;
syms x(t) z(t)
Dx  = diff(x, t);
D2x = diff(x, t, 2);
Dz   = diff(z, t);
D2z = diff(z, t, 2);
g=9.8;          % [m/s^2] gravitational acceleration
h=1;             % ball hit 1 [m] above ground  
theta=15;      % ball hit under 15 degrees
v0=25;          % [m/s] initial velocity of a ball 
EQN = [D2x ==0, D2z==-g];
ICs   = [x(0)==0, Dx(0)==v0*cos(theta*pi/180),...
    z(0)==h, Dz(0)==v0*sin(theta*pi/180)];
x_z_vac=dsolve(EQN, ICs);
xt=x_z_vac.x  %#ok
zt=x_z_vac.z  %#ok
xt=vectorize(xt); zt=vectorize(zt); 
t=linspace(0,1.5, 200); 
xt=eval(xt); zt=eval(zt); 
index=find(zt<0);
touch_gr=xt(index(1)-1); t_touch = t(index(1)-1);
plot(xt, zt,'ko', 'markersize', 4,'MarkerFaceColor','y') 
grid on; xlim([0, touch_gr]);
text1=['Ball touches the ground in distance (of x) ' ...
    num2str(touch_gr) '[m]']; 
gtext(text1);
text2=['Ball touches the ground after : ' num2str(t_touch) ' [sec]'];
gtext(text2);
title('Trajectory of Tennis Ball hit in Vacuum @ v_0=25 [m/s] ')
xlabel('\it x, (horizontal) [m]'), ylabel('\it z, [m]')
