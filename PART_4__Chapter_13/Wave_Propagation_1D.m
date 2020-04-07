%% Wave propagation in a string - Spring-Mass system simulation (Hooke's law):
clearvars; clc;
% Given parameters
k = 100;                       % [Nm] stiffness
mass=2;                      % [kg] stiffness
Lx = 20;                       % [m] String length
dx=.1;                        % [m] Distance between nodes
Nodes=Lx/dx;               % Number of nodes
x = linspace(0, Lx, Nodes);
K = k/Nodes;
c = K*Lx^2*dx^2/mass;
dt=0.05;                         % Time step
u = zeros(Nodes,1);       % Boundary Conditions
um1= u;
up1 = u;
C = c*dt/dx;             % Wave propagation speed 
t=0;                         % Simulation start time 
T=30;                      % Simulation period 
Case = input('Enter case # (1, 2, 3):   ');
if Case==1
    % Small disturbance:
    u(5:7)=[0.05 0.1 0.05];   % Case 1
    up1(:)=u(:);
    while t<T
        % Time evolutions:
        t=t+dt;
        % Saving the iteration results:
        un1=u; u=up1;
        for ii=2:Nodes-1
            up1(ii)=(C^2)*(u(ii+1)-2*u(ii)+u(ii-1)) - un1(ii)+2*u(ii);
        end
        clf;
        plot(x, u, 'g-o', 'linewidth', 1), shg
    end
elseif Case == 2
    u(5:7)=0;                        % Case 2
    up1(:)=u(:);
    while t<T
        t=t+dt;
        % Saving the simulation results:
        un1=u; u=up1;
        % Disturbance Source:
        u(100)=0.5*sin(10*pi*t/T);
        for ii=2:Nodes-1
            up1(ii)=(C^2)*(u(ii+1)-2*u(ii)+u(ii-1)) - un1(ii)+2*u(ii);
        end
        clf;
        plot(x, u, 'k-o', 'linewidth', 1), shg
    end
else   % Case 3
    u(5:7)=[0.05 0.5 0.05];
    up1(:)=u(:);
    while t<T
        t=t+dt;
        % Saving the simulation results:
        un1=u; u=up1;
        % Disturbance Source:
        u(100)=0.5*sin(10*pi*t/T);
        for ii=2:Nodes-1
            up1(ii)=(C^2)*(u(ii+1)-2*u(ii)+u(ii-1)) - un1(ii)+2*u(ii);
        end
        clf;
        plot(x, u, 'r-o', 'linewidth', 1), shg
    end
end
xlabel('\it x space, [m]')
ylabel('\it u(t, x) Displacement, [m]')
title(['\it Wave propagation after t = '  num2str(T) '  [s]. ', ...
    'Case # '  num2str(Case)])
grid on