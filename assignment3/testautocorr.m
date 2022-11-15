x=rand(100000,1);

window=10000;

for T=0:1000 
    asum=0;
    for i=1:window
        asum=asum+(x(i)-0.5)*(x(i+T)-0.5);
    end
    autoc(T+1)=asum/window
end


