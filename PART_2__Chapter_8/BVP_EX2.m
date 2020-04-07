function BVP_EX2	
% BVP_EX2.m solves the given BVP: t^2*y"-5t*y'+8y=0, y(1)=0,     %y(2)=24
t = linspace(1, 2, 30);
% A guess structure is created that consists of time mesh
% in the range of BCs and a guess function (Gsol1):
SOLin1 = bvpinit(t,@Gsol1);
% Another initial guess (with a function) Gsol2
SOLin2 = bvpinit(t,@Gsol2);
% Another initial guess (with numerical values) y1=0 and y2=24
SOLin3 = bvpinit(t,[0,24]);
% Numerical solutions of the problem are obtained with:
SOL1 = bvp4c(@dy,@Res,SOLin1);
SOL2 = bvp4c(@dy,@Res,SOLin2);
SOL3 = bvp4c(@dy,@Res,SOLin3);
y1 = deval(SOL1,t);
y2 = deval(SOL2,t);
y3 = deval(SOL3,t);
figure
plot(t, y1(1,1:end), 'ro-', t, y2(1, :), 'bx-',...
    t, y3(1,:),'kd:','linewidth', 1.5), grid on
legend('\it Guess #1: Polynom', '\it Guess #2: cos&sin fcns ',...
'\it Guess #3: numerical values', 'location', 'SouthEast')
title('\it Solution of BVP:  $\frac{d^2y}{dt^2}*t^2-5t*\frac{dy}{dt}+8y=0$', 'Interpreter', 'latex')
xlabel '\it t', 
ylabel '\it y(t) solution values'
function Ft1=Gsol1(t,~)
% 1st guess solution function:
Ft1=([8*t.^2-8*t, 16*t-8]);
end
function Ft2=Gsol2(t,~)
% 2nd guess solution function:
        Ft2=([cos(t), -sin(t)]);
end
function f=dy(t,y)
% Given problem formulation:
        f=[y(2), (5*t.*y(2)-8*y(1))./t.^2];
end
function F=Res(yl,yr)
% Now, we define residues of BCs as a nested function.
        F=[yl(1), yr(1)-24];
end
end
