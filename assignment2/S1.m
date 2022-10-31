function q= S1(k)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

v=35 %free flow speed (meter per second)
w=6  %congestion wave speed (meter per second)
lane=2
km=1/5*lane % maximum density (vehicle per meter)
kc=w*km/(v+w);  %critical density (vehicle per meter)

if k<=kc
    q=v*kc;
else
    q=-w*(k-km);
end

end