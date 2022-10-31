numberofcells=30;
lengthofhighway=3000;

timehorizon=200; %seconds of computation
celllength=lengthofhighway/numberofcells;  %length of a cell in meters

deltat=2.5;
numberoftimesteps=timehorizon/deltat;
deltax=celllength;

density=zeros(numberofcells,numberoftimesteps);

%define initial condition
density(1:8,1)=0.07;
density(9:19,1)=0.4;
density(20:30,1)=0;

demands=0*ones(1,numberoftimesteps); %for demand of upstream boundary condition
supplies=0*ones(1,numberoftimesteps);  %for supply of downstream boundary condition


for time=2:numberoftimesteps
    for xposition=1:numberofcells
           if xposition==1  % upstreamboundary
                density(xposition,time)=density(xposition,time-1)...
                    +deltat/deltax*(min(demands(time-1),S(density(xposition,time-1))) ...
                    -min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           elseif xposition==30   %downstreamboundary
                density(xposition,time)=density(xposition,time-1)...
                    +deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1))) ...
                    -min(D(density(xposition,time-1)),supplies(time-1))); 
           elseif xposition==22
                  density(xposition,time)=density(xposition,time-1)...
                    +deltat/deltax*(min(D(density(xposition-1,time-1)),S1(density(xposition,time-1)))...
                    -min(D1(density(xposition,time-1)),S1(density(xposition+1,time-1)))); 
           
           elseif xposition>22
                  density(xposition,time)=density(xposition,time-1)...
                    +deltat/deltax*(min(D1(density(xposition-1,time-1)),S1(density(xposition,time-1)))...
                    -min(D1(density(xposition,time-1)),S1(density(xposition+1,time-1)))); 

           else     %inside
                density(xposition,time)=density(xposition,time-1)...CL
                    +deltat/deltax*(min(D(density(xposition-1,time-1)),S(density(xposition,time-1)))...
                    -min(D(density(xposition,time-1)),S(density(xposition+1,time-1)))); 
           end
    end
end

%surf(density)

imagesc(density)

colormap(flipud(bone))
colorbar
set(gca, 'YDir', 'normal');
axis equal;
ylim([0 30]);
set(gca,'CLim',[0 0.6])
