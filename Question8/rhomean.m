
filename = "C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\megt90n000cb.img";
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
A=dlmread("C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.bd1.gmt");
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

filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.bd3.gmt";
F=dlmread(filecrust2);
boundcrust=F(:,3);
filerho2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.rho2.gmt";


C=dlmread(filerho2);
bound3rho=C(:,3);
tot=0;
for i=1:64800
mediarhocrust= ((topographyvector(i)+33)*2.600 + (-boundcrust(i)-33)*bound3rho(i))/(topographyvector(i)-boundcrust(i));
tot=tot+mediarhocrust;
end
tot=tot/64800;