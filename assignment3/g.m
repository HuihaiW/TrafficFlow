function dzdt= g(t,z)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

dzdt=[z(2);1/(2800000-12890*t)*(34020000-1/2*(1.2*(1-z(1)/20000)*z(2)^2*pi*5^2*0.3) )-9.8]


end