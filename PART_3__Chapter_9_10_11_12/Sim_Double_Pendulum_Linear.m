clc; close all; clearvars
out=sim('Double_Pendulum_Linear');
figure('name', 'Double Pendulum Sim');
subplot(211)
plot(out.yout{1}.Values, 'b-', 'linewidth', 1.5), hold on
plot(out.yout{3}.Values, 'r-.', 'linewidth', 1.5)
title('Angular displacement')
xlabel('Time, [s]')
ylabel('\theta_1, \theta_2')
legend('\theta_1', '\theta_2')
grid on
subplot(212)
plot(out.yout{2}.Values, 'b-', 'linewidth', 1.5), hold on
plot(out.yout{4}.Values, 'r-.', 'linewidth', 1.5)
title('Angular velocity')
xlabel('Time, [s]')
ylabel('d\theta_1, d\theta_2')
legend('d\theta_1', 'd\theta_2')
grid on; shg

figure('name', 'Phase plot')
plot(out.yout{1}.Values.Data, out.yout{2}.Values.Data, 'b-',...
    out.yout{3}.Values.Data,out.yout{4}.Values.Data, 'r-.','linewidth', 1.5)
legend('\theta_1 vs. d\theta_1', '\theta_2 vs. d\theta_2', 'location', 'southeast')
title('Phase plot')
xlabel('\theta_1, \theta_2')
ylabel('d\theta_1, d\theta_2')
axis square