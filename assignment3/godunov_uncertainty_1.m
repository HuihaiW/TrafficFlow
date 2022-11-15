
% godunov scheme, 3 cells 1 2 3 (k1 k2 k3)

% density range 0-0.2

% generation of initial state distribution

kmean0=[0.1;0.05;0.07]; %mean value of inital state
Cov0=[1E-4,0,0;0,4E-4,0;0,0,1E-4];

% rejection sampling

n=3001; % number of samples
i=1

while i<n
    k1=rand()*0.2;
    k2=rand()*0.2;
    k3=rand()*0.2;
    z=rand();
    k=[k1;k2;k3];
    if z<exp(-1/2*(k-kmean0)'*Cov0^(-1)*(k-kmean0))
        fprintf('job done \n')
        k1g(i)=k1;
        k2g(i)=k2;% sample accepted
        k3g(i)=k3;
        i=i+1;
    end
end


numberofcells=3;
numberoftimesteps=5;

timehorizon=10; %seconds of computation
celllength=200;  %length of a cell in meters

deltat=timehorizon/numberoftimesteps;
deltax=celllength;


for i=1:n-1


density=zeros(numberofcells,numberoftimesteps);
    
initialconditions=[k1g(i),k2g(i),k3g(i)];
demands=0*ones(1,numberoftimesteps); %for qmax=1 vehicle per second
supplies=0*ones(1,numberoftimesteps);  %for qmax=1 vehicle per second


density(:,1)=initialconditions;

for time=2:numberoftimesteps
    for xposition=1:numberofcells
           if xposition==1  % upstreamboundary
                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(demands(time-1),S(density(xposition,time-1)))-min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           elseif xposition==numberofcells   %downstreamboundary

                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1)))-min(D(density(xposition,time-1)),supplies(time-1))); 

           else     %inside

                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1)))-min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
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

