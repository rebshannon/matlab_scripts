var = 'perim';
time = linspace(0,1.1,101);
time2 = linspace(0,1.216,181);
colorList = {'#1b9e77','#d95f02','#7570b3'};


%% nondim bubble case

% figure
% hold on
% 
% plot(time(1:84),of_shock_diam(2).(var)/of_shock_diam(2).(var)(1))
% plot(time,weno_200cells_diam(2).(var)/weno_200cells_diam(2).(var)(1))
% plot(time(1:85),muscl_200cells_diam(2).(var)/muscl_200cells_diam(2).(var)(1))
% plot(time(1:100),of_cavSym_diam(4).(var)/of_cavSym_diam(4).(var)(1))
% plot(time2(1:181),of_cavSym_diam(2).(var)(1:181)/of_cavSym_diam(2).(var)(1))
% 
% title(strcat(var,' - B50 P8'))
% grid on
% xlabel('time, t/t_c')
% ylabel('length, r/r_0')
% legend('of shock','weno','muscl','cavSym','cavSym 500')
% 
% 
%% nondim no bubble case
hfig = figure;

hold on


plot(time(1:84),of_shock_diam(1).(var)/of_shock_diam(1).(var)(1),'LineWidth',2,'Color',colorList{1},'DisplayName','OF Modified')
plot(time,weno_200cells_diam(1).(var)/weno_200cells_diam(1).(var)(1),'LineWidth',2,'Color',colorList{2},'DisplayName','OF Modified')
plot(time(1:96),muscl_200cells_diam(1).(var)/muscl_200cells_diam(1).(var)(1),'LineWidth',2,'Color',colorList{3},'DisplayName','OF Modified')
%plot(time(1:100),of_cavSym_diam(3).(var)/of_cavSym_diam(3).(var)(1))
%plot(time2(1:181),of_cavSym_diam(1).(var)(1:181)/of_cavSym_diam(1).(var)(1))

%title(strcat(var,' no bubble'))
grid on
xlabel('time, t/t_c')
ylabel('length, r/r_0')
legend('OF Modified','MFC WENO','MFC MUSCL','location','northwest') %,'cavSym','cavSym 500')

fname = 'myfigure';
picturewidth = 20; % set this parameter and keep it forever
hw_ratio = 0.65; % feel free to play with this ratio
set(findall(hfig,'-property','FontSize'),'FontSize',17) % adjust fontsize to your document
%set(findall(hfig,'-property','Box'),'Box','off') % optional
set(findall(hfig,'-property','Interpreter'),'Interpreter','latex') 
set(findall(hfig,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
set(hfig,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
pos = get(hfig,'Position');
set(hfig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
%print(hfig,fname,'-dpdf','-painters','-fillpage')
print(hfig,fname,'-dpng','-painters')

set(gcf,'PaperUnits','inches','PaperPosition',[0,0,5,5])



%% pct diff from no bubble
figure
hold on


plot(time(1:84),(of_shock_diam(2).(var) - of_shock_diam(1).(var))./of_shock_diam(1).(var))
plot(time,(weno_200cells_diam(2).(var)-weno_200cells_diam(1).(var))./weno_200cells_diam(1).(var))
plot(time(1:85),(muscl_200cells_diam(2).(var)-muscl_200cells_diam(1).(var)(1:85))./muscl_200cells_diam(1).(var)(1:85))
plot(time(1:100),(of_cavSym_diam(4).(var)-of_cavSym_diam(3).(var))./of_cavSym_diam(3).(var))
plot(time2(1:181),(of_cavSym_diam(2).(var)(1:181)-of_cavSym_diam(1).(var)(1:181))./of_cavSym_diam(1).(var)(1:181))

title(strcat(var,' - pct difference for B50 P8'))
grid on
xlabel('time, t/t_c')
ylabel('pct difference')
legend('of shock','weno','muscl','cavSym','cavSym 500')

%% mag of pct diff from no bubble

figure
hold on


plot(time(1:84),abs(of_shock_diam(2).(var) - of_shock_diam(1).(var))./of_shock_diam(1).(var))
plot(time,abs(weno_200cells_diam(2).(var)-weno_200cells_diam(1).(var))./weno_200cells_diam(1).(var))
plot(time(1:85),abs(muscl_200cells_diam(2).(var)-muscl_200cells_diam(1).(var)(1:85))./muscl_200cells_diam(1).(var)(1:85))
plot(time(1:100),abs(of_cavSym_diam(4).(var)-of_cavSym_diam(3).(var))./of_cavSym_diam(3).(var))
plot(time2(1:181),abs(of_cavSym_diam(2).(var)(1:181)-of_cavSym_diam(1).(var)(1:181))./of_cavSym_diam(1).(var)(1:181))

title(strcat(var,' - pct difference for B50 P8'))
grid on
xlabel('time, t/t_c')
ylabel('pct difference')
legend('of shock','weno','muscl','cavSym','cavSym 500')


%% diff from no bubble (for leading edge)

figure
hold on


plot(time(1:84),(of_shock_diam(2).(var) - of_shock_diam(1).(var)))
plot(time,(weno_200cells_diam(2).(var)-weno_200cells_diam(1).(var)))
plot(time(1:85),(muscl_200cells_diam(2).(var)-muscl_200cells_diam(1).(var)(1:85)))
plot(time(1:100),(of_cavSym_diam(4).(var)-of_cavSym_diam(3).(var)))
plot(time2(1:181),(of_cavSym_diam(2).(var)(1:181)-of_cavSym_diam(1).(var)(1:181)))

title(strcat(var,' - difference for B50 P8'))
grid on
xlabel('time, t/t_c')
ylabel('difference')
legend('of shock','weno','muscl','cavSym','cavSym 500')
