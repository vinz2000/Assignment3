close all
clear all
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
rhomantle=3600;
airycorrection=topographyvector*rhocrust/(rhomantle-rhocrust);
k=1;
for i=1:180
    for j=1:360
airy_reshape(i,j)= airycorrection(k);
k=k+1;
    end

end
T=246460; %T=linspace(100000,600000,100) was used for the run
filecrust2="C:\Users\vince\Desktop\tudelft\physics\Assignment3\Question7\Data\crust1.bd3.gmt"
cs = GSHA(airy_reshape,80);
sc = cs2sc(cs);
n = 1:size(sc,1);
sc_flex = zeros(size(sc));
for counter=1:1 %counter=1:100 was used for the run
importgmt
nu=0.27;
E=140e9;
R=3389500;
% D = ETe^3/(12(1-nu^2))
H(counter) = E*T(counter)^3/(12*(1-nu^2));
% Phi = 1 * (D/(rhom-rhoc)g)*(2(n+1)/2R)^4)-1
%PHI = (1 +(H(counter))/((rhomantle-rhocrust)*3.72).*(2.*(n+1)./(2*R)).^4).^(-1); 
first=(1/(R^4))*(n.*(n+1)-2).^2./(1-((1-nu)./(n.^2+n)));
second=(12*(1-nu^2)/(T(counter)^2*R^2))*((1-(2./(n.^2+n)))./(1-((1-nu)./(n.^2+n))));
PHI = ((1 + (H(counter)/((rhomantle-rhocrust)*3.72)).*(first+second))).^(-1);
for m = 1:size(sc,2)
    sc_flex(:,m) = sc(:,m).*PHI';
end

 %GSHS

mapf = GSHS(sc_flex,lonT,90-latT,80);


mapf2=convert(mapf);
C=dlmread(filecrust2);
bound3=C(:,3);
bound3_new=bound3-mapf2/1000;
D=[C(:,1) C(:,2) bound3_new];
dlmwrite(filecrust2, D, 'delimiter', ' ');
inputModel7
latLim =    [-89.5 89.5 1];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [-180 180 1];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0; % height of computation above spheroid
SHbounds =  [3 80]; % Truncation settings: lower limit, upper limit SH-coefficients used
tic;
[V] =  model_SH_analysis(Model);
toc
save(['Results/' Model.name '.mat'],'V')
tic;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
toc
V2=V;
save(['test.mat'],'data')
save(['V_airycorrected'],'V2')
load V
load V_airycorrected
V=[0 0 1 0; V];
[nV, dV_obs7]=degreeVariance(V);
[nV, dV_airycorrected7]=degreeVariance(V2);
Values=dV_obs7(4:end)-dV_airycorrected7(4:end);
y=rssq(Values)
RS(counter)=y;
if min(RS)==RS(counter)
    optTe=T(counter);
    %dV_real=dV_obs7;
    %dV_airyrealip=dV_airycorrected7;
    dV_airythinshell=dV_airycorrected7;
end
end
%save('dV_infiniteplate','dV_airyrealip')
save('dV_thinshell.mat','dV_airythinshell')

% The best value using infinite plate seems to be 385.710 km of Te
% The best value using thin shell, instead, is set to 246.460 km of Te!

testrun


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

