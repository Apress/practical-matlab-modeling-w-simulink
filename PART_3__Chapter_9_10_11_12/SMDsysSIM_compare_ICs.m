%%  Study influence of Initial Conditions 
clearvars; close all
% Input Data: 
M=1; D=5; S=25; t=0:.05:2.5;
% Initial Conditions for three different cases: 
ICs1=[0.1, 0]; 
ICs2=[0.1, 1]; 
ICs3=[0.1, -1];  
% Displacement: 
ut1=SMDsysSim(M, D, S, ICs1, t);
ut2=SMDsysSim(M, D, S, ICs2, t);
ut3=SMDsysSim(M, D, S, ICs3, t);
figure, subplot(311)
plot(t, ut1, 'b-', 'linewidth', 1.5), hold on
plot(t, ut2, 'r--', 'linewidth', 2),
plot(t, ut3, 'k:', 'linewidth', 2), grid on
legend('u_0=0.1, du_0=0','u_0=0.1, du_0=1','u_0= 0.1, du_0= -1')
ylabel(' u(t), [m]')
gtext({' \zeta < 1'}, 'fontsize', 13), hold off ,axis tight
% Input Data for Scenarios III. Critically damped
M2=1; D2=10; S2=25; t=0:.05:2.5;
ICs1=[0.1, 0]; ICs2=[0.1, 1]; ICs3=[0.1,-1]; 
% Displacement: 
ut1=SMDsysSim(M2, D2, S2, ICs1, t);
ut2=SMDsysSim(M2, D2, S2, ICs2, t);
ut3=SMDsysSim(M2, D2, S2, ICs3, t);
subplot(312)
plot(t, ut1, 'b-', 'linewidth', 1.5), hold on
plot(t, ut2, 'r--', 'linewidth', 2),
plot(t, ut3, 'k:', 'linewidth', 2), grid on
legend('u_0=0.1, du_0=0','u_0=0.1, du_0=1','u_0=0.1, du_0= -1')
ylabel(' u(t), [m]')
gtext({' \zeta = 1'}, 'fontsize', 13), axis tight; hold off 
% Input Data for Scenario IV. Over-damped case
M3=1; D3=13; S3=25; t=0:.05:2.5;
ICs1=[0.1, 0]; ICs2=[0, 0.5]; ICs3=[-0.1, 0]; 
% Displacement: 
ut1=SMDsysSim(M3, D3, S3, ICs1, t);
ut2=SMDsysSim(M3, D3, S3, ICs2, t);
ut3=SMDsysSim(M3, D3, S3, ICs3, t);
subplot(313), plot(t, ut1, 'b-', 'linewidth', 1.5), hold on
plot(t, ut2, 'r--', 'linewidth', 2),
plot(t, ut3, 'k:', 'linewidth', 2), grid on
legend('u_0=0.1, du_0=0','u_0=0, du_0=0.5','u_0= -0.1, du_0=0')
xlabel('t, [s]'); ylabel(' u(t), [m]')
gtext({'\zeta >1'}, 'fontsize', 13), hold off, axis tight
function Out=SMDsysSim(M, D, S, ICs, t)
% HELP. Simulation model of 1-DOF SMD system.
% Out=SMDsysSim(M, D, S, ICs, t)
    omegaN = sqrt(S/M);
    ksi = 0.5*(D/M)*(1/omegaN);
    u0=ICs(1); 
    du0=ICs(2);  
if ksi==0               % Scenario I. Undamped
    Out=u0*cos(omegaN*t)+(du0/omegaN)*sin(omegaN*t);
elseif ksi>0 && ksi<1   % Scenario II. Underdamped
 omegaD=omegaN*sqrt(1-ksi^2);
 Out=exp(-ksi*omegaN*t).*(u0*cos(omegaD*t)+(u0*ksi*omegaN+du0)...
*sin(omegaD*t)/omegaD);
elseif ksi>1            % Scenario III. Overdamped
r1=(-ksi-sqrt(ksi^2-1))*omegaN;
r2=(-ksi+sqrt(ksi^2-1))*omegaN;
A=(-du0+(-ksi+(sqrt(ksi^2-1)))*u0*omegaN)/(2*omegaN*sqrt(ksi^2-1));
B=(du0+(ksi+(sqrt(ksi^2-1)))*u0*omegaN)/(2*omegaN*sqrt(ksi^2-1));
Out=(A*exp(r1*t)+B*exp(r2*t));
else  %ksi==1          % Scenario IV. Critically damped
  r1=-omegaN; 
  A=u0; 
  B=du0+omegaN*u0; 
  Out=(A+B*t).*exp(r1*t);
end
end
