function f = Fun3(t,u)
% Fun3.m is a function file.
% This function file is called by a solver ode113
f = [u(2); t.*4.0-u(1).*2.0-u(2).*(4.0./5.0)];
return
