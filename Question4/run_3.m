% makefile for the complete GSH circle for a particular model
clear;
close all;
clc;
load VecZ
HOME = pwd;
addpath([HOME '/Data']);
addpath([HOME '/Tools']);

% Model
% Load previous saved model

%model_name = 'Crust01_crust';
%load(model_name);

% Construct new model

%%%%%%%%%%%%%%%%%%% Computation area %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

latLim =    [-89.5 89.5 1];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [0.5 359.5 1];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0; % height of computation above spheroid
SHbounds =  [3 50]; % Truncation settings: lower limit, upper limit SH-coefficients used

%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

%% Global Spherical Harmonic Analysis 

% tic;
% [V] = V;
% toc
filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd3.gmt"
error=18;
factor=1;
VecZcorr=zeros(180,360);
for i=1:180
    for k=1:180
    VecZcorr(i,k)=VecZ(i,180+k);
    VecZcorr(i,180+k)=VecZ(i,k);
    end
end
g_obs=-flip(VecZcorr);
counter=1;
% bound2_newmax=-50;
% bound2_newmin=-50;
while error>0.01 %&& bound2_newmax<-25*1.02 && bound2_newmin>-75/1.02 
% input the uploaded model
inputModel_3
%generating the coefficients
[V] = model_SH_analysis(Model);
V(1,3)=0;
V(3,3)=0;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
%saving the results for gravity
g=data.vec.R;
g=flip(g);
residual=g_obs-g;
media=mean(residual,"all")*1e5
maximum=max(residual,[],"all")*1e5
normacheck=norm(g)/norm(g_obs)
residualsuit=convert(residual);
C=dlmread(filecrust2);
bound2=C(:,3);
bound2_new=bound2+residualsuit*factor;
bound2_newmax=max(bound2_new)
bound2_newmin=min(bound2_new)
B=[C(:,1), C(:,2), bound2_new];
dlmwrite(filecrust2, B, 'delimiter', ' ');
trend(1,counter)=media;
error=abs(media);
counter=counter+1;
% aa = 18;
% figure
% imagesc(lonT,latT,g_obs);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Topography (km)','Fontsize',aa)
% set(gca,'YDir','normal','Fontsize',aa)
% toc
% aa = 18;
% figure
% imagesc(lonT,latT,g);cc=colorbar;
% xlabel('Longitude (\circ)','Fontsize',aa)
% ylabel('Latitude (\circ)','Fontsize',aa)
% ylabel(cc,'Topography (km)','Fontsize',aa)
% set(gca,'YDir','normal','Fontsize',aa)
end
k=1;
for i=1:180
    for j=1:360
bound2_reshape(i,j)= bound2_new(k);
k=k+1;
    end

end
% save(['Results/' Model.name '.mat'],'V')

%% Save data
save(['residual.mat'],'residual')
save(['crust_Binversion'],'bound2_reshape')
save(['trend_error'],'trend')

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