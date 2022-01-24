%%
addpath /Applications/Dynare/4.6.1/matlab/
set(0,'DefaultLineLineWidth',5)
CodeDir = pwd;
SaveDir = pwd;
%% First, let's do steady state optimal policy
% here we calculate the optimal tax and eta
A_val=3;
h_val=0.2;
psi_val=1.911283133102631;

% Get steady state tax rate
dynare UI_Covid_Draft_US

ramseyval=1;
% Get steady state tax rate
dynare UI_Covid_Draft_US_Steady

eta_ramsey=eta_ss;
b_ramsey=b_ss;
mu_ramsey=mu_ss;


ramseyval=0;
% Get steady state tax rate
dynare UI_Covid_Draft_US_Steady

eta_markov=eta_ss;
b_markov=b_ss;
mu_markov=mu_ss;


%%
% Persistent delta shock, i.e. change eps_del0
shock_path=[0 -6 -6*(1-rho_zeta)*ones(1,8) log(0.15)-rho_zeta*-6  log(0.15)*(1-rho_zeta)*ones(1,50)];
del_path=[0 0.05 0.1 2 0 0 -1.5]/2.5;
L0=Lss;
zeta0=1;
logzeta0=0;

%%
% Ramsey optimal policy
ramseyval=1;
dynare UI_Covid_Draft_US_BaseShock
close all;
SaveName = 'Ramsey_Base';
coviddynarefigs
U_Ramsey=umonth;
b_Ramsey=bmonth;
W_Ramsey=welfare(2);
% W2_Ramsey=cswelfare(2);
disc=(bet.^(0:length(cswelfare)-1))';
W2_Ramsey=sum(disc.*cswelfare);
D_Ramsey=sum((L*exp(tau)-(1-L).*b));
xxx=regress(b,[ones(length(unemp),1) unemp-unempss]);
bu_coef=xxx(2);
xxx=regress(b,[ones(length(unemp),1) dmau]);
bdu_coef=xxx(2);

%%
% Markov optimal policy
ramseyval=0;
dynare UI_Covid_Draft_US_BaseShock
close all;
SaveName = 'Markov_Base';
coviddynarefigs
U_Markov=umonth;
b_Markov=bmonth;
W_Markov=welfare(2);
W2_Markov=sum(disc.*cswelfare);
D_Markov=sum((L*exp(tau)-(1-L).*b));

%%
bu_pol_val=0;
bdu_pol_val=0;
dynare UI_Covid_Draft_US_Policies
close all;
SaveName = 'ConstB_Base';
coviddynarefigs
U_Const=umonth;
b_Const=bmonth;
W_Const=welfare(2);
W2_Const=sum(disc.*cswelfare);
D_Const=sum((L*exp(tau)-(1-L).*b));

%%
SaveName = 'Compare_Base_';
comparepolicies

%%
SaveName = 'Shock_Base';
coviddynareshocksfigs
%%
bu_pol_val=bu_coef;
bdu_pol_val=0;
dynare UI_Covid_Draft_US_Policies
close all;
SaveName = 'BfU_Base';
coviddynarefigs
U_BfU = umonth;
b_BfU = bmonth;
%%
bu_pol_val=0;
bdu_pol_val=bdu_coef; 
dynare UI_Covid_Draft_US_Policies
close all;
SaveName = 'BfdU_Base';
coviddynarefigs
U_BfdU = umonth;
b_BfdU = bmonth;

%%
xnum=length(Lmonth);
xmax=xnum-4;
SaveName = 'CompareImplement_';
close all
figsetup
plot1=plot(-3:xmax,[U_Ramsey U_BfU U_BfdU]*100);xlim([-2 24]);
title('Unemployment Rate');grid on;xlabel('Months');ylabel('Rate')
set(plot1(1),'DisplayName','Ramsey');
set(plot1(2),'DisplayName','b(U) policy','LineStyle','--');
set(plot1(3),'DisplayName','b(\Delta U) policy','LineStyle','-.');
FigName = 'UPolicies';
legend(axes1,'show');

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')



figsetup
plot1=plot(-3:xmax,[b_Ramsey b_BfU b_BfdU]);xlim([-2 24]);
title('Replacement Rate');grid on;xlabel('Months');
set(plot1(1),'DisplayName','Ramsey');
set(plot1(2),'DisplayName','b(U) policy','LineStyle','--');
set(plot1(3),'DisplayName','b(\Delta U) policy','LineStyle','-.');
FigName = 'BPolicies';
legend(axes1,'show');

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')









