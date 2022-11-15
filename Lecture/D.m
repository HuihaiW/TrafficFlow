function q = D(k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


v=30 %free flow speed (meter per second)
w=6  %congestion wave speed (meter per second)
km=1/5 % maximum density (vehicle per meter)
kc=w*km/(v+w);  %critical density (vehicle per meter)

if k<=kc
    q=v*k;
else
    q=v*kc;
end

end