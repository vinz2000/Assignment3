close all; clc; clearvars;
filename = "C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\megt90n000cb.img";
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
A=dlmread("C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\Data\crust1.bd1.gmt");
lon=A(:,1);
lat=A(:,2);

resolution=1;
latLimT = [-90+(1/resolution/2) 90-(1/resolution/2) 1/resolution]; 
lonLimT = [1/resolution/2  360-(1/resolution/2) 1/resolution]; 

lonT = lonLimT(1):lonLimT(3):lonLimT(2);
latT = fliplr(latLimT(1):latLimT(3):latLimT(2));
LonT = repmat(lonT,length(latT),1);
LatT = repmat(latT',1,length(lonT));

topographyvector=zeros(180.*360,1);
i=1;
for lats=1:1:180
    for lons=1:1:360
        topographyvector(i)=topography(lats, lons);%in m
        i=i+1;
    end
end

rhocrust=2850;
rhomantle=3500;
airycorrection=topographyvector*rhocrust/(1000*(rhomantle-rhocrust));
%airycorrectionvect=convert(airycorrection);
filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\Data\crust1.bd3.gmt"
C=dlmread(filecrust2);
bound2=C(:,3);
bound2_new=bound2-airycorrection;
D=[C(:,1) C(:,2) bound2_new];
dlmwrite(filecrust2, D, 'delimiter', ' ');
k=1;
for i=1:180
    for j=1:360
bound2_reshape(i,j)= bound2_new(k);
k=k+1;
    end

end
k=1;
for i=1:180
    for j=1:360
airy_reshape(i,j)= airycorrection(k);
k=k+1;
    end

end


%% GSHA

cs = GSHA(airy_reshape*1000,80);
sc = cs2sc(cs);

n = 1:size(sc,1);
T=(110000+300000)/2 %is the mean around the globe
nu=0.27;
E=110e9;
R=3389500;
% D = ETe^3/(12(1-nu^2))
H = E*T^3/(12*(1-nu^2));
% Phi = 1 * (D/(rhom-rhoc)g)*(2(n+1)/2R)^4)-1
PHI = (1 + H/((rhomantle-rhocrust)*3.72).*(2.*(n+1)./(2*R)).^4).^(-1);

sc_flex = zeros(size(sc));

for m = 1:size(sc,2)
    sc_flex(:,m) = sc(:,m).*PHI';
end

%% GSHS

mapf = GSHS(sc_flex,lonT,90-latT,80);
%%
aa=18;
figure
imagesc(lonT,latT,mapf./1e3);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Correction [km]','Fontsize',aa)
set(gca,'YDir','normal','Fontsize',aa)
title('Flexural filtered Airy correction')

mapf2=convert(mapf);
importgmt
C=dlmread(filecrust2);
bound3=C(:,3);
bound3_new=bound3-mapf2/1000;
D=[C(:,1) C(:,2) bound3_new];
dlmwrite(filecrust2, D, 'delimiter', ' ');

k=1;
for i=1:180
    for j=1:360
bound3shape(i,j)= bound3_new(k);
k=k+1;
    end

end


% figure
% imagesc(lonT,latT,(airy_reshape*1000));cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Correction [km]','Fontsize',aa)
% set(gca,'YDir','normal','Fontsize',aa)
% title('Airy Correction after flexural filter')


% boundary_flexural=airy_reshape*1000-mapf-bound2;
% 
% figure
% imagesc(lonT,latT,(boundary_flexural)./1e3);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Depth [km]','Fontsize',aa)
% set(gca,'YDir','normal','Fontsize',aa)
% title('Crust-mantle boundary after flexural correction')
% aa = 18;
% figure
% imagesc(lonT,latT,-(topography/1000+bound2_reshape));cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Thickness [km]','Fontsize',aa)
% title('Crustal Thickness from Airy model')
% set(gca,'YDir','normal','Fontsize',aa)
% aa = 18;
% figure
% imagesc(lonT,latT,airy_reshape);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Vertical variation [km]','Fontsize',aa)
% title('Airy Correction')
% set(gca,'YDir','normal','Fontsize',aa)
% aa = 18;
% figure
% imagesc(lonT,latT,-bound2_reshape);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Depth [km]','Fontsize',aa)
% title('Crust-mantle boundary')
% set(gca,'YDir','normal','Fontsize',aa)

aa = 18;
figure
imagesc(lonT,latT,-bound3shape+topography/1000);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Thickness [km]','Fontsize',aa)
title('Crust-Mantle boundary after flexural')
set(gca,'YDir','normal','Fontsize',aa)


%% functions
function vector=convert(A)
    v=zeros(180*360,1);
    i=1;
    for lats=1:1:180
        for lons=1:1:360
            v(i)=A(lats, lons);%in km
            i=i+1;
        end
    end
   vector=v;
end

