% iLaplace_Ex7.m
% Solution of a 2nd order non-homogenuous ODE with discontinuous forcing
% function.
syms t s
F=5*(exp(-2*s)-exp(-10*s))/s; % Forcing fcn
Y=2*s^2+s+2;                        % ODE 
TF=F/Y;                                 % Equation
TFt=ilaplace(TF);                    % Inverse Laplace
pretty(TFt);                             % Display
Sol=vectorize(TFt);                 % Vectorization 
t=linspace(0, 20, 400);            % Time space (of independent variable t)
S=eval(Sol);                            % Numerical solutions computed
plot(t, S, 'b-', 'linewidth', 2); 
grid minor
title('\it Solution of: $$ 2*\frac{d^2y}{dt^2}+3*\frac{dy}{dt}-2*y=g(t) $$', 'interpreter', 'latex')
Str='\it g(t) is a discontinuous Forcing Fcn';
text(7.5, 3.75, Str, 'backgroundcolor', [1 1 1]);
grid on, xlabel('\it t '), ylabel('\it Solution, y(t) '), shg
