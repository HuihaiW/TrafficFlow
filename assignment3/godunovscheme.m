numberofcells=12;
numberoftimesteps=20;

timehorizon=100; %seconds of computation
celllength=200;  %length of a cell in meters

deltat=timehorizon/numberoftimesteps;
deltax=celllength;

density=zeros(numberofcells,numberoftimesteps);

initialconditions=[0.1,0.1,0.1,0.01,0.01,0.01,0.01,0.01,0.15,0.15,0.15,0.15];  %initial values of densities
demands=0.9*ones(1,numberoftimesteps); %for qmax=1 vehicle per second
supplies=0*ones(1,numberoftimesteps);  %for qmax=1 vehicle per second


density(:,1)=initialconditions;

for time=2:numberoftimesteps
    for xposition=1:numberofcells
           if xposition==1  % upstreamboundary
                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(demands(time-1),S(density(xposition,time-1)))-min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           elseif xposition==12   %downstreamboundary

                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1)))-min(D(density(xposition,time-1)),supplies(time-1))); 

           else     %inside

                density(xposition,time)=density(xposition,time-1)+deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1)))-min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           end

    end
end

imagesc(density)

colormap(flipud(bone))
colorbar
