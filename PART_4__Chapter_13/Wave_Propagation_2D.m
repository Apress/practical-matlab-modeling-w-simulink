% 2D Wave propagation problem simulation
clearvars; clc
% Given parameters:
Lx = 5;   % Length along x axis
Ly=Lx;   % Length along y axis
dx=.05;  % Mesh size along x axis
dy=dx;   % Mesh size along y axis
Nx = Lx/dx;   % Number of node points along x axis
Ny=Nx;         % Number of node points along y axis
x=linspace(0, Lx, Nx);
y=x;
% Simulation period:
T=50;
% Displacement:
un = zeros(Nx,Ny);    % Memory allocation
unm1=un;
unp1 =un;

C  =.25;          % Wave propagation speed
c   = 1;
dt=C*dx/c;     % Time increment

t=0;                % Initial simulation time
% Simulation Loop:
while t<T
    % Boundary conditions:
    un(:, [1,end])  = 0;
    un([1, end], :) = 0;
    % Time evolution:
    t=t+dt;
    % Save the simulation results:
    unm1=un; un=unp1;
    %  Excitation source:
    un(50,50)=0.5*sin(30*pi*t/20);
    for ii=2:Nx-1
        for jj=2:Ny-1
            unp1(ii, jj)=2*un(ii, jj)-unm1(ii, jj)+...
                (C^2)*(un(ii+1,jj)+un(ii,jj+1)-4*un(ii, jj)+un(ii-1, jj)+un(ii,jj-1));
        end
    end
    surfc(x, y, un'), colorbar; shg
    caxis([-0.15 0.25])   % Pseudocolor axis scaling.
    title([' Simulation results after t = '  num2str(t) '  [s]'])
    pause(dt)
    axis tight
end
xlabel('Width, [m] ')
ylabel('Length, [m] ')
zlabel('Displacement, [m]')
%% Contour plot
figure(2)
contourf(x, y, un'), colorbar; shg
title([' Simulation results after t = '  num2str(t) '  [s]'])
axis tight
xlabel('Width, [m] ')
ylabel('Length, [m] ')
