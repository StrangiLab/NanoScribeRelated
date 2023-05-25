%script to print a circle array in GWL format
%arl92@case.edu
%2021/02/08
%Copyright Resevered (GNL GPL) 

clearvars;
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Parameter Input  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%
xmin = -49.5;           %um position
xmax = 49.5;            %um position
xstep = 5.0;            %um (>400nm for resolved pillars)
dmin = -pi;             %radian
dmax = 16*pi;              %radian
dmid = pi;
dstep = pi/10;          %radian
a = 0;                 % constant a defining the radius of archimedean spiral
b = 0.03;                   % constant b defining the radius of archimedean spiral
radius = 1;             %um radius
zmax = 0.6;             %um
zsteps = 0.0:0.3:zmax; %z steps (use 0.3um spacing up to max value)
exposureTime = 0.15; %exposure time sets pillar radius
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
steps = xmin:xstep:xmax;
dsteps = dmin:dstep:dmax;
dmsteps = dmin:dstep:dmid;
%save the file output
file = strcat('et',num2str(exposureTime),'-',num2str(max(zsteps)),num2str(a),'-',num2str(b),'spiral','.gwl');
dr = 'T:\Users\Alpha\Documents\Andy\nanoscribe\ArchimedeanSpiral\';
mkdir(dr);
f = fopen(strcat(dr,file),'w');

%write details to a control file
%%%%WRITE ANY DETAILS HERE!!!
c = fopen(strcat('T:\Users\Alpha\Documents\Andy\nanoscribe\ArchimedeanSpiral\',strcat(file,'_details.txt')),'w');
fprintf(c,'Details for file: %s\n\n',file);
fprintf(c,'x-y range   : [%2.1f, %2.1f]\n',xmin,xmax);
fprintf(c,'x-y spacing : %2.1f\n',xstep);
fprintf(c,'CircleCount : %d\n',length(steps).^2);
fprintf(c,'Max height  : %2.1f\n',max(zsteps));
fprintf(c,'ExposureTime: %1.2f\n',exposureTime);
fprintf(c,'ContinuousMode\n');
fprintf(c,'ConnectPointsOn\n');
fprintf(c,'\nThis file will output only the point sets to form circles. There are no additional headers included.\n');
fclose(c);

%start the printing
% fprintf(f,'ContinuousMode\n\n');
% fprintf(f,'ConnectPointsOn\n\n');
% fprintf(f,'ExposureTime %1.2f\n',exposureTime);

%iterate through the pillar array
iter=0;
for z=1:length(zsteps)
    for i=1:length(steps)
        for j=1:length(steps)
            for k = 1:length(dsteps)
                %x-y-z position of spot
                fprintf(f,'%2.1f %2.1f %1.1f\n',steps(i)+ (a + b* dsteps(k))*cos(dsteps(k)),steps(j)+ (a + b* dsteps(k))*sin(dsteps(k)),zsteps(z));
                
                radius = a + b* dsteps(k);
            end
            for m = 1:length(dmsteps)
                %x-y-z position of spot
                fprintf(f,'%2.1f %2.1f %1.1f\n',steps(i)+ radius*cos(dmsteps(m)-pi),steps(j)+ radius*sin(dmsteps(m)-pi),zsteps(z)); 
            end  
            fprintf(f,'Write\n');
%                 fprintf(f,'ExposureTime %1.2f\n',exposureTime);    
        end
    end
end


%end with a write statement
fprintf(f,'Write\n\n');
fprintf(f,'%%EOF\n\n');
fclose(f);