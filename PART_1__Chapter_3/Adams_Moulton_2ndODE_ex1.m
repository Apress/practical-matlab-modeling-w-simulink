% ADAMS-Moulton 1st order method
% Adams_Moulton_2ndODE_ex1.m
% Part 1
clearvars; close all
Fn(1,:)=[1, 2];      % ICs: u0 at t0
tend=15;              % max. time limit
h=0.10;                % time step size
t=0:h:tend;           % time space 
steps=length(t);   % # of steps
% Function is defined via anonymous function: 
Fcn =@(t, y1, y2)([y2, -y2+sin(t)]);
for ii=1:steps-1
% Predicted solution by EULER's forward method here: 
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% ADAMS-Moulton method: 2-step starts from here
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii+1),Fn(ii, 1),Fn(ii,2));
end
plot(t, Fn(:,1), 'bs-'), grid on; hold on

% ADAMS-Moulton 2-step Method
% Part 2
clearvars Fn
Fn(1,:)=[1, 2];      % ICs: u0 at t0
Fcn =@(t, y1, y2)([y2, -y2+sin(t)]);
for ii=1:steps-1
% EULER's forward method is used here
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% ADAMS-Moulton method: 2-step starts from here
Fn(ii+1,:)=Fn(ii,:)+(h/2)*(Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
end
plot(t, Fn(:,1), 'mx--')

% ADAMS-Moulton 3-step Method
% Part 3
clearvars Fn
Fn(1,:)=[1, 2]; 
Fcn =@(t, y1, y2)([y2, -y2+sin(t)]);
for k=1:steps-2
% 1st: Predicted value by EULER's forward method 
Fn(k+1,:)=Fn(k,:)+h*Fcn(t(k), Fn(k, 1),Fn(k,2));
% 2nd: Corrected value by trapezoidal rule
Fn(k+1,:)=Fn(k,:)+(h/2)*(Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+ ...
Fcn(t(k),Fn(k,1),Fn(k,2)));
% Predicted solution:
Fn(k+2,:)=Fn(k+1,:)+(3*h/2)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-...
    (h/2)*Fcn(t(k),Fn(k,1),Fn(k,2));
% ADAMS-Moulton method: 3-step starts from here
Fn(k+2,:)=Fn(k+1,:)+h*((5/12)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))+...
    (2/3)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-...
    (1/12)*Fcn(t(k),Fn(k,1),Fn(k,2)));
end
plot(t, Fn(:,1), 'ko:')

% ADAMS-Moulton 4-step Method
% Part 4
clearvars Fn 
Fn(1,:)=[1, 2]; 
Fcn =@(t, y1, y2)([y2, -y2+sin(t)]);
for k=1:steps-3
% 1st Predicted value: by Euler's forward method
Fn(k+1,:)=Fn(k,:)+h*Fcn(t(k),Fn(k,1),Fn(k,2));
% 1st Corrected value: by trapezoidal rule
Fn(k+1,:)=Fn(k,:)+(h/2)*(Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+...
Fcn(t(k),Fn(k,1),Fn(k,2)));
% 2nd Predicted value
Fn(k+2,:)=Fn(k+1,:)+(3*h/2)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-...
(h/2)*Fcn(t(k),Fn(k,1),Fn(k,2));
% 2nd Corrected value
Fn(k+2,:)=Fn(k+1,:)+h*((5/12)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))+...
(2/3)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-... 
(1/2)*Fcn(t(k),Fn(k,1),Fn(k,2)));
% Predicted solution:
Fn(k+3,:)=Fn(k+2,:)+h*((23/12)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))-...
(4/3)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+...
(5/12)*Fcn(t(k),Fn(k,1),Fn(k,2)));
% Corrected solution by ADAMS-Moulton method 4-step from here:
Fn(k+3,:)=Fn(k+2,:)+h*((3/8)*Fcn(t(k+3),Fn(k+3,1),Fn(k+3,2))+...
(19/24)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))-...
(5/24)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+...
(1/24)*Fcn(t(k),Fn(k,1),Fn(k,2)));
end
plot(t, Fn(:,1), 'k-.*')

% ADAMS-Moulton’s 5th-order method
% Part 5
clearvars Fn
Fn(1,:)=[1, 2]; 
Fcn =@(t, y1, y2)([y2, -y2+sin(t)]);
for k=1:steps-4
% 1st Predicted value: by Euler's forward method
Fn(k+1,:)=Fn(k,:)+h*Fcn(t(k),Fn(k,1),Fn(k,2));
% 1st Corrected value: by trapezoidal rule
Fn(k+1,:)=Fn(k,:)+(h/2)*(Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+...
Fcn(t(k),Fn(k,1),Fn(k,2)));
% 2nd Predicted value
Fn(k+2,:)=Fn(k+1,:)+(3*h/2)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-...
(h/2)*Fcn(t(k),Fn(k,1),Fn(k,2));
% 2nd Corrected value
Fn(k+2,:)=Fn(k+1,:)+h*((5/12)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))+...
(2/3)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-... 
(1/2)*Fcn(t(k),Fn(k,1),Fn(k,2)));
% 3rd Predicted solution:
Fn(k+3,:)=Fn(k+2,:)+h*((23/12)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))-...
(4/3)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+...
(5/12)*Fcn(t(k),Fn(k,1),Fn(k,2)));
% Corrected solution by ADAMS-Moulton method 4-step from here:
Fn(k+3,:)=Fn(k+2,:)+h*((3/8)*Fcn(t(k+3),Fn(k+3,1),Fn(k+3,2))+...
(19/24)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))-...
(5/24)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))+...
(1/24)*Fcn(t(k),Fn(k,1),Fn(k,2)));
% Predicted solution:
Fn(k+4,:)=Fn(k+3,:)+h*((55/24)*Fcn(t(k+3),Fn(k+3,1),Fn(k+3,2))-...
(59/24)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))+...
(37/24)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-...
(3/8)*Fcn(t(k),Fn(k,1),Fn(k,2)));
% Corrected solution by ADAMS-Moulton 5-step method from here:
Fn(k+4,:)=Fn(k+3,:)+h*((251/720)*Fcn(t(k+4),Fn(k+4,1),Fn(k+4,2))+...
(646/720)*Fcn(t(k+3),Fn(k+3,1),Fn(k+3,2))-...
(264/720)*Fcn(t(k+2),Fn(k+2,1),Fn(k+2,2))+...
(106/720)*Fcn(t(k+1),Fn(k+1,1),Fn(k+1,2))-...
(19/720)*Fcn(t(k),Fn(k,1),Fn(k,2)));
end
plot(t, Fn(:,1), 'g--', 'linewidth', 2), grid on
title('Adams-Moulton method simulation of: $$ \frac{d^2y}{dt^2} = sin(t)-\frac{dy}{dt} $$', 'interpreter', 'latex')
xlabel '\it t', ylabel('\it Solution, y(t)')
% Analytical solution of the problem: 
Y=dsolve('D2u=-Du+sin(T)', 'u(0)=1, Du(0)=2','T');
Y=double(subs(Y,'T',t)); 
plot(t, Y, 'r-')
legend('1-step','2-step','3-step','4-step','5-step', 'DOLVE', 'location', 'southeast')
hold off
