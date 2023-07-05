% makefile for the complete GSH circle for a particular model
clear;
close all;
clc;
HOME = pwd;
addpath([HOME '/Data']);
addpath([HOME '/Tools']);

% Model
% Load previous saved model

%model_name = 'Crust01_crust';
%load(model_name);


%%%%%%%%%%%%%%%%%%% Computation area %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

latLim =    [-89.5 89.5 1];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [-180 180 1];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0; % height of computation above spheroid
SHbounds =  [0 80]; % Truncation settings: lower limit, upper limit SH-coefficients used

filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\Data\crust1.bd3.gmt";
filecrust1="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\Data\crust1.bd2.gmt";
filemantle="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question5\Data\crust1.bd5.gmt";
C=dlmread(filecrust2);
bound2=C(:,3);
E=dlmread(filecrust1);
boundupper=E(:,3);
modified=0;
for i=1:64800
    if boundupper(i)<bound2(i)
        boundupper(i)=bound2(i);
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
    if boundlower(i)>bound2(i)
        boundlower(i)=bound2(i);
        modified2=100;
    end
end
if modified2 ~=0 
H=[E(:,1), E(:,2), boundlower];
dlmwrite(filemantle, H, 'delimiter', ' ');
end
% Construct new model
inputModel_3 

%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

%% Global Spherical Harmonic Analysis 

tic;
[V] =  model_SH_analysis(Model);
toc

save(['Results/' Model.name '.mat'],'V')

%% Global Spherical Harmonic Synthesis

tic;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
toc
V2=V;
%% Save data
save(['test.mat'],'data')
save(['V_airycorrected'],'V2')