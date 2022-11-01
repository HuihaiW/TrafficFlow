clear;
v=35 %free flow speed (meter per second)
w=6  %congestion wave speed (meter per second)
lane=2
km=1/5*lane % maximum density (vehicle per meter)
kc=w*km/(v+w);  %critical density (vehicle per meter)

k_list=[0:0.01:km]
%len=length(k_list)
for i=1:length(k_list)
    if k_list(i)<=kc
        p(i)=v*k_list(i);
    else
        p(i)=-1*w*(k_list(i)-km);
    end
end

plot(k_list,p)
