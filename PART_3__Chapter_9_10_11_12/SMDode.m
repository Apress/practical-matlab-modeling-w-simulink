function  SMDode(Mass,Damping, Stiffness)
%{
SMDode.m. Spring-Mass-Damper system behavior analysis 
with the given Mass, Damping and Stiffness values.
Note: an order of input argument data is important.
The system's damper has non-linear properties expressed 
with D*|u'|*u' e.g., abs(velocity)*velocity
Solver ode15s is employed; yet, other solvers, viz.
ODE15S, ODE23S, ODE23T, ODE23TB, can be used, as well.
Problem parameters evaluated within nested functions.
%}

 if nargin < 1
%  Some default values for parameters: Mass, Damping & Stiffness
%  in case not specified by the user
   Mass = 1;          % [kg]
   Damping=1001;      % [Ns/m] 
   Stiffness=1000;    % [N/m]   
 end
 
tspan = [0; min(20,5*(Damping/Mass))]; % Several periods
u0 = [0; 1];                           % Initial conditions 

% Options for ODESETs can be switched off
options = odeset('Jacobian',@Jacobian); 
 
% [t,u] = ode15s(@f,tspan,u0,[]); % without options
[t,u] = ode15s(@f,tspan,u0,options);
 
figure;
plot(t,u(:,1),'r-', t, u(:,2), 'b-.', 'MarkerSize', 5,... 
    'LineWidth', 1.5);
title(['\it Spring-Mass-Damper System: ',... 
'M = ' num2str(Mass), '[kg]' '; D = ' num2str(Damping),...  
'[Ns/m]', '; S = ' num2str(Stiffness), '[N/m]']);
xlabel('time t')
grid on
axis tight
axis([tspan(1) tspan(end) -0.1 0.1]); % Axis limits are set  
hold on
Acceleration=-(Damping/Mass)*abs(u(:,2)).*u(:,2)-... 
(Stiffness/Mass)*u(:,1);
plot(t, Acceleration,'k--', 'MarkerSize', 3, 'LineWidth', 1);
legend('Displacement', 'Velocity', 'Acceleration');
ylabel('Displacement, Velocity, Acceleration')
hold off; xlim([0, 3])

% -----------------------------------------------------------
% Nested functions: Mass, Damping and Stiffness are provided          
% by the outer function.
%------------------------------------------------------------
  function dudt = f(t, u)
% Derivative function.  Mass, Damping and Stiffness are provided 
% by the outer function or taken default (example values) 
  dudt = [            u(2); 
        -(Damping/Mass)*abs(u(2))*u(2)-(Stiffness/Mass)*u(1) ]; 
  end 
% ----------------------------------------------------------- 
    
  function dfdu = Jacobian(t, u)
% Jacobian function. Mass, Damping and Stiffness are provided by 
% the main function or taken default values for no inputs.   
    dfdu = [         0,                  1;
             -(Stiffness/Mass),  -(Damping/Mass)*abs(u(2))-... 
             (Damping/Mass)*u(2)*sign(u(2)) ];
  end % 
% -----------------------------------------------------------

end  % SMDode.m
