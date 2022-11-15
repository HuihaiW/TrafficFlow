
% godunov scheme, 3 cells 1 2 3 (k1 k2 k3)

% density range 0-0.2

% generation of initial state distribution

kmean0=[0.1; 0.1; 0.02; 0.2; 0.1]; %mean value of inital state
Cov0=4E-4*eye(5);

% rejection sampling

n=1000; % number of samples
i=1;

while i<n
    k1=rand()*0.2;
    k2=rand()*0.2;
    k3=rand()*0.2;
    k4=rand()*0.2;
    k5=rand()*0.2;
    z=rand();
    k=[k1;k2;k3;k4;k5];
    if z<exp(-1/2*(k-kmean0)'*Cov0^(-1)*(k-kmean0))
        fprintf('i \n')
        k1g(i)=k1;
        k2g(i)=k2;% sample accepted
        k3g(i)=k3;
        k4g(i)=k4;
        k5g(i)=k5;

        i=i+1;
    end
end
kall=[k1g;k2g;k3g;k4g;k5g];
imagesc(kall)

colormap(flipud(bone))
colorbar

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

end


meanvectorfinaltime=[0;0;0];
statecovariancefinaltime=zeros(3);

for i=1:n-1
    meanvectorfinaltime=meanvectorfinaltime+[finaldensityk1(i);finaldensityk2(i);finaldensityk3(i)];
end


meanvectorfinaltime=meanvectorfinaltime/(n-1);


for i=1:n-1
    k=[finaldensityk1(i);finaldensityk2(i);finaldensityk3(i)];
    statecovariancefinaltime=statecovariancefinaltime+(k-meanvectorfinaltime)*(k-meanvectorfinaltime)';
end

statecovariancefinaltime=statecovariancefinaltime/(n-1);

imagesc(statecovariancefinaltime)

colormap(flipud(bone))
colorbar
