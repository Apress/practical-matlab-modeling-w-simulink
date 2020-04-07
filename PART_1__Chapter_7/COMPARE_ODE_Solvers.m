% COMPARE_ODE_Solvers.m
close all
clearvars
% Part 1
%% 1st Solution Approach: DSOLVE
syms t s Y y(t)
Dy=diff(y, t);
D2y=diff(y, t, 2);
Equation = D2y==sin(5*t)-Dy-3*y;
ICs = [y(0)==3, Dy(0)==-2];
Solution_dsolve=dsolve('D2y+Dy+3*y-sin(5*t)=0', 'y(0)=3','Dy(0)+2=0');
disp('Symbolic MATH dsolve function output is: ')
pretty(Solution_dsolve)
% display plot of the solution of dsolve and compare it with LT
figure;
subplot(211)
fplot(Solution_dsolve, [0, 2*pi], 'b-', 'linewidth', 1.5)
title('DSOLVE solution of: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex') 
grid on
ylabel('\it y(t)'), xlabel('\it t')
%%  Part 2. 2nd Solution Approach: Laplace Transforms laplace/ilaplace
% Define symbolic variables' names
syms t s Y y(t)
assume([Y, t]>0)
Dy=diff(y, t);
D2y=diff(y, t, 2);
Equation = D2y==sin(5*t)-Dy-3*y;
% Laplace Transforms
LT_Y=laplace(Equation, t, s);
% Substitute the arbitrary unknown Yand Initial Conditions
LT_Y=subs(LT_Y,laplace(y(t),t, s),Y);
LT_Y=subs(LT_Y,y(0),3);
LT_Y=subs(LT_Y,subs(diff(y(t), t), t),-2);
% Solve for Y unknown
disp('Laplace Transforms of the given 2nd Order ODE with ICs')
Y=solve(LT_Y, Y)  %#ok
Solution_Laplace=ilaplace(Y);
disp('Solution found using Laplace Transforms is:')
Solution_Laplace=simplify(Solution_Laplace);
pretty(Solution_Laplace)
subplot(212)
fplot(Solution_Laplace, [0, 2*pi], 'r-', 'linewidth', 1.5); grid on
title('LAPLACE/iLAPLACE solution of: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex')
ylabel('\it y(t)'), xlabel('\it t')
 %% Part 3. 4th Solution Approach: ODE45, ODE113 solvers
Ys=@(t,y)([y(2);-(y(2)+3*y(1))+sin(5*t)]);
ICs=[3, -2];
timeSPAN=0:pi/100:2*pi;
options_ODE=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[t1, y_ODE45]=ode45(Ys, timeSPAN, ICs, options_ODE);
[t2, y_ODE113]=ode113(Ys, timeSPAN, ICs, options_ODE);
figure('name', 'ODEx solvers 1')
subplot(211)
plot(t1, y_ODE45(:,1), 'bo', t2, y_ODE113(:,1), 'k-')
ylabel('\it y(t)'), xlabel('\it t')
title('ODE45 and ODE113 solutions of: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex')
grid on
legend('\it ode45', 'ode113')
axis tight
subplot(212)
plot(t1, y_ODE45(:,2), 'bo', t2, y_ODE113(:,2), 'k-')
ylabel('\it $$ \frac{dy}{dt} $$', 'interpreter', 'latex'), xlabel('\it t')
title('ODE45 and ODE113 solutions of: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex')
grid on
legend('\it dy with ode45','\it dy with ode113', 'location', 'best')
axis tight
figure('name', 'ODEx solvers 2')
plot(y_ODE45(:,1), y_ODE45(:,2), 'bo', y_ODE113(:,1),y_ODE113(:,2), 'r-')
title('Phase plot of:  $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex')
legend('\it ode45', 'ode113'), grid on
axis tight; shg
xlabel('\it y(t)')
ylabel('\it $$ \frac{dy}{dt} $$', 'interpreter', 'latex')
%% Part 4. 5th Solution Approach: Simulink modeling
%{
NB: This model uses ODE solver ODE8 in simulation.
A solver type can be altered if needed for a better/faster solution search.
This cell first recalls and then executes the Simulink model 
COMPARE_ODE_Solvers_sim.slx that is to be put in a current directory 
of MATLAB from the archived folder.
A fixed step is set to pi/100.
%}
%set_param('COMPARE_ODE_Solvers_sim','Solver','ode8','StopTime','2*pi');
[tout, SIMout]=sim('COMPARE_ODE_Solvers_sim.slx');

%% Part 5. 6th Solution Approach: via scripts using Euler's Method
t0=0;                    % start time 
tend=2*pi;            % end time
h=pi/100;              % time step
t=t0:h:tend;           % time space
steps=length(t);    % # of steps
y=[3, -2];         % ICs: u0 at t0
for k=2:steps
    f=[y(k-1,2), sin(5*t(k-1))-3*y(k-1,1)-y(k-1,2)];
    y(k,:)=y(k-1,:)+h*f;
