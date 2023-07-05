% makefile for the complete GSH circle for a particular model
clear all;
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
V1=V;
%% Save data
save(['test.mat'],'data')
save(['V_airy4'],'V1')