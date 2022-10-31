n=1000000;

lambda=0.7;

for i=1:n
    u=rand();
    x(i)=-1/lambda*log(1-u);
end

histogram(x)