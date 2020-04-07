% STIFF_2ODE_EX4.m
ICs=[1 0]; ts=[0, 100];
OPTs=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);  
tic;
[t, x_ODE45]=ode45(@A2_Stiff,  ts, ICs, OPTs);
t_ODE45=toc;
fprintf('Time_ode45 = %2.6f \n', t_ODE45)
clearvars 
ICs=[1 0]; ts=[0, 100];
OPTs=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
tic;
[t1, x_ODE23s]=ode23s(@A2_Stiff, ts, ICs, OPTs);
t_ODE23s=toc; 
fprintf('Time_ode23 = %2.6f \n', t_ODE23s)
clearvars 
ICs=[1 0]; ts=[0, 100];
OPTs=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
tic;
[t2, x_ODE113]=ode113(@A2_Stiff, ts, ICs, OPTs);
t_ODE113=toc;
fprintf('Time_ode113 = %2.6f \n', t_ODE113)
clearvars 
ICs=[1 0]; ts=[0, 100];
OPTs=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
tic;
[t3, Y_ODE23tb]=ode23tb(@A2_Stiff, ts, ICs, OPTs);
t_ODE23tb=toc;
fprintf('Time_ode23tb = %2.6f \n', t_ODE23tb)
clearvars 
ICs=[1 0]; ts=[0, 100];
OPTs=odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
tic;
[t4, x_ODE15s]=ode15s(@A2_Stiff,  ts, ICs, OPTs);
t_ODE15s=toc;
fprintf('Time_ode15s = %2.6f \n', t_ODE15s)
