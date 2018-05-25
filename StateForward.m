function [Step] = StateForward(d1,theta,T)
L=.6;%original 0.6%0.8 va de cine!
V=0.15;%0.15 va de cine
gamma=V*(2/L^2)*(d1*0.001)*cosd(theta)-sqrt(L^2-(d1*0.001)^2)*sind(theta);
Step=((1/0.05)*T*[0;V;gamma])*(27/0.1);
end

