rho=0.5;
sigma=2;

[x1,x2]=meshgrid(-10:0.1:10,-10:0.1:10);

 surf(x1,x2,1/(2*pi*sigma^2*(1-rho^2))*exp(-(x1.^2+x2.^2-2*rho.*x1.*x2)/(2*sigma^2*(1-rho^2))))


maxv=0.06 %has to be largest than the max of the pdf


nsamples=5000; %number of samples that we want
n=1;

nrejected=0;

while n<nsamples

    x1=(rand()-0.5)*20;
    x2=(rand()-0.5)*20;
    u=rand()*maxv;
    if u<1/(2*pi*sigma^2*(1-rho^2))*exp(-(x1.^2+x2.^2-2*rho.*x1.*x2)/(2*sigma^2*(1-rho^2)))
        x1sample(n)=x1;
        x2sample(n)=x2;         %sample accepted
        n=n+1;
    else
        %sample rejected
        nrejected=nrejected+1;
    end
end


figure 

scatter(x1sample,x2sample)

