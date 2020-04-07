function BVP_EX5
Solutions_initial = bvpinit(0:.0025:1,[10 10]);
tol=1e-16; % Tolerance
OPT = bvpset('stats','on','abstol',tol,'reltol',tol,'Nmax',1000);
solutions_final=bvp4c(@ODE_fun1,@BC_fun1,Solutions_initial, OPT);
x = 0:.0025:1; y = deval(solutions_final, x);
close all
figure(1), plot(x, y(1,:), 'b', 'linewidth', 2);  
title('\it Solutions of: $\frac{d^2y}{dt^2}-(\alpha+\beta)\frac{dy}{dt}+\alpha+\beta*y(t)=0$', 'interpreter', 'latex'); grid on
xlabel('\it t')
ylabel('\it Solution, y(t)'), 
xlim([-.05 1.05])
figure(2) 
yyaxis left
plot(x, y(1,:),'b', 'linewidth', 2) 
title('\it Solutions of: $\frac{d^2y}{dt^2}-(\alpha+\beta)\frac{dy}{dt}+\alpha+\beta*y(t)=0$', 'interpreter', 'latex'); grid on
grid on
ylabel('\it Solution: y(t)')
xlabel('\it t') 
yyaxis right
plot(x,y(2,:),'m--','linewidth', 2)
ylabel('\it $\frac{dy}{dt}$', 'Interpreter', 'latex') 
axis([-0.05 1.05 -5  5]), grid on 
legend('\it Solution: y(t)', '\it Derivative: $\frac{dy}{dt}$', 'Interpreter', 'latex', 'location', 'southwest');
function dydx = ODE_fun1(~,y)
        alpha=100; beta=-100;
    dydx = [ y(2),     (alpha+beta)*y(2)-alpha*beta*y(1)];
end
function res = BC_fun1(y1,yend)
res = [ 1-y1(1) ,   1-yend(1)];
end
end
