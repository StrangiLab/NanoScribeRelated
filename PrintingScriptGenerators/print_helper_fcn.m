%job helper fcn
%arl92@case.edu
%2022/01/10
%Copyright Resevered (GNL GPL) 

clearvars;
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Parameter Input  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%
zmax = 2.1;
zmin = 0.9;%um
zsteps = zmin:0.3:zmax; %z steps (use 0.3um spacing up to max value)
emin = 0.1;
emax = 0.2;
exposureTime = emin:0.02:emax; %exposure time sets pillar radius
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

%save the file output
file = strcat('largePillarArray-varyEtH');

dr = 'T:\Users\Alpha\Documents\Andy\nanoscribe\new_trajectory_largepillarsarray';

c = fopen(strcat(dr,file,'_jobhelper_newtrajectory.gwl'),'w');

iter = 1;
for i = 1:length(exposureTime)
    fprintf(c,'MoveStageX $incrementx\n\n');
    for j = 1:length(zsteps)
        fprintf(c,'TimeStampOn\n');
        fprintf(c,'MessageOut "Printing: Box %%d of %%d"#(%d,%d)\n',iter,length(exposureTime)*length(zsteps));
        fprintf(c,'MessageOut "Printing: Et %%1.2f H %%1.2f"#(%1.2f,%1.2f)\n',exposureTime(i),zsteps(j));
        fprintf(c,'TimeStampOff\n');
        fprintf(c,'MoveStageY $incrementy\n');
        %write on substrate
        fprintf(c,'MoveStageY -($incrementy/4+30)\n');
        fprintf(c,'MoveStageX -50\n');
        fprintf(c,'WriteText "Et=%1.2f,H=%1.2f,LP=%%2.1f"#($LP)\n',exposureTime(i),zsteps(j));
        fprintf(c,'MoveStageY ($incrementy/4+30)\n');
        fprintf(c,'MoveStageX 50\n');
        fprintf(c,'FindInterfaceAt $interfacePos\n');
        if exposureTime(i) == 0.1 || exposureTime(i) == 0.2
            fprintf(c,'include et%1.1f-%1.1f.gwl\n\n',exposureTime(i),zsteps(j));

        else
            fprintf(c,'include et%1.2f-%1.1f.gwl\n\n',exposureTime(i),zsteps(j));

        end
        iter = iter +1;
    end
    fprintf(c,'MoveStageY -(%d)*$incrementy\n\n',length(zsteps));
end

fprintf(c,'%% EOF\n\n');

fclose(c);
clearvars;