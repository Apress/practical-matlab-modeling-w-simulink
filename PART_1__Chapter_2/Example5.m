% Example5.m
%%  ADAMS-Moulton 1, 2, 3, 4 and 5 step Methods.
clc; close all; clearvars
Fn0=0.5;            % ICs: u0 at t0
tend=10;             % end time 
h=.1;                   % time step size
t=0:h:tend;          % time space 
steps=length(t);  % number of steps
% Part 1
% ADAMS-Moulton 1-step Method
% NB: Dy = f(y,t)=-2*y^2*t defined via Function Handle
Fcn=@(Fn,t)(-2*(Fn.^2).*t); 
% Memory allocation with ZERO matrices
Fn=[Fn0, zeros(1,steps-1)];
for ii=1:steps-1
% EULER's forward method is used here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii), t(ii));
% ADAMS-Moulton method: 2-step starts from here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii+1), t(ii+1));
end
plot(t, Fn, 'bs-'), grid on
hold on
%%   ADAMS-Moulton 2-step Method
% Part 2
Fcn=@(Fn,t)(-2*(Fn.^2).*t); 
% Memory allocation with ZERO matrices
Fn=[Fn(1), zeros(1,steps-1)];
for ii=1:steps-1
% EULER's forward method is used here
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii), t(ii));
% ADAMS-Moulton method: 2-step starts from here
Fn(ii+1)=Fn(ii)+(h/2)*(Fcn(Fn(ii+1), t(ii+1))+Fcn(Fn(ii),t(ii)));
end
plot(t, Fn, 'mx--'), grid on
%%   ADAMS-Moulton 3-step Method
% Part 3
% Memory allocation with ZERO matrices
Fn=[Fn0, zeros(1,steps-1)];
for ii=1:steps-2
% Predicted value by Euler's forward method
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii),t(ii));
% Corrected value by trapezoidal rule
Fn(ii+1)=Fn(ii)+(h/2)*(Fcn(Fn(ii+1),t(ii+1))+Fcn(Fn(ii), t(ii)));
% Predicted solution:
Fn(ii+2)=Fn(ii+1)+(3*h/2)*Fcn(Fn(ii+1), t(ii+1))-(h/2)*Fcn(Fn(ii), t(ii));
% ADAMS-Moulton method: 3-step starts from here
Fn(ii+2)=Fn(ii+1)+h*((5/12)*Fcn(Fn(ii+2),t(ii+2))+...
    (2/3)*Fcn(Fn(ii+1),t(ii+1))-(1/12)*Fcn(Fn(ii),t(ii)));
end
plot(t, Fn, 'ko-'), grid on
%%   ADAMS-Moulton 4-step Method
% Part 4
% Memory allocation with ZERO matrices
Fn=[Fn0, zeros(1,steps-1)];
for ii=1:steps-3
% Predicted value by Euler's forward method
Fn(ii+1)=Fn(ii)+h*Fcn(Fn(ii),t(ii));
% Corrected value by trapezoidal rule
Fn(ii+1)=Fn(ii)+(h/2)*(Fcn(Fn(ii+1), t(ii+1))+Fcn(Fn(ii), t(ii)));
% Predicted value
Fn(ii+2)=Fn(ii+1)+(3*h/2)*Fcn(Fn(ii+1),t(ii+1))-... 
    (h/2)*Fcn(Fn(ii),t(ii));
% Corrected value
Fn(ii+2)=Fn(ii+1)+h*((5/12)*Fcn(Fn(ii+2),t(ii+2))+...
    (2/3)*Fcn(Fn(ii+1),t(ii+1))-(1/2)*Fcn(Fn(ii),t(ii)));
% Predicted solution:
Fn(ii+3)=Fn(ii+2)+h*((23/12)*Fcn(Fn(ii+2), t(ii+2))-...
    (4/3)*Fcn(Fn(ii+1), t(ii+1))+(5/12)*Fcn(Fn(ii),t(ii)));
% ADAMS-Moulton method: 4-step starts from here
Fn(ii+3)=Fn(ii+2)+h*((3/8)*Fcn(Fn(ii+3),t(ii+3))+...
  (19/24)*Fcn(Fn(ii+2),t(ii+2))-(5/24)*Fcn(Fn(ii+1),t(ii+1))+...
  (1/24)*Fcn(Fn(ii),t(ii)));
end
plot(t, Fn, 'gh--'), grid on
%%  ADAMS-Moulton 5-step Method
% Part 4
% Memory allocation with ZERO matrices
Fn=[Fn(1), zeros(1,steps-1)];
for k=1:steps-4
% Predicted value by Euler's forward method
Fn(k+1)=Fn(k)+h*Fcn(Fn(k),t(k));
% Corrected value by trapezoidal rule
Fn(k+1)=Fn(k)+(h/2)*(Fcn(Fn(k+1), t(k+1))+Fcn(Fn(k), t(k)));
% Predicted value
Fn(k+2)=Fn(k+1)+(3*h/2)*Fcn(Fn(k+1), t(k+1))- (h/2)*Fcn(Fn(k),t(k));
% Corrected value
Fn(k+2)=Fn(k+1)+h*((5/12)*Fcn(Fn(k+2),t(k+2))+...
    (2/3)*Fcn(Fn(k+1),t(k+1))-(1/2)*Fcn(Fn(k),t(k)));
% Predicted value
Fn(k+3)=Fn(k+2)+h*((23/12)*Fcn(Fn(k+2), t(k+2))-...
    (4/3)*Fcn(Fn(k+2), t(k+2))+(5/12)*Fcn(Fn(k),t(k)));
% Corrected value
Fn(k+3)=Fn(k+2)+h*((3/8)*Fcn(Fn(k+3),t(k+3))+...
    (19/24)*Fcn(Fn(k+2),t(k+2))-(5/24)*Fcn(Fn(k+1),t(k+1))+...
    (1/24)*Fcn(Fn(k),t(k)));
% Predicted solution:
Fn(k+4)=Fn(k+3)+h*((55/24)*Fcn(Fn(k+3), t(k+3))-...
    (59/24)*Fcn(Fn(k+2),t(k+2))+(37/24)*Fcn(Fn(k+1),t(k+1))-...
    (3/8)*Fcn(Fn(k),t(k)));
% ADAMS-Moulton method: 5-step starts from here
Fn(k+4)=Fn(k+3)+h*((251/720)*Fcn(Fn(k+4),t(k+4))+...
(646/720)*Fcn(Fn(k+3),t(k+3))-(264/720)*Fcn(Fn(k+2),t(k+2))+ ...
(106/720)*Fcn(Fn(k+1),t(k+1))-(19/720)*Fcn(Fn(k),t(k)));
end
plot(t, Fn, 'c--', 'linewidth', 2), grid on
title('\it Solutions of Adams-Moulton method: $$\frac{dy}{dt}= -2*u^2*t, u_0=0.5$$ ', 'interpreter', 'latex')
legend('1-step', '2-step','3-step', '4-step','5-step')
xlabel '\it t', ylabel('\it Solution, y(t)'), shg
