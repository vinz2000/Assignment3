clear all
load dV_airycorrected
load dv_obs
nV=(1:80);
aa=18;
figure
loglog(nV, dV_obs7, "*"); hold on;
loglog(nV, dV_airycorrected7, "*"); hold on;
ylabel('Degree Variance [-]', 'Fontsize',aa)
xlabel('Spherical Harmonics Degree [-]','Fontsize',aa)
legend('observed', 'airycorrected')

