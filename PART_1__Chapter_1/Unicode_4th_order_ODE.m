% Unicode_4th_order_ODE.m
%% Unicode to Solve up to 4-th order non-homogenuous linear ODEs of IVPs
% 
% EQN:  Ax+B*dx + C*ddx + ... = F
% user entry (1) is ODE order #:  N
% user entry (2) values of:            A, B, C, ....
% user entry (3) initial conditions: IC1, IC2, IC3,...
syms x(t)
Dx=diff(x, t);
D2x=diff(x, t, 2);
D3x=diff(x, t, 3);
D4x=diff(x, t, 4);
D5x=diff(x, t, 5);
D6x=diff(x, t, 6);
D7x=diff(x, t, 7);
N = input('Order of the ODE:  N  =  ');
if N == 1
disp('Solving: A*x+B*dx=F with one initial condtion: x(0) = ? ')
A = input(' Enter:  A =         ');
B = input(' Enter:  B =         ');
F = input(' Enter:  F =         ');
EQN = A*x+B*Dx==F;
IC1 = input(' Enter: x(0) =    ');
IC = x(0)==IC1;
Str0 ='Solution of: $$ A*x+B*\frac{dx}{dt}=F $$';
Str1=sprintf('A = %d,  B = %d, F = %d',  A, B, F);
Str2 =(['\it Initial Conditions: [ '  num2str(IC1), '\it] ' ]);
elseif N == 2
disp('Solving: A*x+B*dx+C*ddx=E with two initial condtions: x(0) = ?, dx(0) = ? ')
A = input(' Enter:  A =         ');
B = input(' Enter:  B =         ');
C = input(' Enter:  C =         ');
F = input(' Enter:  F =         ');
EQN = A*x+B*Dx+C*D2x==F;
IC1 = input(' Enter:   x(0) =    ');
IC2 = input(' Enter: dx(0) =    ');
IC = [x(0)==IC1, Dx(0)==IC2];
Str0 ='Solution of: $$ A*x+B*\frac{dx}{dt}+C*\frac{d^2x}{dt^2}=F $$';
Str1=sprintf('A = %d,  B = %d, C = %d, F = %d',  A, B, C, F);
Str2 =(['\it Initial Conditions: [ '  num2str(IC1), ', ' num2str(IC2), '\it ]']);
elseif N == 3
disp('Solving: A*x+B*dx+C*ddx+D*dddx=F ')
disp('with three initial condtions: x(0) = ?, dx(0) = ? ddx(0) = ?')
A = input(' Enter:  A =         ');
B = input(' Enter:  B =         ');
C = input(' Enter:  C =        ');
D = input(' Enter:  D =        ');
F = input(' Enter:  F =         ');
EQN = A*x+B*Dx+C*D2x+D*D3x==F;
IC1 = input(' Enter:    x(0) =    ');
IC2 = input(' Enter:  dx(0) =    ');   
IC3 = input(' Enter: ddx(0) =    ');       
IC = [x(0)==IC1, Dx(0)==IC2, D2x(0)==IC3];
Str0 ='Solution of: $$ A*x+B*\frac{dx}{dt}+C*\frac{d^2x}{dt^2}+D*\frac{d^3x}{dt^3}=F $$';
Str1=sprintf('A = %d,  B = %d, C = %d, D = %d, F = %d',  A, B, C, D, F);
Str2 =(['\it Initial Conditions: [ '  num2str(IC1), ', ' num2str(IC2), ', ' num2str(IC3),'\it ]']);
else
 disp('Solving: a*x+b*dx+c*ddx+d*dddx+e*ddddx=0 ')
disp('with four initial condtions: x(0) = ?, dx(0) = ? ddx(0) = ?, dddx(0) = ?')
A = input(' Enter:  A =        ');
B = input(' Enter:  B =        ');
C = input(' Enter:  C =        ');
D = input(' Enter:  D =        ');
E = input(' Enter:   E =        ');
F = input(' Enter:    F =        ');
EQN = A*x+B*Dx+C*D2x+D*D3x+E*D4x==F;
IC1 = input(' Enter:    x(0)  =    ');
IC2 = input(' Enter:  dx(0)  =    ');   
IC3 = input(' Enter: ddx(0)  =    ');  
IC4 = input(' Enter: dddx(0) =   ');
IC = [x(0)==IC1, Dx(0)==IC2, D2x(0)==IC3, D3x(0)==IC4];
Str0 ='Solution of: $$ A*x+B*\frac{dx}{dt}+C*\frac{d^2x}{dt^2}+D*\frac{d^3x}{dt^3} +E*\frac{d^4x}{dt^4}=F $$';
Str1=sprintf('A = %d,  B = %d, C = %d, D = %d,  E = %d, F = %d',  A, B, C, D, E, F);
Str2 =(['\it Initial Conditions: [ '  num2str(IC1),', ' num2str(IC2), ', ' num2str(IC3), ', ' num2str(IC3) '\it ]']);
end
Solution = dsolve(EQN, IC);
fplot(Solution, [0, 3*pi], 'LineWidth', 2), grid on
xlabel('\it t')
ylabel('\it Solution, y(t) ')
title(Str0, 'Interpreter', 'latex')
gtext(Str1)
gtext(Str2)
grid on; shg

