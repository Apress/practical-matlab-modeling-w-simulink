% Unicode_2nd_ODE.m
syms y(t) t
Dy=diff(y, t);
D2y=diff(y, t, 2);
fprintf('To solve: A*ddy+B*dy+C*y=D at ICs: y(0)=a, dy(0)=b \n')
fprintf('Enter the values of [A, B, C, D] and [a, b] \n');
A = input('Enter A = ');
B = input('Enter B = ');
C = input('Enter C = ');
D = input('Enter D = ');
a = input('Enter a = ');
b = input('Enter b = ');
% Given ODE equation: 
Equation =D2y== (1/A)*(D - B*Dy-C*y);
ICs = [y(0)==a; Dy(0)==b];
Solution=dsolve(Equation, ICs); 
% Display the computed anaytical solution in the command window:
pretty(Solution)  
fplot(Solution, [0, 5], 'b-'), grid on
xlabel('\it t')
ylabel('\it Solution, y(t) ')
title('\it Solution of: $$\frac{A*d^2y}{dt^2}+\frac{B*dy}{dt}+C*y=D, y(0)=a, dy(0)=b$$', 'interpreter', 'latex')
gtext(['\it A = '  num2str(A), '\it,  B = '  num2str(B), '\it,  C = '  num2str(C), '\it,  D = '  num2str(D)])
gtext(['\it Initial Conditions:  a = '  num2str(a), '\it,  b = '  num2str(b)])
grid on; shg