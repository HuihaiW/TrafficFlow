function q= S(k)

v=35 %free flow speed (meter per second)
w=6  %congestion wave speed (meter per second)
lane=3
km=1/5*lane % maximum density (vehicle per meter)
kc=w*km/(v+w);  %critical density (vehicle per meter)

if k<=kc
    q=v*kc;
else
    q=-w*(k-km);
end

end