
% godunov scheme, 3 cells 1 2 3 (k1 k2 k3)

% density range 0-0.2

% generation of initial state distribution

kmean0=[0.07; 0.07; 0.07; 0.07; 0.4; 0.1; 0.1; 0.1; 0.1; 0.1]; %mean value of inital state
Cov0=4E-4*eye(10);

% rejection sampling

n=1001; % number of samples
i=1;
sigma=4E-4;
% while i<n
%     mu=0.07;
%     k1=normrnd(mu,sigma) ;
%     k2=normrnd(mu,sigma) ;
%     k3=normrnd(mu,sigma) ;
%     k4=normrnd(mu,sigma) ;
%     mu=0.4;
%     k5=normrnd(mu,sigma) ;
%     mu=0.1;
%     k6=normrnd(mu,sigma) ;
%     k7=normrnd(mu,sigma) ;
%     k8=normrnd(mu,sigma) ;
%     k9=normrnd(mu,sigma) ;
%     k10=normrnd(mu,sigma) ;
% 
%     k1g(i)=k1;
%     k2g(i)=k2;
%     k3g(i)=k3;
%     k4g(i)=k4;
%     k5g(i)=k5;
%     k6g(i)=k6;
%     k7g(i)=k7;
%     k8g(i)=k8;
%     k9g(i)=k9;
%     k10g(i)=k10;
%     i=i+1;
% end
%kall=[k1g;k2g;k3g;k4g;k5g;k6g;k7g;k8g;k9g;k10g];
%imagesc(kall)

%colormap(flipud(bone))
%colorbar

numberofcells=10;
numberoftimesteps=8;

timehorizon=50; %seconds of computation
celllength=100;  %length of a cell in meters

deltat=2.5;
deltax=celllength;


for i=1:n-1


density=zeros(numberofcells,numberoftimesteps);
    
initialconditions=[k1g(i),k2g(i),k3g(i),k4g(i),k5g(i),k6g(i),k7g(i),k8g(i),k9g(i),k10g(i)];
demands=1.2*ones(1,numberoftimesteps); %upper stream
supplies=0.6*ones(1,numberoftimesteps);  %down stream


density(:,1)=initialconditions;

for time=2:numberoftimesteps
    for xposition=1:numberofcells
           if xposition==1  % upstreamboundary
                density(xposition,time)=density(xposition,time-1)...
                +deltat/deltax*(min(demands(time-1),S(density(xposition,time-1))) ...
                -min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           elseif xposition==numberofcells   %downstreamboundary

                density(xposition,time)=density(xposition,time-1)...
                +deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1))) ...
                -min(D(density(xposition,time-1)),supplies(time-1))); 

           else     %inside

                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(D(density(xposition-1,time-1)), ...
                    S(density(xposition,time-1)))-min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           end

    end
end


finaldensityk1(i)=density(1,numberoftimesteps);
finaldensityk2(i)=density(2,numberoftimesteps);
finaldensityk3(i)=density(3,numberoftimesteps);
finaldensityk4(i)=density(4,numberoftimesteps);
finaldensityk5(i)=density(5,numberoftimesteps);
finaldensityk6(i)=density(6,numberoftimesteps);
finaldensityk7(i)=density(7,numberoftimesteps);
finaldensityk8(i)=density(8,numberoftimesteps);
finaldensityk9(i)=density(9,numberoftimesteps);
finaldensityk10(i)=density(10,numberoftimesteps);

end


meanvectorfinaltime=[0;0;0;0;0;0;0;0;0;0];
statecovariancefinaltime=zeros(10);

for i=1:n-1
    meanvectorfinaltime=meanvectorfinaltime+[finaldensityk1(i);finaldensityk2(i);finaldensityk3(i);finaldensityk4(i)...
        ;finaldensityk5(i);finaldensityk6(i);finaldensityk7(i);finaldensityk8(i);finaldensityk9(i);finaldensityk10(i)];
end


meanvectorfinaltime=meanvectorfinaltime/(n-1);


for i=1:n-1
    k=[finaldensityk1(i);finaldensityk2(i);finaldensityk3(i);finaldensityk4(i)...
        ;finaldensityk5(i);finaldensityk6(i);finaldensityk7(i);finaldensityk8(i);finaldensityk9(i);finaldensityk10(i)];
    statecovariancefinaltime=statecovariancefinaltime+(k-meanvectorfinaltime)*(k-meanvectorfinaltime)';
end

statecovariancefinaltime=statecovariancefinaltime/(n-1);









%*******mean vector and covariance of initial condition*******************
meanvectorinitialtime=[0;0;0;0;0;0;0;0;0;0];
statecovarianceinitialtime=zeros(10);

for i=1:n-1
    meanvectorinitialtime=meanvectorinitialtime+[k1g(i);k2g(i);k3g(i);k4g(i)...
        ;k5g(i);k6g(i);k7g(i);k8g(i);k9g(i);k10g(i)];
end


meanvectorinitialtime=meanvectorinitialtime/(n-1);


for i=1:n-1
    k=[k1g(i);k2g(i);k3g(i);k4g(i)...
        ;k5g(i);k6g(i);k7g(i);k8g(i);k9g(i);k10g(i)];
    statecovarianceinitialtime=statecovarianceinitialtime+(k-meanvectorinitialtime)*(k-meanvectorinitialtime)';
end

statecovarianceinitialtime=statecovarianceinitialtime/(n-1);


