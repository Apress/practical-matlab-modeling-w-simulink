clearvars; close all
% Input Data for Scenarios I - IV.
M1=1; D1=0; S1=25;   % Scenario I. No damping
M2=1; D2=2; S2=25;   % Scenario II. Underdamped
M3=1; D3=13; S3=25;  % Scenario III. Over-damped
M4=1; D4=10; S4=25;  % Scenario IV. Critically damped
ICs=[0.1, 0]; t=0:.05:5; 
% Displacement: 
ut1=SMDsysSim(M1, D1, S1, ICs, t); 
ut2=SMDsysSim(M2, D2, S2, ICs, t);
ut3=SMDsysSim(M3, D3, S3, ICs, t); 
ut4=SMDsysSim(M4, D4, S4, ICs, t);
% Velocity:
dut1=diff(ut1); 
dut2=diff(ut2); 
dut3=diff(ut3); 
dut4=diff(ut4);
figure(1) 
plot(t, ut1, 'b-',  'linewidth', 1.5), hold on
plot(t, ut2, 'r-.', 'linewidth', 1.5)
plot(t, ut3, 'k:',  'linewidth', 2)
plot(t, ut4, 'g--', 'linewidth', 1.5)
xlabel('time, [s]'); ylabel('System response, [m]'), grid on, 
title('1-DOF Spring-Mass-Damper System simulation - 4 Scenarios'), 
legend('No damping: \zeta=0',' Underdamped: 0<\zeta<1',...
 'Overdamped: \zeta>1','Critically damped: \zeta=1'), hold off
figure(2) 
plot(ut1(2:end), dut1, 'b-',  'linewidth', 1.5), 
hold on
plot(ut2(2:end), dut2, 'r-.','linewidth', 1.5)
plot(ut3(2:end), dut3, 'k:', 'linewidth', 2) 
plot(ut4(2:end), dut4, 'g--',  'linewidth', 1.5)
xlabel('time, [s]'); 
ylabel('System response, [m]')
grid on, title('Phase plot: Displacement vs. velocity')
legend('No damping: \zeta=0',' Underdamped: 0<\zeta<1',...
    'Overdamped: \zeta>1','Critically damped: \zeta=1')
xlim([-.1 .1]), ylim([-.025 .025]), axis square
hold off; shg

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
