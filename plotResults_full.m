% plot results
clear;
close all;
clc;

%% tutorial data
%%% insert output data file from Results here!!!%%%
load(['test.mat'])

%% plot different maps of the data
lon = data.grd.lon(1,:);
lats = data.grd.lat(:,1);

% load coastlines;

% figure;
% subplot(2,2,1)
% imagesc(lon,lats,((data.pot)));c=colorbar; 
% hold on
% plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['Potential gravity field'])
% ylabel(c,'m*m/s/s') 
% set(gca,'YDir','normal')

for i=1:180
    for k=1:180
    data.vec.Znew(i,k)=data.vec.R(i,180+k);
    data.vec.Znew(i,180+k)=data.vec.R(i,k);
    end
end
%subplot(2,2,2)
imagesc(lon,lats,((data.vec.Znew)).*1e5);c=colorbar; 
hold on
% plot(coastlon,coastlat,'k','LineWidth',1.5);
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]','FontSize', 18)
ylabel('Latitude [^o]','FontSize', 18)
title(['Z-component of gravity vector'],'FontSize', 18)
ylabel(c,'mGal','FontSize', 18) 
set(gca,'YDir','normal','Fontsize',18)
VecZ=data.vec.Z;
save(['VecZ.mat'],'VecZ')

% subplot(2,2,3)
% imagesc(lon,lats,((data.vec.X)).*1e5);c=colorbar; 
% hold on
% % plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['X-component of gravity vector (North-South)'])
% ylabel(c,'mGal') 
% set(gca,'YDir','normal')

% subplot(2,2,4)
% imagesc(lon,lats,((data.vec.Y)).*1e5);c=colorbar; 
% hold on
% % plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['Y-component of gravity vector (East-West)'])
% ylabel(c,'mGal') 
% set(gca,'YDir','normal')
% 
% %% Tensor
% 
% figure;
% subplot(3,3,1)
% imagesc(lon,lats,((data.ten.Tzz).*1e9));c=colorbar;
% hold on
% % plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['Tzz-component of gravity gradient tensor'])
% ylabel(c,'Eotvos')
% set(gca,'YDir','normal')
% 
% % subplot(3,3,2)
% % imagesc(lon,lats,((data.ten.Tzx).*1e9));c=colorbar;
% % hold on
% % % plot(coastlon,coastlat,'k','LineWidth',1.5);
% % xlim([min(lon) max(lon)])
% % ylim([min(lats) max(lats)])
% % hold off
% % xlabel('Longitude [^o]')
% % ylabel('Latitude [^o]')
% % title(['Tzx-component of gravity gradient tensor'])
% % ylabel(c,'Eotvos') 
% % set(gca,'YDir','normal')
% % 
% % subplot(3,3,3)
% % imagesc(lon,lats,((data.ten.Tzy).*1e9));c=colorbar; 
% % hold on
% % % plot(coastlon,coastlat,'k','LineWidth',1.5);
% % xlim([min(lon) max(lon)])
% % ylim([min(lats) max(lats)])
% % hold off
% % xlabel('Longitude [^o]')
% % ylabel('Latitude [^o]')
% % title(['Tzy-component of gravity gradient tensor'])
% % ylabel(c,'Eotvos') 
% % set(gca,'YDir','normal')
% 
% subplot(3,3,5)
% imagesc(lon,lats,((data.ten.Txx).*1e9));c=colorbar; 
% hold on
% % plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['Txx-component of gravity gradient tensor'])
% ylabel(c,'Eotvos') 
% set(gca,'YDir','normal')
% 
% subplot(3,3,6)
% imagesc(lon,lats,((data.ten.Txy).*1e9));c=colorbar;
% hold on
% % plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['Txy-component of gravity gradient tensor'])
% ylabel(c,'Eotvos') 
% set(gca,'YDir','normal')
% 
% subplot(3,3,9)
% imagesc(lon,lats,((data.ten.Tyy).*1e9));c=colorbar; 
% hold on
% % plot(coastlon,coastlat,'k','LineWidth',1.5);
% xlim([min(lon) max(lon)])
% ylim([min(lats) max(lats)])
% hold off
% xlabel('Longitude [^o]')
% ylabel('Latitude [^o]')
% title(['Tyy-component of gravity gradient tensor'])
% ylabel(c,'Eotvos') 
% set(gca,'YDir','normal')
