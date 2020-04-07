% Adams_Moulton_2ndODE_ex2.m
% EXAMPLE 2. y"+y'=sin(yt) with ICs: [1, 2]
% ADAMS-Moulton 1st-order method
% Part 1
clearvars; close all
Fn(1,:)=[1, 2];      % ICs: u0 at t0
tend=13;              % End of simulations
h=0.1;                  % Step size
t=0:h:tend;           % Simulation space 
steps=length(t);   % # of steps
 % NB: y"+y'=sin(yt) =>DDy = f(t,y,dy)=sin(yt)-dy defined by anonymous Function (@): 
Fcn =@(t, u1, u2)([u2, -u2+sin(u1*t)]);
for ii=1:steps-1
% 1-step: EULER's forward method is used here
Fn(ii,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% ADAMS-Moulton method starts from here
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii+1),Fn(ii, 1),Fn(ii,2));
end
subplot(211)
plot(t, Fn(:,1), 'bs-'), grid on; hold on

%% ADAMS-Moulton 2-order Method
% Part 2
clearvars 
Fn(1,:)=[1, 2];    
tend=13;  h=0.1; t=0:h:tend; steps=length(t);   
Fcn =@(t, y1, y2)([y2, -y2+sin(y1*t)]);
for ii=1:steps-1
% Predicted by EULER's forward method:
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% Corrected by ADAMS-Moulton method
Fn(ii+1,:)=Fn(ii,:)+(h/2)*(Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+ ...
Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
end
plot(t, Fn(:,1), 'm--p', 'markersize', 9), grid on

%% % ADAMS-Moulton 3rd-order Method
% Part 3
clearvars Fn
Fn(1,:)=[1, 2];    
for ii=1:steps-2
% 1st: Predicted value by EULER's forward method 
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% 2nd: Corrected value by trapezoidal rule
Fn(ii+1,:)=Fn(ii,:)+(h/2)*(Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Predicted solution:
Fn(ii+2,:)=Fn(ii+1,:)+(3*h/2)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(h/2)*Fcn(t(ii),Fn(ii,1),Fn(ii,2));
% ADAMS-Moulton method: 3-step starts from here
Fn(ii+2,:)=Fn(ii+1,:)+h*((5/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(2/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(1/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
end
plot(t, Fn(:,1), 'k-', 'linewidth', 2.5), grid on
legend('1-step', '2-step','3-step'), hold off
title('Adams-Moulton method simulation: $$ \frac{d^2y}{dt^2} = sin(yt)-\frac{dy}{dt} $$', 'interpreter', 'latex')
xlim([0, 13]), xlabel( '\it t'), ylabel('\it Solution, y(t)')

%% % ADAMS-Moulton 4-order Method
% Part 4
clearvars Fn
Fn(1,:)=[1, 2];    
for ii=1:steps-3
% 1st: Predicted value by EULER's forward method 
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% 2nd: Corrected value by trapezoidal rule
Fn(ii+1,:)=Fn(ii,:)+(h/2)*(Fcn(t(ii+1),Fn(ii+1,1), Fn(ii+1,2))+... 
    Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% 3rd: Predicted solution:
Fn(ii+2,:)=Fn(ii+1,:)+(3*h/2)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-... 
(h/2)*Fcn(t(ii),Fn(ii,1),Fn(ii,2));
% 3rd: Corrected ADAMS-Moulton method:
Fn(ii+2,:)=Fn(ii+1,:)+h*((5/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))...
+(2/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(1/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Predicted solution:
Fn(ii+3,:)=Fn(ii+2,:)+h*((23/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))...
-(4/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
(5/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Corrected solution by ADAMS-Moulton method 4-step from here:
Fn(ii+3,:)=Fn(ii+2,:)+h*((3/8)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2))+...
(19/24)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))-...
(5/24)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
(1/24)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
end
subplot(212)
plot(t, Fn(:,1), 'k:o', 'markersize',9, 'markerfacecolor', 'y'), hold on

%% % ADAMS-Moulton 5-order Method
% Part 5
clearvars Fn
Fn(1,:)=[1, 2];    
for ii=1:steps-4
% 1st: Predicted value by EULER's forward method 
Fn(ii+1,:)=Fn(ii,:)+h*Fcn(t(ii), Fn(ii, 1),Fn(ii,2));
% 2nd: Corrected value by trapezoidal rule
Fn(ii+1,:)=Fn(ii,:)+(h/2)*(Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% 3rd: Predicted solution:
Fn(ii+2,:)=Fn(ii+1,:)+(3*h/2)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-... 
(h/2)*Fcn(t(ii),Fn(ii,1),Fn(ii,2));
% 3rd: Corrected ADAMS-Moulton method:
Fn(ii+2,:)=Fn(ii+1,:)+h*((5/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(2/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(1/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Predicted solution:
Fn(ii+3,:)=Fn(ii+2,:)+h*((23/12)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))...
-(4/3)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
(5/12)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Corrected solution by ADAMS-Moulton method 4-step from here:
Fn(ii+3,:)=Fn(ii+2,:)+h*((3/8)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2))+...
(19/24)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))-...
(5/24)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))+...
(1/24)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Predicted solution:
Fn(ii+4,:)=Fn(ii+3,:)+h*((55/24)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2)) ...
-(59/24)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(37/24)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(3/8)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
% Corrected solution by ADAMS-Moulton 5-step method from here:
Fn(ii+4,:)=Fn(ii+3,:)+ ...      
    h*((251/720)*Fcn(t(ii+4),Fn(ii+4,1),Fn(ii+4,2))+...
(646/720)*Fcn(t(ii+3),Fn(ii+3,1),Fn(ii+3,2))-...
(264/720)*Fcn(t(ii+2),Fn(ii+2,1),Fn(ii+2,2))+...
(106/720)*Fcn(t(ii+1),Fn(ii+1,1),Fn(ii+1,2))-...
(19/720)*Fcn(t(ii),Fn(ii,1),Fn(ii,2)));
end
plot(t, Fn(:,1), 'r-', 'linewidth', 2.5), grid on
legend( '4-step','5-step')
xlabel( '\it t'), ylabel('\it Solution, y(t)'); hold off; shg
xlim([0, 13])
