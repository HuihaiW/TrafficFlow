
Sigma=[1,1.2;1.2,2]; %has to be positive semidefinite
mu=[0;0]; % mean vector


n=10000;
i=1;

while i<n
    x1=10*(rand()-0.5);
    x2=10*(rand()-0.5);
    z=rand();
    x=[x1;x2];
    if z<exp(-1/2*(x-mu)'*Sigma^(-1)*(x-mu))
        x1g(i)=x1;
        x2g(i)=x2;% sample accepted
        i=i+1;
    end
end

scatter(x1g,x2g)

axis([-5 5 -5 5])



