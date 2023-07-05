% This is an input file for the GSHA procedure
%
% It should contain a list of names and location of geometry boundaries followed by a
% list of names for density values
% 
% Single values for density files are allowed.
HOME = pwd;
Model = struct();

Model.number_of_layers = 3;
Model.name = 'Crust10_crust';

% Additional variables
Model.GM = 4.28014E13;
Model.Re_analyse = 3389500;
Model.Re = 3389500;
Model.geoid = 'none';
Model.nmax = 50;     
Model.correct_depth = 0;

% % Topo layer
Model.l1.bound = [HOME '/Data/crust1.bd1.gmt'];
Model.l1.dens  = 2850;
% %Model.l1.alpha = 

% Bath layer
Model.l2.bound = [HOME '/Data/crust1.bd2.gmt'];
Model.l2.dens  = 2850;
% %Model.l2.alpha = 
% 
% % Sediment layer
Model.l3.bound = [HOME '/Data/crust1.bd3.gmt'];
Model.l3.dens  = 3500;
% %Model.l3.alpha = 
% 
% %Upper crustal layer
Model.l4.bound = [HOME '/Data/crust1.bd5.gmt'];
% %Model.l4.alpha = 
% % 
% % % Middle crustal layer
% Model.l5.bound = [HOME '/Data/crust1.bd5.gmt'];
% Model.l5.dens  = [HOME '/Data/crust1.rho5.gmt'];
% % %Model.l5.alpha = 
% % 
% % % Lower crustal layer
% Model.l6.bound = [HOME '/Data/crust1.bd6.gmt'];
% Model.l6.dens  = [HOME '/Data/crust1.rho6.gmt'];
% % %Model.l6.alpha = 
% % 
% % % Lower crustal body layer
% Model.l7.bound = [HOME '/Data/crust1.bd7.gmt'];
% Model.l7.dens  = [HOME '/Data/crust1.rho7.gmt'];
% % %Model.l7.alpha = 
% % 
% % % Lithosphere layer
% Model.l8.bound = [HOME '/Data/crust1.bd8.gmt'];
% Model.l8.dens  = [HOME '/Data/crust1.rho8.gmt'];
% % %Model.l8.alpha = 
% % 
% % % Asthenosphere crustal layer
% Model.l9.bound = [HOME '/Data/crust1.bd9.gmt'];
% Model.l9.dens  = 3300;
% % %Model.l9.alpha = 
% % 
% % % Bottom
% Model.l10.bound = [HOME '/Data/crust1.100km.gmt'];

% Save model in .mat file for use of the new software

save([HOME '/Data/' Model.name '.mat'],'Model')