function ChebyshevDemo
% HELP: ChebyshevDemo.m is a script to simulate
%      numerical solutions of Chebyshev Equation:
%      (1-t^2)*ddy-t*dy+n^2*y=0
%      for n=0,1,2,3,4,5,6, ...
%      t is defined to be |t|<1
%      Initial conditions: y(0)=0, dy(0)=1 
%      Colorit (color type): b-blue; g-green; r-red; m-magenta;
%      c-cyan; y-yellow; k-black.
%      Lineit (line type): - solid line; : colon; -- dashed line;
%      Markit (marker type): o-circle; d-diamond; x-cross;
%      s-square; h-hexagon; + plus sign; * asterisk; etc.
figure; 
y0=0; dy0=1; % Initial Conditions
t=[0, 0.999];   % Simulation time space
Labelit = {};
Colorit = 'bgrcymkgrckmbgrygr';
Lineit  = '--:-:--:-:--:----:----:--';
Markit  = 'odxsh+*^v<p>.xsh+od+*^v';
options = odeset('RelTol',1e-4,'AbsTol',1e-5,'Jacobian',@JC1);
for ii = 1:10
  [t, Y]   = ode15s(@D2Y, t,[y0, dy0], options, ii-1);
  Stylo    = [Colorit(ii) Lineit(ii) Markit(ii)];
  Labelit{ii} = ['n= ' num2str(ii-1)]; plot(t, Y(:,1),Stylo), hold on
end
xlabel('\it t'), ylabel('\it Solution, y(t)')
legend(Labelit{:}, 'location', 'northwest'), grid on
title('\it Chebyshev Equation Solutions for n=0,1...9'), hold off
function ddy=D2Y(t, y, n)
% Chebyshev differential equation
        ddy=[y(2); 
            (t.*y(2)-n.^2*y(1))./(1-t.^2)];
function J=JC1(t, y, n)
% Jacobian matrix is computed
            J=[0, 1;
                n^2/(t^2-1), -t/(t^2-1)];

