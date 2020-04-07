function y=F_ANOBEL
%HELP: Akzo-NOBEL Problem. 
% Version of Chemical Akzo-Nobel problem taken from ODE problems compiled
% by W. Lioen and H. de Swart. 

% This problem originates from Akzo Nobel Central Research in Arnhem, The
% Netherlands. It describes a chemical process, in which 2 species, FLB and
% ZHU, are mixed, while carbon dioxide is continuously added. Resulting
% species of importance is ZLA. The names of the chemcial species are
% fictitious.
% Akzo-NOBEL implemented via Runge-Kutta Method in scripts

close all
% ICs:
Ks=115.83;
y(1,:)=[.437, .00123, 0, .007, 0, Ks*.437*.007];
%%%%%  NOTE: it's VERY important to show the ICs with proper indexing,
%%%%%  such as, y(1, :) or y(:,:) is one or :# of rows & :# of columns. 
%%%%%  Otherwises, anonymous function evaluation keeps giving an error on
%%%%%  matrix dimensions exceed ....
tstart=0;
hstep=.1;
tend=180; 
t=tstart:hstep:tend;
for ii=1:length(t)-1
    k1=F_anobel(y(ii,1), y(ii,2),y(ii,3), y(ii,4), y(ii,5), y(ii,6));
    k2=F_anobel(y(ii,1)+hstep*k1(:,1)/2, y(ii,2)+hstep*k1(:,2)/2,...
        y(ii,3)+hstep*k1(:,3)/2, y(ii,4)+hstep*k1(:,4)/2,...
        y(ii,5)+hstep*k1(:,5)/2, y(ii,6)+hstep*k1(:,6)/2);
    k3=F_anobel(y(ii,1)+hstep*k2(:,1)/2, y(ii,2)+hstep*k2(:,2)/2, ...
        y(ii,3)+hstep*k2(:,3)/2, y(ii,4)+hstep*k2(:,4)/2,...
        y(ii,5)+hstep*k2(:,5)/2, y(ii,6)+hstep*k2(:,6)/2);
    k4=F_anobel(y(ii,1)+hstep*k3(:,1), y(ii,2)+hstep*k3(:,2), ...
        y(ii,3)+hstep*k3(:,3)/2, y(ii,4)+hstep*k3(:,4)/2,...
        y(ii,5)+hstep*k3(:,5)/2, y(ii,6)+hstep*k3(:,6)/2);
    y(ii+1,:)=y(ii,:)+hstep*(k1+2*k2+2*k3+k4)/6;
end
% Just to get a plot: plot(h, y, 'linewidth', 1.5)
figure
plot(t, y(:,1), 'r', t, y(:,2), 'b--', t, y(:,3),'k:', t, y(:,4),...
    'c-.',t, y(:,5),'m',t, y(:,6), 'g-.', 'linewidth', 1.5 )
axis tight, legend ('u1', 'u2','u3','u4','u5','u6') 
title('The AKZO-NOBEL problem Simulation with R-K 4th order method')
xlabel('Simulation time cycle, t'),
ylabel('u_1(t), u_2(t), ...u_6(t)')
figure
subplot(211)
plot(t, y(:,1), 'r', t, y(:,3),'k:', t, y(:,6), 'g-.', 'linewidth', 1.5 )
axis tight, legend ('u1', 'u3','u6') 
title('The AKZO-NOBEL problem Simulation with R-K 4th order method')
xlabel('Simulation time cycle, t'),
ylabel('u_1(t), u_3(t), u_6(t)')

subplot '212'
plot(t, y(:,2), 'r--', t, y(:,4), 'b', t, y(:,5), 'm:','linewidth', 1.5 )
axis tight, legend ('u2','u4','u5','best') 
xlabel('Simulation time cycle, t'),
ylabel('u_2(t), u_4(t), u_5(t)')

function F=F_anobel(y1,y2,y3,y4,y5,y6)

k1=18.7; k2=.58; k3=.09; k4=.42; K=34.4; klA=3.3; 
Ks=115.83; pCO2=.9; H=737;
        
F=[-2*k1*y1^4*y2^.5+k2*y3*y4-(k2/K*y1*y5)-(k3*y1*y4^2),...
-0.5*(k1*y1^4*y2^.5)-(k3*y1*y4^2)-.5*(k4*y6^2*y2^.5)+(klA*(pCO2/H-y2)),...
(k1*y1^4*y2^.5)-k2*y3*y4+(k2/K*y1*y5),...
-k2*y3*y4+(k2/K*y1*y5)-2*(k3*y1*y4^2),...
k2*y3*y4-(k2/K*y1*y5)+(k4*y6^2*y2^.5), Ks*y1*y4-y6];

return