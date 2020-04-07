% Heat flow simulation using the Iterative Method based on
% Gauss-Seidel method.
% Two dimensional heat transfer on a rectangular plate (3m-by-5m)
% with the temperature/heat flow from different sides
clc; clearvars; close all
TL = 100;     % [C] Left side
TR = 75;      % [C] Right side
Tt  = 250;     % [C] Top
Tb = 300;     % [C] Bottom
k  = 30;        % number of nodes along x axis
n = 50;         % number of nodes along y axis

W = 3;      % [m] width
H =  5;      % [m] height
x = linspace(0, W, k);  % Mesh size along x axis
y = linspace(0, H, n);   % Mesh size along y axis
[xx, yy]=meshgrid(x,y);
% Note: the mesh size differs along x axis from the one along y axis
% The mesh size along x and y axes can be set uniform
% by setting k = n. 
T=zeros(k,n);      % Memory allocation
T(1,1:n) = TL;     % Left Side of the Plate
T(k,1:n) = TR;     % Right Side of the Plate
T(1:k,n)=Tt;        % Top Side of the Plate
T(1:k,1)=Tb;       % Bottom Side of the Plate
tol = 1e-3;          % Error tolerance
Error = 1;           % Initial Error Value
m=0;
while Error>tol
     Told=T;
    for ii=2:k-1
        for jj=2:n-1
            T(ii,jj)=(1/4)*(T(ii,jj-1)+T(ii-1, jj)+T(ii+1, jj)+T(ii, jj+1)); 
        end
    end
    Error = max(max(abs((T-Told)./T)))*100;
end

figure(1)
surf(x, y,T'); colorbar;
title('\it 2D Heat Transfer Problem:  $$ \frac{\partial^2{T}}{\partial{x^2}}+\frac{\partial^2{T}}{\partial{y^2}} =0 $$ ', 'interpreter', 'latex')
xlabel('\it Width, [m]')
ylabel('\it Height, [m]')
zlabel('\it Temperature, [\circC]')
grid on; axis tight
figure(2)
ribbon(yy, T')
title('\it 2D Temperature distribution on a plate')
xlabel('\it Width in # of grids')
ylabel('\it Height, [m]')
zlabel('\it Temperature, [\circC]')
grid on; axis tight
figure(3)
contour(x, y, T'); colormap;
title('\it 2D Heat Transfer Problem:  $$ \frac{\partial^2{T}}{\partial{x^2}}+\frac{\partial^2{T}}{\partial{y^2}} =0 $$ ', 'interpreter', 'latex')
xlabel('\it Width, [m]')
ylabel('\it Height, [m]')
zlabel('\it Temperature, [\circC]')
grid on
figure(4)
pcolor(x, y, T'); shading interp; 
title('\it 2D Temperature distribution on on a plate')
xlabel('\it Width, [m]')
ylabel('\it Height, [m]')
zlabel('\it Temperature, [\circC]')
grid on; shg
