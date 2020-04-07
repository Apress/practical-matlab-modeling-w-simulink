function zeta_1DOF_SMD(M, zeta, S, omega)
% HELP. Study damping ratio (zeta) effects on Amplitude change
% M - Mass of the system
% zeta - Damping ratio 
% S - Stiffness of the system
% omega - frequency
if nargin<1
M=2.5; S=25; 
omega=0:.2:10; 
zeta=0:0.2:1;
end 
omegaN=sqrt(S/M); 
r=omega./omegaN;
Mag=zeros(length(zeta), length(r)); 
Theta=ones(length(zeta), length(r));
for ii=1:length(zeta)
    for k=1:length(r)
        Mag(ii,k)=1/sqrt((1-r(k)^2)^2+(2*zeta(ii)*r(k))^2);
        Theta(ii,k)=atan2(2*zeta(ii)*r(k), (1-r(k)^2));
    end
end
Labelit = {};
Colorit = 'bgrmkgbckmbgrygr';
Lineit  = '--:-:--:-:--:----:----:--';
Markit  = 'oxs+*^v<p>.xsh+od+*^v';
for m=1:length(zeta)
    Stylo    = [Colorit(m) Lineit(m) Markit(m)];
    Labelit{m} = ['\zeta= ' num2str(zeta(m))];
    semilogy(r, Mag(m,:), Stylo, 'linewidth', 1.5), hold on
end
legend(Labelit{:}); axis tight; grid on; ylim([0, 5])
title('\zeta influence on Response Amplitude change')
xlabel('r = \omega/\omega_n'), ylabel('\it Normalized Amplitude'), 
hold off
figure
for m=1:length(zeta)
    Stylo    = [Colorit(m) Lineit(m) Markit(m)];
    Labelit{m} = ['\zeta= ' num2str(zeta(m))];
    plot(r, Theta(m,:), Stylo, 'linewidth', 1.5)
    hold on
end
legend(Labelit{:}, 'location', 'northwest') 
axis tight, grid on; 
axis([0, 2 -.2 3.35])
title('\zeta  effects on Phase changes')
xlabel('r = \omega/\omega_n ') 
ylabel('Phase, \theta(r)')
