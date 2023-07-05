filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.bd3.gmt";
filecrust1="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.bd2.gmt";
filemantle="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.bd5.gmt";
C=dlmread(filecrust2);
bound2=C(:,3);
k=1;
for i=1:180
    for j=1:360
bound2_reshape(i,j)= bound2(k);
k=k+1;
    end

end

resolution = 1;
latLimT = [-90+(1/resolution/2) 90-(1/resolution/2) 1/resolution]; 
lonLimT = [1/resolution/2  360-(1/resolution/2) 1/resolution]; 

lonT = lonLimT(1):lonLimT(3):lonLimT(2);
latT = fliplr(latLimT(1):latLimT(3):latLimT(2));
LonT = repmat(lonT,length(latT),1);
LatT = repmat(latT',1,length(lonT));

filename = "C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\megt90n000cb.img";
resolution = 4;
% Read in the file.
f = fopen(filename,'r','ieee-be');
topography = fread(f,[360*resolution Inf],'int16')';
%topography=flip(topography);
fclose(f);

topography = imresize(topography, [180, 360], 'bilinear');

aa = 18;
figure

imagesc(lonT,latT,bound2_reshape+topography/1000);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Altitude [km]','Fontsize',aa)
title('Topography of Mars')
set(gca,'YDir','normal','Fontsize',aa)

