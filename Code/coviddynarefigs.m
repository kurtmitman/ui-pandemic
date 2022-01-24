unempss = 1-Lss;
Lmonth = weektomonth([ones(12,1)*Lss;L(1:end-1)]);
bmonth = weektomonth([ones(11,1)*bss;b]);
umonth = weektomonth([ones(11,1)*unempss;unemp]);
taumonth = weektomonth([ones(11,1)*exp(tauss);exp(tau)]);
% dmonth = weektomonth([ones(11,1)*0.0081;del])*4;

xnum=length(Lmonth);
xmax=xnum-4;

figsetup
plot(-3:xmax,100*(Lmonth./Lss-1));xlim([-2 48]);
title('Employment');grid on;xlabel('Months');ylabel('Percent change')
ylim([-25 0]);
FigName = 'Emp';

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')


figsetup
plot(-3:xmax,100*(bmonth./bss-1));xlim([-2 48]);
title('Replacement Rate');grid on;xlabel('Months');ylabel('Percent change')
% ylim([0 -0.25]);
FigName = 'B';

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')

figsetup
plot(-3:xmax,bmonth);xlim([-2 48]);
title('Replacement Rate');grid on;xlabel('Months');
% ylim([0 -0.25]);
FigName = 'Blev';

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')


figsetup
plot(-3:xmax,umonth*100);xlim([-2 48]);
title('Unemployment Rate');grid on;xlabel('Months');ylabel('Rate')
% ylim([0 -0.25]);
FigName = 'U';

print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')

if(length(tau)>1)
    figsetup
    plot(-3:xmax,taumonth*100);xlim([-2 48]);
    title('Tax Rate');grid on;xlabel('Months');ylabel('Rate')
    % ylim([0 -0.25]);
    FigName = 'Tau';

    print(figure1,'-dpdf',[SaveDir SaveName FigName '.pdf'],'-fillpage')
    print(figure1,'-depsc2',[SaveDir SaveName FigName '.eps'],'-loose')
end