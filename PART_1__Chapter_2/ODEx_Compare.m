clearvars; clc
disp('ODE45 performance: ')
tic;
options=odeset('stats','on','RelTol',1e-5,'AbsTol',1e-7);
ode45(@(t,y)(-200*t*y^2), [0, 2], 2.5, options);
toc;
disp('%--------------------------------%    ')
clearvars
disp('ODE113 performance: ')
tic;
options=odeset('stats','on','RelTol',1e-5,'AbsTol',1e-7);
ode113(@(t,y)(-200*t*y^2), [0, 2], 2.5, options);
toc;
disp('%--------------------------------%    ')
clearvars 
disp('ODE23s performance: ')
tic;
options=odeset('stats','on','RelTol',1e-5,'AbsTol',1e-7);
ode23s(@(t,y)(-200*t*y^2), [0, 2], 2.5, options);
toc;
disp('%--------------------------------%    ')
clearvars 
display('ODE15s performance: ')
tic;
ode15s(@(t,y)(-200*t*y^2),[0,2], 2.5, odeset('stats','on', ... 
    'RelTol', 1e-5,'AbsTol',1e-7));
toc;
disp('% ------------------------------%     ')
clearvars 
disp('ODE23 performance: ')
tic;
ode23(@(t,y)(-200*t*y^2), [0, 2], 2.5,... 
    odeset('stats','on','RelTol',1e-5,'AbsTol',1e-7));
toc;
disp('%--------------------------------%    ')
