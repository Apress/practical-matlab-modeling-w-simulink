% Example3.m
%% MILNE's Method
% First term of f(y,t) found by Euler’s method 
% Second term of f(y,t) by 2 step Adams-Bashforth 
y0=1;                        % ICs: u0 at t0
tend=5;                     % max. time limit
h=.01;                       % time step size
t=0:h:tend;                % time space 
steps=length(t);        % # of steps
fun = @(t, y)(1-t*y^(1/3));
% Memory allocation 
y=[y0, zeros(1,steps-1)];
for ii=1:steps-3
% EULER's method used here
y(ii+1)=y(ii)+h*fun(t(ii), y(ii));
% Adams-Bashforth 2-step method used here
y(ii+2)=y(ii+1)+(3/2)*h*fun(t(ii+1),y(ii+1))-(1/2)*h*fun(t(ii),y(ii));
% MILNE's method starts from here
y(ii+3)=y(ii)+(h/3)*(8*fun(t(ii+2),y(ii+2))-4*fun(t(ii+1),... 
    y(ii+1))+8*fun(t(ii),y(ii)));
end
plot(t, y, 'b-', 'linewidth', 1.5), grid on
title('\it Milne method solution of: $$ \frac{dy}{dt}=1-t*y^\frac{1}{3} $$', 'interpreter', 'latex')
xlabel '\it t'; ylabel '\it Solution, y(t)'; shg
