clearvars;
fname = '5_5_1.5';
I = imread(strcat(fname,'.jpg'));
% I = imrotate(I,2,'bilinear','crop');
figure(1);clf;
h = imshow(I);
title('Press Enter when the line matches the scalebar')
imdistline(gca,[10 30],[10 10]);
pause;

prompt = {'Width of the Scalebar [um]:','Line Segment Length [pix]:'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'3','387'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
sf = str2num(answer{1})./str2num(answer{2});
sf = 25/137.15;
[l,w,d] = size(I); 
title('Paused, Enter when finished')
pause;

n = 10000;
title('Select endpoints, Enter when finished')
[x,y] = ginput;
[cx,cy,c] = improfile([1,w],[1,l],I,x',y',n,'bicubic');
c = mean(c,3)-min(c);


hold on
plot(x,y,'r--')


figure(2);clf;
plot((1:length(c))./(sqrt((x(2)-x(1))^2+(y(2)-y(1))^2)),c(:,:,1))
hold on
grid on
findpeaks(c(:,:,1),cx,'MinPeakHeight',20,'MinPeakDistance',1)

%Janice: I added cx here, trying to have the x-axis relfects the actual
%distance
[pks,locs,w,p] = findpeaks(c(:,:,1),'MinPeakHeight',40,'WidthReference', 'halfheight');
file = strcat('x20y15_x','.txt');
dr ='T:\Users\Alpha\Documents\Andy\nanoscribe\pillars_tiltCorrection\';
mkdir(dr);
f = fopen(file,'w');
fprintf(f,'%d  %d\n',[locs(:),w(:)]');

figure(3);clf;
hold on
histogram(w(1:round(length(w)/2)),10,'FaceAlpha',0.5,'EdgeAlpha',0)
histogram(w(round(length(w)/2):end),10,'FaceAlpha',0.5,'EdgeAlpha',0)
meanl = mean(w(1:round(length(w)/2)));
meanr = mean(w(round(length(w)/2):end));
plot([meanl meanl],[0 15],'b--')
plot([meanr meanr],[0 15],'r--')

legend('Left','Right','Left mean','Right mean')
title('Peak Width distributions')
