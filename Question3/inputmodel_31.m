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
Model.l1.dens  = 2900;

% % First layer crust 
Model.l2.bound = [HOME '/Data/crust1.bd2.gmt'];
Model.l2.dens  = 2900;

% % Crust-mantle bound 
Model.l3.bound = [HOME '/Data/crust1.bd3.gmt'];
Model.l3.dens  = 3500;

% % Topo layer
Model.l4.bound = [HOME '/Data/crust1.bd5.gmt'];
% Model.l4.dens  = 3500;

% % % Topo layer
% Model.l3.bound = [HOME '/Data/crust1.bd5.gmt'];
% Model.l3.dens  = 3500;
% 
% % % Topo layer
% Model.l4.bound = [HOME '/Data/crust1.bd6.gmt'];
% Model.l4.dens  = 3600;
% 
% % % Topo layer
% Model.l5.bound = [HOME '/Data/crust1.bd7.gmt'];
% Model.l5.dens  = 3700;
% 
% % % Topo layer
% Model.l6.bound = [HOME '/Data/crust1.bd8.gmt'];
% Model.l6.dens  = 3800;
% 
% % % Topo layer
% Model.l7.bound = [HOME '/Data/crust1.rho1.gmt'];
% Model.l7.dens  = 3900;
% 
% % % Topo layer
% Model.l8.bound = [HOME '/Data/crust1.rho2.gmt'];
% Model.l8.dens  = 4000;
% 
% % % Topo layer
% Model.l9.bound = [HOME '/Data/crust1.bd4.gmt'];
% %Model.l3.dens  = 4200;

% Save model in .mat file for use of the new software

save([HOME '/Data/' Model.name '.mat'],'Model')