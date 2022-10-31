%godunov scheme, 3 cells 1 2 3 (k1 k2 k3)

%density range 0-0.2

% generation of initial state distribution

kmean0=[0.1;0.05;0.07]
Cov0=[1E-4,0,0;0,4E-4,0;0,0,1E-4];

%rejection sampling
n=1001;
i=1;

while i<n
    k1=rand()*0.2;
    k2=rand()*0.2;
    k3=rand()*0.2;
    z=rand();
    k=[k1;k2;k3];
    if z<exp(-1/2*(k-kmean0)'*Cov0^(-1)*(k-kmean0))
        k1g(i)=k1;
        k2g(i)=k2;
        k3g(i)=k3
        i=i+1
    end
end
%scatter3(k1g, k2g, k3g)

numberofcells=3;
numberoftimesteps=5;

timehorizon=10; %seconds of computation
celllength=200;  %length of a cell in meters

deltat=timehorizon/numberoftimesteps;
numberoftimesteps=timehorizon/deltat;
deltax=celllength;


for i=1:n-1
density=zeros(numberofcells,numberoftimesteps);

%define initial condition
initialconditions=[k1g(i),k2g(i),k3g(i)]

demands=0*ones(1,numberoftimesteps); %for demand of upstream boundary condition
supplies=0*ones(1,numberoftimesteps);  %for supply of downstream boundary condition

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
           %elseif xposition==22
            %      density(xposition,time)=density(xposition,time-1)...
             %       +deltat/deltax*(min(D(density(xposition-1,time-1)),S1(density(xposition,time-1)))...
              %      -min(D1(density(xposition,time-1)),S1(density(xposition+1,time-1)))); 
           
           %elseif xposition>22
            %      density(xposition,time)=density(xposition,time-1)...
             %       +deltat/deltax*(min(D1(density(xposition-1,time-1)),S1(density(xposition,time-1)))...
              %      -min(D1(density(xposition,time-1)),S1(density(xposition+1,time-1)))); 

           else     %inside
                density(xposition,time)=density(xposition,time-1)...
                    +deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1)))...
                    -min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           end

    end
end
finaldensityk1(i)=density(1,numberoftimesteps)
finaldensityk2(i)=density(2,numberoftimesteps)
finaldensityk3(i)=density(3,numberoftimesteps)
end

meanvectorfinaltime=[0;0;0]
statecovariancefinaltime=zeros(3)

for i=i:n-1
    meanvectorfinaltime=meanvectorfinaltime+[finaldensityk1(i);finaldensityk2(i);finaldensityk3(i)];

end
meanvectorfinaltime=meanvectorfinaltime/(n-1);
for i=1:n-1
    k=[finaldensityk1(i);finaldensityk2(i);finaldensityk3(i)]
    statecovariancefinaltime=statecovariancefinaltime+(k-meanvectorfinaltime)*(k-meanvectorfinaltime)