load residual31
load trend_error31
load crust_Binversion33

resolution=1;
latLimT = [-90+(1/resolution/2) 90-(1/resolution/2) 1/resolution]; 
lonLimT = [1/resolution/2  360-(1/resolution/2) 1/resolution]; 

lonT = lonLimT(1):lonLimT(3):lonLimT(2);
latT = fliplr(latLimT(1):latLimT(3):latLimT(2));
LonT = repmat(lonT,length(latT),1);
LatT = repmat(latT',1,length(lonT));
aa = 18;
figure
imagesc(lonT,latT,residual31*1e5);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'mGal','Fontsize',aa)
title('Residual from the Bouguer inversion')
set(gca,'YDir','normal','Fontsize',aa)


aa = 18;
figure
imagesc(lonT,latT, bound2_reshape33);cc=colorbar;
xlabel('Longitude (\circ)','Fontsize',aa)
ylabel('Latitude (\circ)','Fontsize',aa)
ylabel(cc,'km','Fontsize',aa)
title('Crustal thickness from the Bouguer inversion')
set(gca,'YDir','normal','Fontsize',aa)

figure
plot(abs(trend31))
xlabel('n° iteration','Fontsize',aa)
ylabel('mGal','Fontsize',aa)
title('Trend of the mean of the residual over time')
