function HIRES_RK
%HELP: HIRES_RK.m solves HIRES problem with Runge-Kutta method scripts
U=[1 0 0 0 0 0 0 .0057]; % ICs
tstart=0;
hstep=0.01;
tend=321.8122; 
% Need to integrate over [0, 321.8122], 
% but for better visualization, we can limit with 5.8122 
t=tstart:hstep:tend;
for ii=1:length(t)-1
    k1=FF(U(ii,1), U(ii,2),U(ii,3), U(ii,4), U(ii,5), U(ii,6),...
        U(ii,7), U(ii,8));
    k2=FF(U(ii,1)+hstep*k1(:,1)/2,U(ii,2)+hstep*k1(:,2)/2,...
        U(ii,3)+hstep*k1(:,3)/2,U(ii,4)+hstep*k1(:,4)/2,...
        U(ii,5)+hstep*k1(:,5)/2,U(ii,6)+hstep*k1(:,6)/2, ...
        U(ii,7)+hstep*k1(:,7)/2,U(ii,8)+hstep*k1(:,8)/2);
    k3=FF(U(ii,1)+hstep*k2(:,1)/2,U(ii,2)+hstep*k2(:,2)/2, ...
        U(ii,3)+hstep*k2(:,3)/2,U(ii,4)+hstep*k2(:,4)/2,...
        U(ii,5)+hstep*k2(:,5)/2,U(ii,6)+hstep*k2(:,6)/2, ...
        U(ii,7)+hstep*k2(:,7)/2,U(ii,8)+hstep*k2(:,8)/2);
    k4=FF(U(ii,1)+hstep*k3(:,1),U(ii,2)+hstep*k3(:,2), ...
        U(ii,3)+hstep*k3(:,3)/2,U(ii,4)+hstep*k3(:,4)/2,...
        U(ii,5)+hstep*k3(:,5)/2,U(ii,6)+hstep*k3(:,6)/2, ...
        U(ii,7)+hstep*k3(:,7)/2,U(ii,8)+hstep*k3(:,8)/2);
    U(ii+1,:)=U(ii,:)+hstep*(k1+2*k2+2*k3+k4)/6;
end
figure
plot(t, U(:,:), 'linewidth', 1.5)
title('The HIRES problem solved with Runge-Kutta method')
legend ('u_1','u_2','u_3','u_4','u_5','u_6','u_7','u_8', 'best')
axis([0 321 0, 0.8])
figure
subplot(311)
plot(t, U(:,1),'r:',t, U(:,4),'b-.',t,U(:,6),'m', ...
     'linewidth', 1.5 ), ylabel('u_i(t)'), 
title('The HIRES problem solved with Runge-Kutta method')
legend ('u_1','u_4','u_6') 
axis([0, 25 0 0.8])
subplot(312)
plot( t, U(:,7), 'b',t, U(:,8),'k-.','linewidth', 1.5)
legend ('u_7','u_8'), ylabel('u_i(t)')
xlim([0, 5]),
subplot(313)
plot(t, U(:,2),'b--',t, U(:,3),'k:',t, U(:,5),'m-',...
     'linewidth', 1.5 ), 
 xlabel('t'), ylabel('u_i(t)'), 
legend ('u_2','u_3','u_5') 
xlim([0, 15])

% NOTE: R-K script performs much better and more stable than
% EULER-forward method

function F=FF(u1, u2, u3, u4, u5, u6, u7, u8)

F=[-1.7*u1+.43*u2+8.32*u3+.0007,1.71*u1-8.75*u2,...
    -10.03*u3+.43*u4+.035*u5, 8.32*u2+1.71*u3-1.12*u4,...
    -1.75*u5+.43*u6+.43*u7, ...
    -280*u6*u8+.69*u4+1.71*u5-.43*u6+.69*u7,...
    280*u6*u8-1.81*u7, -280*u6*u8+1.81*u7];
return