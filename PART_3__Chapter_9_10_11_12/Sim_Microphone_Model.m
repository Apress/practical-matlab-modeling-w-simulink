clc; close all; clearvars
out=sim('Microphone_Model');
figure('name', 'Microphone')
yyaxis left
plot(out.yout{1}.Values, 'b--')
ylabel('\it Displacement, [mm]')
yyaxis right
plot(out.yout{2}.Values, 'k-')
xlabel('\it Time, [s]')
ylabel('\it i(t), [mA]')
legend('Displacement', 'Current', 'location', 'southeast')
title('Microphone simulation')
%%
figure('name', 'microphone simulations')
subplot(211)
plot(out.yout{1}.Values)
title('Membrane displacement')
xlabel('\it Time, [s]')
ylabel('\it Dispalcement')
subplot(212)
plot(out.yout{2}.Values)
title('Current')
xlabel('\it Time, [s]')
ylabel('\it i(t)')