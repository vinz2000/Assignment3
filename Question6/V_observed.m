clear all
clc 
load V
latLim =    [-89.5 89.5 1];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [0.5 359.5 1];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0.0; % height of computation above spheroid
SHbounds =  [0 80]; % Truncation settings: lower limit, upper limit SH-coefficients used
%%
V=[0 0 1 0; V];
[nV, dV_obs]=degreeVariance(V);
%dV_obs=dV_obs.*1e10;
%dV_obs(3)=167.238128025178; %this value is hardcoded, but just because my simulation does not take into
% account the first 3 degree
load V_airy4
%V=[0 0 1 0; V];
[nV, dV_airynocorr]=degreeVariance(V1);
%dV_airy=dV_airy.*1e10;
load V_bouguerinversion
V(1,3)=1;
[nV, dV_bouguer]=degreeVariance(V);
%dV_bouguer=dV_bouguer*1e10;
load V_airycorrected
%V=[0 0 1 0; V];
[nV, dV_airycornotopt]=degreeVariance(V2);
%dV_airycorrected=dV_airycorrected*1e10;
aa=18;
figure
loglog(nV(3:end), dV_obs(3:end), "*"); hold on;
loglog(nV(3:end), dV_bouguer(3:end), "*"); hold on;
loglog(nV(3:end), dV_airynocorr(3:end), "*"); hold on;
loglog(nV(3:end), dV_airycornotopt(3:end), "*"); hold on;
ylabel('Degree Variance [-]', 'Fontsize',aa)
xlabel('Spherical Harmonics Degree [-]','Fontsize',aa)
legend('Observed', 'Bouguer', 'Airy', 'Flexural Airy','Fontsize',13)
title('Degree Variance (3-80) for the 4 models','Fontsize',aa)
save('dv_obs','dV_obs')
save('dV_airynocorr','dV_airynocorr')
save('dV_bouguer','dV_bouguer')
save('dV_airycornotopt','dV_airycornotopt')
