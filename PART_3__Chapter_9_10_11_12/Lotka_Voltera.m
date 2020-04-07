% Lotka_Voltera.m
% LOTKA-VOLTERA ~ Predator-Prey ~ two body simulation %%%%%
% dx/dt = alfa*x-beta*x*y;
% dy/dt = delta*x*y-gamma*y;
Alfa = 1; Beta = 0.05; Delta = 0.02; Gamma = 0.5;
% NOTE: x(1)=x and x(2)=y
dxy=@(t,x)([Alfa*x(1)-Beta*x(1).*x(2);...
    Delta*x(1).*x(2)-Gamma*x(2)]);
time=[0, 20];
ICs=[10 10];      % Initial number of preys and predators
%   Since this has two populations, we pass the array [1 2].
%   Options=odeset('reltol', 1e-5),'NonNegative', [1 2]);
opts=odeset('reltol', 1e-5, 'NonNegative', [1 2]);
[t, xy]=ode45(dxy, time, ICs, opts);
plot(t, xy, 'linewidth', 2), 
grid minor, legend('Prey','Predator')
title('Lotka-Voltera function: predator/prey two-body sim.')
figure
plot(xy(:,1),xy(:,2)), grid on; hold on
ICs=[40 20];
opts=odeset('reltol', 1e-5, 'NonNegative', [1 2]);
[t, xy]=ode45(dxy, time, ICs, opts);
plot(xy(:,1),xy(:,2), 'r--', 'linewidth', 1.5), grid on
ICs=[60 20];
opts=odeset('reltol', 1e-5, 'NonNegative', [1 2]);
[t, xy]=ode45(dxy, time, ICs, opts);
plot(xy(:,1),xy(:,2), 'mo-', 'linewidth', 1.5), grid on
ICs=[80 20];
opts=odeset('reltol', 1e-5, 'NonNegative', [1 2]);
[t, xy]=ode45(dxy, time, ICs, opts);
plot(xy(:,1),xy(:,2), 'kx:', 'linewidth', 1.5), grid on
ICs=[Alfa/Beta Gamma/Delta];
opts=odeset('reltol', 1e-5, 'NonNegative', [1 2]);
[t, xy]=ode45(dxy, time, ICs, opts);
plot(xy(:,1),xy(:,2), 'gx-', 'linewidth', 1.5), grid on
title('Lotka-Voltera model: 20 predators vs.~ preys')
xlabel('x(t), prey rate'), ylabel('y(t), predator rate')
legend('x_0/y_0=1','x_0/y_0=2','x_0/y_0=3','x_0/y_0=4',...
'ICs=[\alpha/\beta \gamma/\delta]'), hold off
