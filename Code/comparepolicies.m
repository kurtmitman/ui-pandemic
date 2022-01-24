%%
xnum=length(Lmonth);
xmax=xnum-4;
close all
figsetup
plot1=plot(-3:xmax,[U_Ramsey U_Markov U_Const]*100);xlim([-2 24]);
title('Unemployment Rate');grid on;xlabel('Months');ylabel('Rate')
set(plot1(1),'DisplayName','Ramsey');
set(plot1(2),'DisplayName','Markov','LineStyle','--');
set(plot1(3),'DisplayName','Constant b','LineStyle','-.');
legend(axes1,'show');

FigName = 'UPolicies';
print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')

figsetup
plot1=plot(-3:xmax,[b_Ramsey b_Markov b_Const]);xlim([-2 24]);
title('Replacement Rate');grid on;xlabel('Months');
set(plot1(1),'DisplayName','Ramsey');
set(plot1(2),'DisplayName','Markov','LineStyle','--');
set(plot1(3),'DisplayName','Constant b','LineStyle','-.');
legend(axes1,'show');

FigName = 'BPolicies';
print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')