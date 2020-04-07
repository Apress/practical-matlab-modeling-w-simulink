% IMPLICIT_2ODE_EX3.m
%% EXAMPLE 3.  m*x"+k*x=0 with ICs: x(0)=1, x'(0)=0
%{ 
IMPLICITLY defined ode solved with ode15i
m=13; k=1213;
NOTE: that how the function (handle) expression is defined in 
Fun to solve implicit ODE problem. In this case, we have switched 
from a 2nd order system into two 1st order ODE system of equations 
set equal to "0" as such: dq(1)-q(2)=0 && m*dq(2)+k*q(1)=0. 
This is the very key point in solving implicitly defined ODEs.
Fun = @(t, q, dq, k, m)([dq(1)-q(2); m*dq(2)+k*q(1)]);
NOTE: to call the anonymous function Fun in ode15i/ode45/etc, 
to use an anonymous function name is needed without @ sign.
                     E.g. ode15i(Fun, t,[],[],[],...).

NOTE: in computing dq0, we plug in q0 into two equations 
of the function Fun and by this way, we obtain the values 
of dq0 from the values of q0. Similarly, the values of the Function
 (Fun) at q0 and dq0 are computed from q0 and dq0 simultaneously.
%} 
clearvars; close all
% PART 1.
m=13; k=113;                                  
q0=[1,0]; dq0=[0,0];         % ICs               
F_atq0=[0, k]; F_atdq0=[];   % Function values at q0 and dq0 

% Consistent Initial values:
[q0, dq0]=decic(@DAE_Fun, 0, q0, dq0, F_atq0, F_atdq0,[], k, m); 
% Compute solution values with ode15i:
[t, ft]=ode15i(@DAE_Fun, [0,pi], q0,[0, 0]', [], k, m);
plot(t, ft(:,1), 'bx--', t, ft(:,2), 'kd-.'); hold on                                 

%% PART 2.
%{ 
EXPILICITLY defined ode solved with ode45.
GIVEN:  m*x"+k*x=0 with ICs: x(0)=1, x'(0)=0. 
The given 2nd order ODE can be written also as: x"+w^2*x=0.
NOTE: that how two 1st order ODEs are defined in applying ode45 
in comparison with IMPLICITLY defined ODE solved with ODE15i in the above case. 
NOTE: Third input of the anonymous function FFunc is omegaSQ that is equal to k/m
%}
FFunc=@(t, q, omegaSQ)([q(2); -omegaSQ*q(1)]);
M=13; K=113; omegaSQ=(K/M);
[t, FF]=ode45(FFunc, [0,pi], [1,0],[],  omegaSQ);
plot(t, FF(:,1), 'ro-',t, FF(:,2), 'm+-')
legend('ode15i x(t)','ode15i dx(t)','ode45 x(t)',...
'ode45 dx(t)', 'location', 'best') 
title('ode15i vs. ode45: Solutions of  $$ m*\frac{d^2x}{dt^2}+k*x=0 $$ ', 'interpreter', 'latex'), shg
xlabel('\it t')
ylabel('Solutions: $$ x(t), \frac{dx}{dt} $$', 'interpreter', 'latex')
grid on; hold off