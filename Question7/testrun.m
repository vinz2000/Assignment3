load dV_thinshell
load dV_infiniteplate
load dv_obs
load dV_airynocorr
load dV_airycornotopt
load dV_bouguer
aa=18;
figure
%nV=(1:81);
loglog(nV(3:81), dV_obs(3:81), "*"); hold on;
loglog(nV(3:81), dV_airyrealip(3:81), "*"); hold on;
loglog(nV(3:81), dV_airythinshell(3:81), "*"); hold on;
loglog(nV(3:81), dV_airycornotopt(3:81), "*"); hold on;
ylabel('Degree Variance [-]', 'Fontsize',aa)
xlabel('Spherical Harmonics Degree [-]','Fontsize',aa)
legend('Observed','Airy corrected with IP', 'Airy corrected with TS','Airy corrected but not opt.', 'FontSize', 11)
title('Comparison of the degree variance, zoom in (3-50)', 'FontSize',aa)

%%%%%%%%%%
aa=18;
figure
nV=(1:81);
loglog(nV(3:81), dV_obs(3:81), "*"); hold on;
loglog(nV(3:81), dV_airyrealip(3:81), "*"); hold on;
loglog(nV(3:81), dV_airythinshell(3:81), "*"); hold on;
loglog(nV(3:81), dV_bouguer(3:81), "*"); hold on;
loglog(nV(3:81), dV_airynocorr(3:81), "*"); hold on;
loglog(nV(3:81), dV_airycornotopt(3:81), "*"); hold on;

ylabel('Degree Variance [-]', 'Fontsize',aa)
xlabel('Spherical Harmonics Degree [-]','Fontsize',aa)
legend('Observed','Airy corrected with IP', 'Airy corrected with TS','Bouguer','Airy','Airy non opt but corr' )