clc; clearvars; close all
% BVP_EX4.m
% Sturm_Liouville_bvp. Given: -u"+w^2*u=sinh(t)
% periodic boundary conditions: u(0)=u(1)=0
%  ----------------------------------------------------------
% Define residues of BCs via a function handle
Res=@(yl,yr)([yl(1) yr(1)]);
% 1st guess solution function defined with function handle:
Gsol=@(t)([sin(-0.540302305868140*t),cos(t)-0.540302305868140]);
close all; clc
omega=[0, 3, 5, 7, 13];
t = linspace(0, 1, 500);
% A guess structure consisting of time mesh within [0, 1]
% in the range of BCs and a guess function (Gsol):
SOLin1 = bvpinit(linspace(0,1, 10),Gsol);
% Another numeric value based initial guess y1=0 and y2=0
SOLin2 = bvpinit(linspace(0,1, 10),[0,0]);

% Plotting options:
Labelit = { };
Colorit1 = 'krgbm';
Colorit2 = 'krgbm';
Lineit1  = '---:--:---:';
Lineit2  = '---:--:---:';
for ii=1:numel(omega)
    Styleit1=[Colorit1(ii), Lineit1(ii)];
    Styleit2=[Colorit2(ii), Lineit2(ii)];
    % Given problem formulation:
    dy=@(t,y)([y(2), omega(ii)^2*y(1)-sinh(t)]);
    % Obtain the solutions of the problem for two initial guesses:
    SOL1 = bvp4c(dy,Res,SOLin1);
    SOL2 = bvp4c(dy,Res,SOLin2);
    % Compute numeric solutions of the problem within time-space:
    y1 = deval(SOL1,t);
    y2 = deval(SOL2,t);
    subplot(211)
    plot(t, y1(1,1:end), Styleit1, 'linewidth', 1.5), grid on; hold on
    Labelit{ii}=['\omega = ' num2str(omega(ii))];
    legend(Labelit{:})
    title('Sturm Liouville BVP: $\frac{-d^2u}{dt^2}+\omega^2*u=sinh(t)$', 'interpreter', 'latex')
    ylabel('\it y(t) solution values')  
    subplot(212)
    plot(t,y2(1, :), Styleit2, 'linewidth', 1.5), grid on; hold on
    Labelit{ii}=['\omega = ' num2str(omega(ii))];
    legend(Labelit{:})
    xlabel '\it t'
    ylabel('\it y(t) solution values')  
end
gtext('Guess 1: sin&cos fcns', 'background', 'y')
gtext('Guess 2: Numerical guess values', 'background', 'y')
hold off
