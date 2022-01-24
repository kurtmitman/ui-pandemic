
Zmonth = weektomonth([ones(12,1);zeta(1:end-1)]);
Dmonth = weektomonth([0.0081*ones(12,1);del(1:end-1)]);

figsetup
plot(-3:xmax,100*(Zmonth-1));xlim([-2 24]);
title('\zeta');grid on;xlabel('Months');ylabel('Percent change')
% ylim([-20 0]);
FigName = 'Zeta';

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')

close all;

figsetup
plot(-3:xmax,100*(Dmonth/0.0081-1));xlim([-2 24]);
title('\delta');grid on;xlabel('Months');ylabel('Percent change')
% ylim([-20 0]);
FigName = 'Delta';

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')
