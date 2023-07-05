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
filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd3.gmt";
filecrust1="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd2.gmt";
filemantle="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question3\Data\crust1.bd5.gmt";
error=18;
factor=80;
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
inputmodel_33
%generating the coefficients
[V] = model_SH_analysis(Model);
V(1,3)=0;
V(3,3)=0;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
%saving the results for gravity
g=data.vec.R;
g=flip(g);
residual33=g_obs-g;
media=mean(residual33,"all")*1e5
maximum=max(residual33,[],"all")*1e5
normacheck=norm(g)/norm(g_obs)
residualsuit=convert(residual33);
C=dlmread(filecrust2);
if error<0.1
    factor=200;
end
bound2=C(:,3);
bound2_new=bound2+residualsuit*factor;
bound2_newmax=max(bound2_new)
bound2_newmin=min(bound2_new)
B=[C(:,1), C(:,2), bound2_new];
dlmwrite(filecrust2, B, 'delimiter', ' ');
trend33(1,counter)=media;
error=abs(media);
counter=counter+1;

E=dlmread(filecrust1);
boundupper=E(:,3);
modified=0;
for i=1:64800
    if boundupper(i)<bound2_new(i)
        boundupper(i)=bound2_new(i);
        modified=100;
    end
end
if modified ~=0 
F=[E(:,1), E(:,2), boundupper];
dlmwrite(filecrust1, F, 'delimiter', ' ');

end
G=dlmread(filemantle);
boundlower=G(:,3);
modified2=0;
for i=1:64800
    if boundlower(i)>bound2_new(i)
        boundlower(i)=bound2_new(i);
        modified2=100;
    end
end
if modified2 ~=0 
H=[E(:,1), E(:,2), boundlower];
dlmwrite(filemantle, H, 'delimiter', ' ');
end
k=1;
for i=1:180
    for j=1:360
bound2_reshape33(i,j)= bound2_new(k);
k=k+1;
    end

end
end
% save(['Results/' Model.name '.mat'],'V')

% Save data
save(['residual33.mat'],'residual33')
save(['crust_Binversion33'],'bound2_reshape33')
save(['trend_error33'],'trend33')


%% max value -18.82, min value -87.62.
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