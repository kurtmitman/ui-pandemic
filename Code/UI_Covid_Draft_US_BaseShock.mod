% Optimal UI in the Pandemic
% Kurt and Stan
% Matlab Dynare Code

%% This file provides the dynamic equations for the simple model with shutdown
%% All unemployed eligible for UI
%% Search intensity is only margin
%% No firms


close all

% Initialize endogenous and exogenous variables, and params

var L z zeta logzeta b mu lam s w c cp cpp uu uup ue uep uepp expend welfare unemp reprate eb output del logdel mau dmau cswelfare;

varexo eps_zeta eps eps_del;

parameters h chi xi k bet A rho sigma_z psi_c sigma_c rho_zeta rho_del tau eta ramsey;


% Assign calibrated values to the parameters


%%%%%%%%% Baseline %%%%%%%%%
rho=0.9895;
sigma_z=0.0034;
bet=0.999162822640879;
k=0.58;
/* del=0.0081; */
sigma_c=1;
tau_adj=0;
chi=0.492;
rho_zeta=0.99;
rho_del=0.95;
ramsey = ramseyval;

chi=0.441994028491430;
xi=0.077765818398739;
h=0.2; 0.583738591997052;
psi_c=1.911283133102631;
A=3; 0.005265199133822;


tau = tauss;
eta = eta_ramsey*ramseyval+eta_markov*(1-ramseyval);

model;

logzeta = rho_zeta*logzeta(-1)+eps_zeta;
zeta = 2*exp(logzeta)/(1+exp(logzeta));
logdel = rho_del*logdel(-1)+eps_del;
del = 0.0081*exp(logdel);


c = A*((1/(1-s))^(1+psi_c)-1)/(1+psi_c)-A*s;
cp = A*(1/(1-s))^(2+psi_c)-A;
cpp = (2+psi_c)*A/((1-s)^(3+psi_c));
uu=log(h+b);
uup=1/(h+b);
ue=log(w-exp(tau));
uep=1/w;
uepp=-1/w^2;
z = rho*z(-1)+sigma_z*eps;
expend=b*(1-L);
/* For markov case */
welfare=L*ue+(1-L)*uu-(1/zeta)*(1-L(-1)+del*L(-1))*c+eta*(L*exp(tau)-(1-L)*b)+bet*welfare(+1);
/* cswelfare=L*ue+(1-L)*uu-(1/zeta)*(1-L(-1)+del*L(-1))*c+bet*welfare(+1); */
cswelfare=L*ue+(1-L)*uu-(1/zeta)*(1-L(-1)+del*L(-1))*c;
unemp=1-L;
/* debt = debt(-1)+bet*(L*exp(tau)-(1-L)*b); */
mau = mau(-1)*11/12+unemp/12;
dmau = mau(-1)-mau(-5);


%%%%%%
% Wage equation, change as you want
w = exp(z);
%%%%%%


%%%%%
%Law of motion for employed, denoted L
%%%%%
/* L = (1-del)*L(-1)+s*(1-L(-1)); */
L = (1-del)*L(-1)+s*(1-L(-1)+del*L(-1));

% FOC b
(1-L-mu)*uup=eta*(1-L);

%%%%%
% PK E. Optimal search of eligible unemployed
%%%%%
/* cp/zeta = ue - uu + bet*(c(+1)/zeta(+1) + (1-del-s(+1))*cp(+1)/zeta(+1)); */
cp/zeta = ue - uu + bet*(1-del)*(c(+1)/zeta(+1) + (1-s(+1))*cp(+1)/zeta(+1));

%%%%%
% FOC L
%%%%%
/* Old timing */
/* lam= ue-uu +eta*(exp(tau)+b) + bet*(c(+1)/(zeta(+1)) + (1-del-s(+1))*lam(+1)); */

/* New timing, uncomment for Optimal policy */
lam= ue-uu +eta*(exp(tau)+b) + bet*(1-del)*(c(+1)/(zeta(+1)) + (1-s(+1))*lam(+1));

%%%%%
% FOC s, search intensity of eligible unemployed
%%%%%
/* Old timing */
/* cpp*(mu - (1-del-s)*mu(-1))/zeta = (1-L(-1))*(lam - cp/zeta); */

/* New timing, uncomment for Optimal Ramsey policy */
/* cpp*(mu - (1-del)*(1-s)*mu(-1))/zeta = (1-L(-1)+del*L(-1))*(lam - cp/zeta); */

