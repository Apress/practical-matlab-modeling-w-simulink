% Falling_Object.m
%% Assignment. Falling object.
% Given: m*dv/dt=m*g-b*v; b/m=0.1 [1/sec]; Case # 1.
%        m*dv/dt=m*g-b*v^2; b/m=0.001 [1/sec]; Case # 2     
%        For both cases: v(0)=0 and g=9.8 [m/sec^2];
% Step # 1. Define a function. Case # 1. dv/dt=9.8-0.1*v
%           Define a function. Case # 2. dv/dt=9.8-0.001*v
% Step # 1.Function handle is used to define an equation
f_C1=@(t,v)(9.8-0.1*v^2');
f_C2=@(t,v)(9.8-.001*v^2);
% Step # 2. ODE23tb(f, timespan, IC) defined
[time1,v1]=ode23tb(f_C1,[0,30],0);
[time2,v2]=ode23tb(f_C2,[0,30],0);
% Step # 3. ODE15s(f, timespan, IC) defined
[time1a,v1a]=ode15s(f_C1,[0,30],0);
[time2a,v2a]=ode15s(f_C2,[0,30],0);
% Step # 4. Display simulation results 
figure(1), plot(time1,v1,'k--', 'linewidth', 1.5); hold on
plot(time2,v2,'b-', 'linewidth', 1.5) 
plot(time1a, v1a,'mo',time2a, v2a, 'rx') 
legend('Case # 1 ode23tb','Case #2 ode23tb',...
'Case #1 ode15s', 'Case #2 ode15s', 'location', 'southeast')
xlabel('\it Time, [sec]'); ylabel('\it Velocity, v(t) [m/sec]');
title({'\it Case # 1: dv = 9.8-0.1*v^2', '\it Case # 2: dv = 9.8-0.001*v^2'}) 
grid on
% Step # 5. Locate terminal velocity values for both cases
v_WHICH=(v1==max(v1)); 
v_MAX=v1(v_WHICH);
% Step # 6. Add to the plot terminal velocity values
textmessage=['Case#1 - Terminal speed: '...
    num2str(v_MAX) '   [m/s]'];
gtext(textmessage); 
v2_WHICH=(v2==max(v2)); 
v2_MAX=v2(v2_WHICH);
textmessage=['Case#2 - Terminal speed: '...
    num2str(v2_MAX) '   [m/s]'];
gtext(textmessage); hold off
