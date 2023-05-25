%script to print a regular pillar array in GWL format
%arl92@case.edu
%2021/12/15
%Copyright Resevered (GNL GPL) 

clearvars;
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Parameter Input  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%
xmin = -49.5;           %um position
xmax = 49.5;            %um position
xstep = 1.0;            %um (>400nm for resolved pillars)
zmax = 1.2;
zsteps = 0.0:0.3:zmax;  %z steps (use 0.3um spacing up to max value)
exposureTime = 0.2;    %exposure time sets pillar radius
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
steps = xmin:xstep:xmax;

%save the file output
file = strcat('et',num2str(exposureTime),'-',num2str(max(zsteps)),'.gwl');
f = fopen(strcat('T:\Users\Alpha\Documents\Andy\nanoscribe\largePillarArray\',file),'w');

%write details to a control file
c = fopen(strcat('T:\Users\Alpha\Documents\Andy\nanoscribe\largePillarArray\',strcat(file,'_details.txt')),'w');
fprintf(c,'Details for file: %s\n\n',file);
fprintf(c,'x-y range   : [%2.1f, %2.1f]\n',xmin,xmax);
fprintf(c,'x-y spacing : %2.1f\n',xstep);
fprintf(c,'PillarCount : %d\n',length(steps).^2);
fprintf(c,'Max height  : %2.1f\n',max(zsteps));
fprintf(c,'ExposureTime: %1.2f\n',exposureTime);
fprintf(c,'Pulsed Mode\n');
fprintf(c,'ConnectPointsOff\n');
fclose(c);

%start the printing
fprintf(f,'PulsedMode\n\n');
fprintf(f,'ConnectPointsOff\n\n');
fprintf(f,'ExposureTime %1.2f\n',exposureTime);

%iterate through the pillar array
iter=0;
for z=1:length(zsteps)
    for i=1:length(steps)
        for j=1:length(steps)
            %x-y-z position of spot
            fprintf(f,'%2.1f %2.1f %1.1f\n',steps(i),steps(j),zsteps(z));
            iter = iter + 1;
            %periodic write statements throughout the code. I think this is
            %necessary to clear the buffer and print pillar blocks, but it
            %might be unnecessary still. Need to test.
           
        end
    end
end

%end with a write statement
fprintf(f,'Write\n\n');
fprintf(f,'%%EOF\n\n');
fclose(f);