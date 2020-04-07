function Dxdt=A2_Stiff(t, X)
%%% Note: Given Equation is 2nd Order ODE.
%      ddy(t)+100*dy+10.9*y(t)=0
%      The Function File Is Saved Under The Name: A2_Stiff.M
Dxdt=[X(2);
    -100*X(2)-10.9*X(1)];
end
