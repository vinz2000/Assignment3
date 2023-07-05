clear
close all
clc
load VecZ
HOME = pwd;
addpath([HOME '/Data']);
addpath([HOME '/Tools']);

filerho2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.rho2.gmt";


C=dlmread(filerho2);
bound3rho=C(:,3);
bound3_newrho=3.4*ones(64800,1);
D=[C(:,1) C(:,2) bound3_newrho];
dlmwrite(filerho2, D, 'delimiter', ' ');  %Initialize the gmt file
error=8;%10;
factor=15;
VecZcorr=zeros(180,360);
for i=1:180
    for k=1:180
    VecZcorr(i,k)=VecZ(i,180+k);
    VecZcorr(i,180+k)=VecZ(i,k);
    end
end
g_obs=-flip(VecZcorr);
counter=1;
while error>2
inputModel8

latLim =    [-89.5 89.5 1];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [0.5 359.5 1];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0; % height of computation above spheroid
SHbounds =  [5 80]; % Truncation settings: lower limit, upper limit SH-coefficients used

tic;
[V] = model_SH_analysis(Model);
toc
V(1,3)=0;
V(3,3)=0;
save(['Results/' Model.name '.mat'],'V')
V8=V;
tic;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V8,Model);
toc

gravity8=flip(data.vec.R);
gravity8=gravity8(:,1:360);
residual8=g_obs-gravity8;
media=mean(residual8,"all")*1e5
maximum=max(residual8,[],"all")*1e5
normacheck=norm(gravity8)/norm(g_obs)
residual8suit=convert(residual8);
if error<0.05
    factor=25;
elseif error<0.01
    factor=35;
end
filerho2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question8\Data\crust1.rho2.gmt";
C=dlmread(filerho2);
bound3rho=C(:,3);
bound3_rhoupdate=bound3rho+residual8suit*factor;
bound3_max=max(bound3_rhoupdate)
bound2_min=min(bound3_rhoupdate)
B=[C(:,1), C(:,2), bound3_rhoupdate];
dlmwrite(filerho2, B, 'delimiter', ' ');
trend(1,counter)=media;
error=abs(maximum);
counter=counter+1;
end
k=1;
for i=1:180
    for j=1:360
bound3_reshape(i,j)= bound3_rhoupdate(k);
k=k+1;
    end
end
resolution=1;
latLimT = [-90+(1/resolution/2) 90-(1/resolution/2) 1/resolution]; 
lonLimT = [1/resolution/2  360-(1/resolution/2) 1/resolution]; 

lonT = lonLimT(1):lonLimT(3):lonLimT(2);
latT = fliplr(latLimT(1):latLimT(3):latLimT(2));
LonT = repmat(lonT,length(latT),1);
LatT = repmat(latT',1,length(lonT));
aa = 18;
figure
imagesc(lonT,latT,bound3_reshape);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Density [kg/m^3]','Fontsize',aa)
set(gca,'YDir','normal','Fontsize',aa)
title('Crustal density lateral variations ')
figure
imagesc(lonT,latT,residual8*1e5);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'Residual [mGal]','Fontsize',aa)
set(gca,'YDir','normal','Fontsize',aa)
title('Residual from flexural inversion')


save(['test.mat'],'data')
save(['V_airycorrected'],'V8')
save('trend8.mat','trend')

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