end
%plot(t, y), shg
%% Part 6. 6th solution approach: via scripts using 5-step Adams-Moulton method
t0=0;                    % start time 
tend=2*pi;            % end time
h=pi/100;              % time step
t=t0:h:tend;           % time space
steps=length(t);     % # of steps
Fn(1,:)=[3, -2];        % ICs: u0 at t0
% function is defined via anonymous function handle: 
Fcn =@(t, y1, y2)([y2, sin(5*t)-y2-3*y1]);
for ii=1:steps-4
% 1st: Predicted value by EULER's forward method 
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% 2nd: Corrected value by trapezoidal rule
Fn(ii+1,:)=Fn(ii,:)+(h/2)*(Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% 3rd: Predicted solution:
Fn(ii+2,:)=Fn(ii+1,:)+(3*h/2)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-... 
(h/2)*Fcn(t(ii),Fn(ii,1),Fn(ii,2));
% 3rd: Corrected ADAMS-Moulton method:
Fn(ii+2,:)=Fn(ii+1,:)+h*((5/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(2/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(1/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Predicted solution:
Fn(ii+3,:)=Fn(ii+2,:)+h*((23/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))...
-(4/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
(5/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Corrected solution by ADAMS-Moulton method 4-step from here:
Fn(ii+3,:)=Fn(ii+2,:)+h*((3/8)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2))+...
(19/24)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))-...
(5/24)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
(1/24)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Predicted solution:
Fn(ii+4,:)=Fn(ii+3,:)+h*((55/24)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2)) ...
-(59/24)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(37/24)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(3/8)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Corrected solution by ADAMS-Moulton 5-step method from here:
Fn(ii+4,:)=Fn(ii+3,:)+ ...      
    h*((251/720)*Fcn(t(ii+4),Fn(ii+4,1),Fn(ii+4,2))+...
(646/720)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2))-...
(264/720)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(106/720)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(19/720)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
end
% plot(t, Fn)
%% Part 7. Numerical values from DSOLVE and LAPLACE/iLAPLACE
SDsolve  = eval(Solution_dsolve);
SLaplace = eval(Solution_Laplace);
figure('name', 'Compare ALL 1')
plot(t, SDsolve, 'bx-'); grid on, hold on, 
xlabel('\it t'), ylabel('\it y(t)')
plot(t, SLaplace, 'ro-')
plot(t, y_ODE45(:,1), 'm^--') 
plot(t, y_ODE113(:,1), 'k<-') 
plot(tout, SIMout(:,1), 'gd-') 
plot(t, y(:,1), 'linewidth', 2)
plot(t, Fn(:,1), 'b--', 'linewidth', 1.5), grid minor
title('Solutions of: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex')
legend('dsolve','Laplace Transforms','ODE45','ODE113',... 
'Simulink', 'Euler','Adams-Moulton'), 
xlim([0, 2*pi]), hold off

figure('name', 'Compare ALL 2')
plot(y_ODE45(:,1), y_ODE45(:,2), 'mo'); grid on, hold on, 
xlabel('\it y(t)'), ylabel('\it $$ \frac{dy}{dt} $$', 'interpreter', 'latex')
plot(y_ODE113(:,1), y_ODE113(:,2), 'k<') 
plot(SIMout(:,1), SIMout(:,2), 'gd') 
plot(y(:,1), y(:,2), 'linewidth', 2)
plot(Fn(:,1), Fn(:,2),'b--', 'linewidth', 1.5), grid minor
title('Phase plot of: $$ \frac{d^2y}{dt^2}+\frac{dy}{dt}+3*y=sin(5*t) $$', 'interpreter', 'latex')
legend('ODE45','ODE113', 'Simulink', 'Euler','Adams-Moulton'), 
axis tight, hold off
%% Part 8. Residuals are computed
Res_ode45=abs(SDsolve)-abs(y_ODE45(:,1)');
Res_ode113=abs(SDsolve)-abs(y_ODE113(:,1)');
Res_sim=abs(SDsolve)-abs(SIMout(:,1)');
Res_Euler=abs(SDsolve)-abs(y(:,1)');
Res_AM=abs(SDsolve)-abs(Fn(:,1)');
Res_LTSD=abs(SLaplace)-abs(SDsolve);
figure('name', 'Residuals')
subplot(311)
plot(t, Res_ode45, 'r-',t,Res_ode113, 'k-.', t, Res_sim, 'b-'), hold on
plot(t, Res_LTSD, 'g--', 'linewidth', 1.5)
title('\it Residuals'), ylabel('\it Residual values')
legend('ode45','ode113','Simulink', 'Laplace', 'location', 'best')
subplot(312)
plot(t, Res_Euler, 'k-'), hold on
plot(t, Res_LTSD, 'g--', 'linewidth', 1.5)
ylabel('\it Residual values')
legend('Euler', 'Laplace', 'location', 'best')
subplot(313)
plot(t, Res_AM, 'm-', 'linewidth', 1.5), hold on
plot(t, Res_LTSD, 'g--', 'linewidth', 1.5)
ylabel('\it Residual values')
xlabel('\it t')
legend('Adams-Moulton', 'Laplace', 'location', 'best') 
xlim([0, 2*pi]), shg
