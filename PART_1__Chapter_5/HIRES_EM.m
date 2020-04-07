function u=HIRES_EM

% HELP: HIRES_EM.m solves The HIRES problem with EULER-Forward method.
% "High Irradiance RESponse" problem originated from plant physiology is
% taken from the test set of ODE problems compiled by W. Lioen and H. de Swart.
% "Test for initial value problem solvers", CWI Report MAS-R9832, ISSN
% 1386-3703, Amsterdam, (1998).

% Given: du1=-1.7*u1+.43*u2+8.32*u3+.0007,
%        du2= 1.71*u1-8.75*u2,
%        du3= -10.03*u3+.43*u4+.035*u5,
%        du4= 8.32*u2+1.71*u3-1.12*u4,
%        du5= -1.75*u5+.43*u6+.43*u7,
%        du6= -280*u6*u8+.69*u4+1.71*u5-.43*u6+.69*u7,
%        du7= 280*u6*u8-1.81*u7,
%        du8= -280*u6*u8+1.81*u7.
% ICs:   u0=(1, 0, 0, 0, 0, 0, 0, .0057)
 
u=[1 0 0 0 0 0 0 .0057]; % ICs
tstart=0;
hstep=.01;
tend=321.8122; 
% Need to integrate over [0, 321.8122], but for better visualization,
% we can limit with 5.8122 
t=tstart:hstep:tend;
g=zeros(numel(t),8);

for ii=1:length(t)-1
    g(ii,:)=Gee(u(ii,1), u(ii,2), u(ii,3), u(ii,4), u(ii,5), u(ii,6), u(ii,7), u(ii,8));
    u(ii+1, :)=u(ii,:)+g(ii,:)*hstep;
end
figure
plot(t, u(:,1), 'r',t, u(:,2), 'b--', t, u(:,3),'g:', t, u(:,4),'c-.', t, u(:,5),'m',...
    t, u(:,6), 'g-.', t, u(:,7), 'b:', t, u(:,8), 'k', 'linewidth', 1.5 ), axis tight
legend ('u_1', 'u_2','u_3','u_4','u_5','u_6','u_7','u_8') 
xlim([0, 25]), title('The HIRES problem solved with EULER forward')
xlabel('time'), ylabel('u_i(t)')
figure, plot(u, 'linewidth', 1.5), axis tight
title('The HIRES problem solved with EULER forward')
legend ('u_1', 'u_2','u_3','u_4','u_5','u_6','u_7','u_8') 
xlabel('time'), ylabel('u_i(t)')
%%%%%% NOTE: Interesting phenomena are observed within [10, 18] of time
%%%%%% interval. There are some instabilities with u6, u7, u8.

function F=Gee(u1,u2,u3,u4,u5,u6,u7,u8)

F=[-1.7*u1+.43*u2+8.32*u3+.0007; 1.71*u1-8.75*u2;
    -10.03*u3+.43*u4+.035*u5; 8.32*u2+1.71*u3-1.12*u4;
    -1.75*u5+.43*u6+.43*u7; -280*u6*u8+.69*u4+1.71*u5-.43*u6+.69*u7;
    280*u6*u8-1.81*u7; -280*u6*u8+1.81*u7];
return