function f=DAE_Fun(~,q, dq, k, m)
%{
A function file: DAE_Fun.m
NOTE: that following a sequence of arguments is IMPERATIVE. 
If the order of k switched/swapped with m then totally 
different results are obtained. Values for k and m (m=13, k=113) 
need to be assigned before ode solver in the above simulation script.
%}
f = [dq(1)-q(2), m*dq(2) + k*q(1)]';
return
