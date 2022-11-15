function dTdt=f(t,T)

%t is time and T is temperature

dTdt=1/2E-3*((110*sqrt(2)*cos(2*pi*60*t))^2/((120-8)/3300*T+8)-2E-12*(T+273)^4); 


end