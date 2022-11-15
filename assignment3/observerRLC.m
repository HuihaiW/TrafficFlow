R=0.3;
L=0.1;
C=0.01;


A=[0,1/C;-1/L,-R/L];
Cmat=[0,R];


Vc0=10;  %initial voltage for the capacitor
i0=0;    %initial current


x0=[Vc0;i0];

n=1000;
deltat=0.001;

noiselev=1   %noise level (in volt) of the voltage sensor (at the resistor)

for k=1:n
    t=k*deltat;
    x=expm(A*t)*x0;
    Vc(k)=x(1);
    i(k)=x(2);
    y(k)=R*i(k)+noiselev*(rand()-0.5); % output of the system
end



%observer design

L1=(L*(1/(C*L) - 100))/R;
L2=-(R/L - 20)/R;

Vchat0=2; %initial guess of Vc
ihat0=-1;  %initial guess of i

xhat0=[Vchat0;ihat0];

L=[L1;L2]; %observer gain matrix

for k=1:n
    integral=0;
    t=k*deltat;
    for j=1:k
        tau=j*deltat;
        integral=integral+expm((A-L*Cmat)*(t-tau))*L*y(j)*deltat;  %to compute int_0^tau expm((A-LC)*(t-tau)*L*y(tau)dtau
    end
    xhat=expm((A-L*Cmat)*t)*xhat0+integral;
    Vchat(k)=xhat(1);
    ihat(k)=xhat(2);
end


plot(Vc)

hold on

plot(Vchat)

figure

plot(i)

hold on
plot(ihat)







