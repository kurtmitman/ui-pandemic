% Optimal UI in the Pandemic
% Kurt and Stan
% Matlab Dynare Code

%% This file provides the dynamic equations for the simple model with shutdown
%% All unemployed eligible for UI
%% Search intensity is only margin
%% No firms


close all

% Initialize endogenous and exogenous variables, and params

var L z zeta logzeta b  s w c cp cpp uu uup ue uep uepp expend welfare unemp reprate eb output logb tau;

varexo eps_zeta eps_b;

parameters h chi xi del k bet A rho sigma_z psi_c sigma_c rho_zeta rho_b;


% Assign calibrated values to the parameters


%%%%%%%%% Baseline %%%%%%%%%
rho=0.9895;
sigma_z=0.0034;
bet=0.999162822640879;
k=0.58;
del=0.0081;
sigma_c=1;
tau_adj=0;
chi=0.492;
rho_zeta=0.99;
rho_b = 0;

chi=0.441994028491430;
xi=0.077765818398739;
h=h_val; 0.2; 0.583738591997052;
psi_c=psi_val; 1.911283133102631;
A=A_val; 0.005265199133822;




model;

logb = rho_b*logb(-1)+eps_b;
b    = 0.45*exp(logb);
/* s=exp(logs); */
logzeta = rho_zeta*logzeta(-1)+eps_zeta;
zeta = 2*exp(logzeta)/(1+exp(logzeta));


c = A*((1/(1-s))^(1+psi_c)-1)/(1+psi_c)-A*s;
cp = A*(1/(1-s))^(2+psi_c)-A;
cpp = (2+psi_c)*A/((1-s)^(3+psi_c));
/* cx = A*((1/(1-x))^(1+psi_c)-1)/(1+psi_c)-A*x;
cxp = A*(1/(1-x))^(2+psi_c)-A;
cxpp = (2+psi_c)*A/((1-x)^(3+psi_c));
ux=log(h); */
uu=log(h+b);
uup=1/(h+b);
ue=log(w-exp(tau));
uep=1/(w-exp(tau));
uepp=-1/(w-exp(tau))^2;
/* z = rho*z(-1)+sigma_z*eps; */
z=0;
expend=b*(1-L);

welfare=L*ue+(1-L)*uu-(1/zeta)*(1-L(-1)+del*L(-1))*c+bet*welfare(+1);
unemp=1-L;


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
/* (1-L-mu)*uup=eta*(1-L); */

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
/* lam= ue-uu +eta*(exp(tau)+b) + bet*(1-del)*(c(+1)/(zeta(+1)) + (1-s(+1))*lam(+1)); */

%%%%%
% FOC s, search intensity of eligible unemployed
%%%%%
/* Old timing */
/* cpp*(mu - (1-del-s)*mu(-1))/zeta = (1-L(-1))*(lam - cp/zeta); */

/* New timing, uncomment for Optimal Ramsey policy */
/* cpp*(mu - (1-del)*(1-s)*mu(-1))/zeta = (1-L(-1)+del*L(-1))*(lam - cp/zeta); */

/* For the Markov version, replace with */
/* cpp*mu/zeta = (1-L(-1)+del*L(-1))*(lam - cp/zeta); */


output=exp(z)*L;

%Budget
exp(tau)*L=b*(1-L);

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
  /* mu = Mss; */
  b = bss;
  logb = log(bss);
%  epsilon=epsilonss;
  /* lam = lamss; */
%  thet = thetss;
  s=sss;
%  phi=phiss;
%  w=wss;
  reprate=bss/wss;
%  f=fss;
%  q=qss;
%  fp=fpss;
%  qp=qpss;
  c=css;
  cp=cpss;
  cpp=cppss;
  /* ux=uxss; */
  uu=uuss;
  uup=uupss;
  ue=uess;
  uep=uepss;
  uepp=ueppss;
  tau=-4;
%  D=Dss;
%  nu=nuss;
%  alpha=alphass;
 % x=xss;
%  cx=cxss;
%  cxp=cxpss;
%  cxpp=cxppss;
%  Pi=0.0;
 % z = 0.1;
  /* eps = 0; */
 end;


steady(solve_algo = 2);

tauss=oo_.steady_state(strcmp('tau',M_.endo_names));
