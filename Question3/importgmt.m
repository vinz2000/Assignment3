filename = "C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\megt90n000cb.img";
resolution = 4;
% Read in the file.
f = fopen(filename,'r','ieee-be');
topography = fread(f,[360*resolution Inf],'int16')';
%topography=flip(topography);
fclose(f);

topography = imresize(topography, [180, 360], 'bilinear');
%x=0:1:179;
%y=0:1:359;
%imagesc(x,y,(topography)); c=colorbar;
A=dlmread("C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd1.gmt");
lon=A(:,1);
lat=A(:,2);

topographyvector=zeros(180.*360,1);
i=1;
for lats=1:1:180
    for lons=1:1:360
        topographyvector(i)=topography(lats, lons)./1e3;%in km
        i=i+1;
    end
end


crustvector=-33*ones(180*360, 1); 
crust2=-65*ones(180*360, 1);
%mantlevector=-75.*ones(180.*360, 1);
mantlevector1=-90*ones(180.*360, 1);
%mantlevector3=-90.*ones(180.*360, 1);
% mantlevector3=-150.*ones(180.*360, 1);
% mantlevector4=-175.*ones(180.*360, 1);
% mantlevector5=-200.*ones(180.*360, 1);
% mantlevector6=-225.*ones(180.*360, 1);
% mantlevector7=-250.*ones(180.*360, 1);
% mantlevector8=-275.*ones(180.*360, 1);


filetopo="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd1.gmt";
filecrust="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd2.gmt";
filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd3.gmt";
% filemantle1="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd4.gmt";
filemantle2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd5.gmt";
%filemantle3="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd6.gmt";
% filemantle4="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd7.gmt";
% filemantle5="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd8.gmt";
% filemantle6="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd9.gmt";
% filemantle7="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.rho1.gmt";
% filemantle8="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.rho2.gmt";


At=[lon, lat, topographyvector];
Ac=[lon, lat, crustvector];
Ac2=[lon, lat, crust2];
% Am=[lon, lat, mantlevector1];
Am2=[lon, lat, mantlevector1];
%Am3=[lon, lat, mantlevector3];
% Am4=[lon, lat, mantlevector4];
% Am5=[lon, lat, mantlevector5];
% Am6=[lon, lat, mantlevector6];
% Am7=[lon, lat, mantlevector7];
% Am8=[lon, lat, mantlevector8];

dlmwrite(filetopo, At, 'delimiter', ' ');
dlmwrite(filecrust, Ac, 'delimiter', ' ');
dlmwrite(filecrust2, Ac2, 'delimiter', ' ');
dlmwrite(filemantle2, Am2, 'delimiter', ' ');
% dlmwrite(filemantle2, Am2, 'delimiter', ' ');
%dlmwrite(filemantle3, Am3, 'delimiter', ' ');
% dlmwrite(filemantle4, Am4, 'delimiter', ' ');
% dlmwrite(filemantle5, Am5, 'delimiter', ' ');
% dlmwrite(filemantle6, Am6, 'delimiter', ' ');
% dlmwrite(filemantle7, Am7, 'delimiter', ' ');
% dlmwrite(filemantle8, Am8, 'delimiter', ' ');