/* For the Markov version, replace with */
/* cpp*mu/zeta = (1-L(-1)+del*L(-1))*(lam - cp/zeta); */

cpp*(mu - ramsey*(1-del)*(1-s)*mu(-1))/zeta = (1-L(-1)+del*L(-1))*(lam - cp/zeta);

output=exp(z)*L;

%Budget
/* exp(tau)*L=b*(1-L); */

%FOC tau
%L*eta=gam;
%Pi*epsilon=0;

eb=0; %b/(1e-6+epsilon);
reprate=(b+h)/w;
/* dur=1/epsilon; */
%FOC H

end;

% Calculate the Analytic Steady State Values
% Use them to initialize dynare
  Lss=0.942412; %0.95349;
  bss=0.434443; %0.25; %0.47;
  epsilonss=0.022;

%  Lss=0.9;

  Gss=0.9855; %0.98907;
  Mss=-0.0032;
  lamss=2.84;
  thetss=1.425;
  phiss=-0.02121303;
  wss=0.957;
  Delta=0.921477985;

  fss = thetss/(1+thetss^chi)^(1/chi);
  qss = 1/((1+thetss^chi)^(1/chi));

  qpss = -thetss^(chi-1.0)/((1+thetss^chi)^(1/chi+1));
  fpss = qss+thetss*qpss;
    pss=0.1;

  sss=0.50;
  xss=0.72;

  uxss=log(h);
  uxpss=1/(h);
  uuss=log(h+bss);
  uupss=1/(h+bss);
  uess=log(wss);
  uepss=1/wss;
  ueppss=-1/wss^2;
  Dss=.0321916;
  nuss=-0.00119666;
  alphass=lamss;


css = A*((1/(1-sss))^(1+psi_c)-1)/(1+psi_c)-A*sss;
cpss = A*(1/(1-sss))^(2+psi_c)-A;
cppss = (2+psi_c)*A/((1-sss)^(3+psi_c));
cxss = A*((1/(1-xss))^(1+psi_c)-1)/(1+psi_c)-A*xss;
cxpss = A*(1/(1-xss))^(2+psi_c)-A;
cxppss = (2+psi_c)*A/((1-xss)^(3+psi_c));



initval;

 % eta=1.04;
 % tau=-4;
 % gam = Gss;
zeta =1;
logzeta = 0;
  L = Lss;
  mu = Mss;
  b = bss;
  lam = lamss;
  s=sss;
  w=wss;
  reprate=bss/wss;
  c=css;
  cp=cpss;
  cpp=cppss;
  uu=uuss;
  uup=uupss;
  ue=uess;
  uep=uepss;
  uepp=ueppss;
  /* debt=0; */
  /* welfare=-50; */
  /* cswelfare=-50; */
 end;


 shocks;
   var eps = 1;
 end;

 /* shock_path=[-6*(1-rho_zeta)*ones(1,8) 2 -3.4*(1-rho_zeta)*ones(1,8) 0 zeros(1,34+9)]; */
 /* shock_path=[-6*(1-rho_zeta)*ones(1,13) 2 -3.4*(1-rho_zeta)*ones(1,12) 0 zeros(1,34)]; */
 /* shock_path=[-6*(1-rho_zeta)*ones(1,13) 2 -3.4*(1-rho_zeta)*ones(1,12) 0 zeros(1,34)]; */

 /* shock_path=[zeros(4,1) -10*ones(1,84) 10]; */

/* shock_path=[-6*(1-rho_zeta)*ones(1,8) 4 zeros(1,52)]; */
/* shock_path=[0 6 zeros(1,59)]; */
/* del_path=[0.1 0.2 0.3 0.4 1 0 0]; */
 steady(solve_algo = 2);

 Lss=oo_.steady_state(strcmp('L',M_.endo_names));
 bss=oo_.steady_state(strcmp('b',M_.endo_names));
  initval;
   L=L0;
   zeta = zeta0;
   logzeta=log(zeta0);
 end;
 endval;
   L=Lss;
   zeta = 1;
   logzeta=0;
  end;



 shocks;
 var eps_zeta;
 periods 0:60;
 values (shock_path);
 var eps_del;
 periods 0:6;
 values (del_path);
 end;

 perfect_foresight_setup(periods=5000);
 perfect_foresight_solver;
