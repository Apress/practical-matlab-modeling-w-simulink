% EXAMPLE 1. (1/2)*u"+(2/5)*u'+u=2*t with ICs: u(0)=1 & u'(0)=2
% solved by EULER’s Forward Method and DSOLVE.
clearvars, close all; clc
h=0.2;          % time step size
tmax=7;       % End of simulations
t0=0;            % Start of simulations
t=t0:h:tmax;
steps=length(t);   % # of steps of evaluations
u(1,:)=[1 2];          % Initial Conditions
%{
NB: Size of the u(t) is 2-dimensional that is due to the fact
 there are two variables used to rewrite 2nd order ODE as 2 1st order ODEs.
%}
% Way # 1. Direct way of expressing a system of ODEs 
for k=2:steps
    f=[u(k-1,2), 4*t(k)-(4/5)*u(k-1,2)-2*u(k-1,1)];
    u(k,:)=u(k-1,:)+f*h;
end
% Way # 2. Anonymous Function (@)
%{
F = @(t, u1, u2)([u2, 4*t-(4/5)*u2-2*u1]);
for k=2:steps
    F1=F(t(k-1), u(k-1, 1), u(k-1, 2));
    u(k,:)=u(k-1,:)+F1*h;
end
%}
% Way # 3.  Function File called: FuFu.m 
%{
function dudt = FuFu(t, u1, u2)
 dudt = [u2, 4*t-(4/5)*u2-2*u1]
 end
%}
%{
for k=2:steps
    F1=feval(@FuFu,t(k-1), u(k-1, 1), u(k-1, 2));
    u(k,:)=u(k-1,:)+F1*h;
end
%}
% Way #4 
%{
 syms T u1 u2 
  f=[u2, 4*T-(4/5)*u2-2*u1];
  matlabFunction(f, 'file', 'F');
for k=2:steps
    F1=feval(@F, t(k-1), u(k-1, 1), u(k-1, 2));
    u(k,:)=u(k-1,:)+F1*h;
end
%}
plot(t, u(:,1), 'b-o'), grid minor, hold on
% Analytical solution of the problem:
syms x(T) Dx T
Dx=diff(x, T);
D2x=diff(x, T, 2);
Equation=D2x==-(4/5)*Dx-2*x+(4*T);
ICs = [x(0)==1, Dx(0)==2];
y=dsolve(Equation, ICs);
Y=double(subs(y,'T',t));
% or use: U=vectorize(u); T=t; U=eval(U);
plot(t, Y, 'g-', 'linewidth', 2)
legend('EULER forward method','Analytical Solution', 'location', 'southeast')
title('\it Solutions of: $$\frac{1}{2}*\frac{d^2u}{dt^2}+\frac{2}{5}*\frac{du}{dt}+u=2*t $$', 'interpreter', 'latex')
xlabel('\it t'), ylabel('\it Solution, u(t)'), hold off
axis tight; shg
