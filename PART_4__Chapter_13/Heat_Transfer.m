% Given Data:
global ro cp k q
k = 666;         % [W/m-K]
L  = 0.25;       % [m]
ro  = 1000;     % [kg/m^3]
cp = 500;       % [J/kg-K]
q   = 5e6;       % [W/m^2]  
tend = 5;        % [s] 
m=0;              % Cartesian coordinate system
x = linspace(0, L, 200);
t = linspace(0, tend, 50);
% Solution Computed:
SOL=pdepe(m, @PDEfun, @ICfun, @BCfun, x, t);
TEMP=SOL(:,:,1);
figure(1)
plot(x, TEMP(end,:), 'b-', 'linewidth', 2), grid on
title(sprintf('Computed Solution @ t = %s', num2str(tend)))
xlabel('\it Distance, [m]')
ylabel('\it Temperature (\circC)')
figure(2)
plot(t, TEMP(:,1),  'k-', 'linewidth', 2), grid on
title(sprintf('Computed Solution @ t = %s', num2str(tend)))
xlabel('\it Time, [s]')
ylabel('\it Temperature (\circC)')
figure(3)
mesh(x, t, SOL)
xlabel('\it Distance, [m]')
ylabel('\it Time, [s]')
zlabel('\it Temperature (\circC)')
title('\it Solution of: $$ k*\frac{\partial^2{T}}{\partial{x^2}}-\rho*c_p\frac{\partial{T}}{\partial{t}}=0 $$', 'Interpreter' ,'latex')
axis tight
function [c, f, s] = PDEfun(x, t, u, DuDx)
% PDE1
global ro cp k
c=ro*cp;
f=k*DuDx;
s=0;
end
function u0=ICfun(x)
% Initial conditions:
u0=0;
end
function [pl, ql, pr, qr] =BCfun(xl, ul, xr, ur, t)
% Boundary Condtions
global q
pl=q;           % At the left edge where the heat source is: q+k*dT/dx=0
ql=1;
pr=ur;
qr=0;          % At the right edge: ur=0    
end
