% STIFF_1ODE_EX3.m
clearvars; close all
% Numerical solutions with ODEx:
Fun=@(t,y)(cos(1001*t)); Time=[0,0.75]; y0=1.001;
[t1, y1]=ode23s(Fun, Time, y0);
[t2, y2]=ode45(Fun, Time, y0);
[t3, y3]=ode113(Fun, Time, y0);
[t4, y4]=ode15s(Fun, Time, y0);
subplot(211)
plot(t1, y1, 'rs--', 'markersize', 9, 'markerfacecolor', 'c')
hold on
plot(t2, y2, 'bh-.', 'markersize', 9, 'markerfacecolor', 'y')
plot(t3, y3, 'm-', 'linewidth', 1.5)
legend('ode23s','ode45','ode113')
title('\it Solutions of Stiff Problem: $$ \frac{dy}{dt}=cos(1001*t, y_0=1.001 $$', 'interpreter', 'latex')
xlabel('\it t'); ylabel( '\it y(t)'); axis tight; grid on
subplot(212)
plot( t4, y4, 'b--o', 'markersize', 9, 'markerfacecolor', 'y'), hold on
% Euler forward method:
y(1)=y0; h=1e-2; t=0:h:0.75; steps=length(t);
f=@(t, y)(cos(1001*t)); y=[y(1), zeros(1, length(t)-1)];
for ii=1:steps-1
    F=f(t(ii), y(ii));
    y(ii+1)=y(ii)+h*F;
end
plot(t, y, 'm', 'linewidth', 1.5)
% Analytical Solution:
clearvars t y
syms y(t)
Dy=diff(y); y=dsolve(Dy==cos(1001*t), y(0)==1.001); y=vectorize(y);
t=0:.01:0.75; y=eval(y); plot(t, y, 'k--', 'linewidth', 1.5), 
hold on; 
legend( 'ode15s', 'Euler forward','Analytical Sol')
xlabel('\it t'); ylabel( '\it y(t)'); shg
axis([0 .75 .95 1.33]), grid on

