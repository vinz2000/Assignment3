clear;
close all;
clc;

addpath('~/TUDelft/Code/GSH/Tools/')
load sc_2.mat
load Long
load Lat
load residual
load crust_Binversion
load trend_error
load trend_error31
load trend_error32
load trend_error33

%%
filename = 'megt90n000cb.img';
resolution = 4;

% Read in the file.
f = fopen(filename,'r','ieee-be');
el4 = fread(f,[360*resolution Inf],'int16')';
fclose(f); 
Gconst=6.67E-11;
%%

latLimT = [-90+(1/resolution/2) 90-(1/resolution/2) 1/resolution]; 
lonLimT = [1/resolution/2  360-(1/resolution/2) 1/resolution]; 

lonT = lonLimT(1):lonLimT(3):lonLimT(2);
latT = fliplr(latLimT(1):latLimT(3):latLimT(2));
LonT = repmat(lonT,length(latT),1);
LatT = repmat(latT',1,length(lonT));

aa = 18;
figure

imagesc(lonT,latT,el4./1e3);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Altitude [km]','Fontsize',aa)
title('Topography of Mars')
set(gca,'YDir','normal','Fontsize',aa)

%%%%%%%%%%%%%
%reducing the matrix of the topography for coherence with gravity matrix
G=zeros(720,360);
G_2=zeros(180,360);
for j=1:720
for i=4:4:1440
G(j,i/4)=(el4(j,i)+el4(j,i-1)+el4(j,i-2)+el4(j,i-3))/4;
end
end
for i=4:4:720
G_2(i/4,:)=(G(i,:)+G(i-1,:)+G(i-2,:)+G(i-3,:))/4;
end
%calcolating the free-air correction
el45=G_2*2*pi()*Gconst*2850;
%plotting the free-air correction
aa = 18;
figure
imagesc(lonT,latT,el45*1e5);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Correction [mGal]','Fontsize',aa)
title('Free air correction')
set(gca,'YDir','normal','Fontsize',aa)
%importing and adjusting the gravity data
load VecZ
VecZcorr=zeros(180,360);
for i=1:180
    for k=1:180
    VecZcorr(i,k)=VecZ(i,180+k);
    VecZcorr(i,180+k)=VecZ(i,k);
    end
end
VecZcorr=-flip(VecZcorr);

%plotting the gravity data
aa = 18;
figure
%title()
imagesc(lonT,latT,VecZcorr*1e5);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Gravity acceleration [mGal]','Fontsize',aa)
title('Gravity acceleration without C00 and C20')
set(gca,'YDir','normal','Fontsize',aa)

%calcolating and plotting the Bouguer anomaly
Bouguer=VecZcorr-(el45);
aa = 18;
figure
imagesc(lonT,latT,Bouguer*1e5);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Anomaly [mGal]','Fontsize',aa)
title('Map of the Bouguer anomaly ')
set(gca,'YDir','normal','Fontsize',aa)
resolution=1;
latLimT = [-90+(1/resolution/2) 90-(1/resolution/2) 1/resolution]; 
lonLimT = [1/resolution/2  360-(1/resolution/2) 1/resolution]; 

lonT = lonLimT(1):lonLimT(3):lonLimT(2);
latT = fliplr(latLimT(1):latLimT(3):latLimT(2));
LonT = repmat(lonT,length(latT),1);
LatT = repmat(latT',1,length(lonT));
aa = 18;
figure
imagesc(lonT,latT,residual*1e5);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Residual [mGal]','Fontsize',aa)
title('Residual from the Bouguer inversion')
set(gca,'YDir','normal','Fontsize',aa)


aa = 18;
figure
imagesc(lonT,latT, -(bound2_reshape-G_2/1000));cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Depth [km]','Fontsize',aa)
title('Crustal thickness from the Bouguer inversion')
set(gca,'YDir','normal','Fontsize',aa)

figure
plot(abs(trend), 'DisplayName', '2850 & 2850', 'LineWidth',3)
hold on
plot(abs(trend31), 'DisplayName', '2900 & 2900','LineWidth',1.5)
hold on
plot(abs(trend32), 'DisplayName', '2850 & 3000','LineWidth',1.5)
hold on
plot(abs(trend33), 'DisplayName', '2700 & 2850','LineWidth',1.5)
hold on
x=[1,1,1,1];
y=[abs(trend(1)), abs(trend31(1)), abs(trend32(1)), abs(trend33(1))];
scatter(x,y,'filled', 'DisplayName', 'Initial error')
xlabel('n° iteration','Fontsize',aa)
ylabel('Mean value [mGal]','Fontsize',aa)
title('Trend of the mean of the residual until convergence')
set(gca,'YDir','normal','Fontsize',aa)
lgd=legend;
lgd.FontSize=14;
lgd.Title.String = 'Crustal densities [kg/m^3]';
z=[0,1,2];
axes('position',[.20 .75 .15 .15])
box on
indexOfInterest = (z < 2);
plot(abs(trend(indexOfInterest)))
hold on
plot(abs(trend31(indexOfInterest)))
hold on
plot(abs(trend32(indexOfInterest)))
hold on
plot(abs(trend33(indexOfInterest)))
hold on
x=[1,1,1,1];
y=[abs(trend(1)), abs(trend31(1)), abs(trend32(1)), abs(trend33(1))];
scatter(x,y,'filled', 'DisplayName', 'Initial error')
axes('position',[.67 .17 .18 .18])
box on
z=275:1:315;
indexOfInterest = z;
plot(z,abs(trend(indexOfInterest)))
hold on
plot(z,abs(trend31(indexOfInterest)))
hold on
plot(z,abs(trend32(indexOfInterest)))
hold on
plot(z,abs(trend33(indexOfInterest)))







% %% GSHA
% 
% cs = GSHA(el4,110);
% sc = cs2sc(cs);
% 
% n = 1:size(sc_2,1);
% % D = ETe^3/(12(1-nu^2))
% D = 100e9*(60e3)^3/(12*(1-0.27^2));
% % Phi = 1 * (D/(rhom-rhoc)g)*(2(n+1)/2R)^4)-1
% PHI = (1 + (D)/(300*3.72).*(2.*(n+1)./(2*3389500)).^4).^(-1);
% 
% sc_flex = zeros(size(sc));
% 
% for m = 1:size(sc)
%     sc_flex(:,m) = sc(:,m).*PHI';
% end
% 
% %% GSHS
% 
% mapf = GSHS(sc_flex,lonT,90-latT,110);
% 
% %%
% figure
% imagesc(lonT,latT,mapf./1e3);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Topography (km)','Fontsize',aa)
% set(gca,'YDir','normal','Fontsize',aa)
% 
% figure
% imagesc(lonT,latT,(el4-mapf)./1e3);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Topography (km)','Fontsize',aa)
% set(gca,'YDir','normal','Fontsize',aa)