% Taylor series method 
% Example4.m solves dy/dt=3+exp(-t)-2*y; y(0)=1
t0=0;                         
tend=10;
h=0.05; 
t=t0:h:tend;
steps=length(t)-1;
y0=1; 
y2=[y0, zeros(1, steps-1)];   % Memory allocation for 2nd-order
y3=[y0, zeros(1, steps-1)];   % Memory allocation for 3rd-order
for ii=1:steps
   % 2nd-order Taylor series: 
   y2(ii+1)=y2(ii)+h*(3+exp(-t(ii))-2*y2(ii))+...
   (h^2/2)*(-exp(-t(ii))-2*(3+exp(-t(ii))-2*y2(ii)));
   % 3rd-order Taylor series: 
   y3(ii+1)=y3(ii)+h*(3+exp(-t(ii))-2*y3(ii))+...
   (h^2/2)*(-exp(-t(ii))-2*(3+exp(-t(ii))-2*y3(ii)))+...
   (h^3/6)*(exp(-t(ii))-2*(-exp(-t(ii))-2*(3+exp(-t(ii))-2*y3(ii))));
end
plot(t, y2, 'bx--', t,y3, 'ko:', 'linewidth', 1.5), grid minor
xlabel '\it t', ylabel('\it Solution, y(t)') 
syms u(x)  x
Du=diff(u, x);
Equation=Du==3+exp(-x)-2*u;
IC = u(0)==1;
u_sol=dsolve(Equation, IC);
U_sol=vectorize(u_sol); x=t;
Solution=eval(U_sol);
hold on
plot(x, Solution, 'r-', 'linewidth', 1.5)
title('\it Solutions of: $$ \frac{dy}{dt}+2*y-e^{-t}=3, y_0=1 $$', 'Interpreter', 'latex')
legend('\it 2nd order Taylor series','\it 3rd order Taylor series', ...
'\it Analytical solution'), hold off
