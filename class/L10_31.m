
Sigma=[0.2, 0.6;0.6, 2];
eig(Sigma);

mu=[0;0];

n=10000;
i=1
while i<n
    x1=10*(rand()-0.5)
    x2=10*(rand()-0.5)
    z=rand();
    x=[x1;x2];
    if z<exp(-1/2*(x-mu)'*Sigma^(-1)*(x-mu))
        x1g(i)=x1;
        x2g(i)=x2;
        i=i+1
    end
end

scatter(x1g,x2g);