figure
t = tiledlayout('flow');

% nexttile
% plot(argon_M24_D10.actualTime,argon_M24_D10.height/argon_M24_D10.height(1),'LineWidth',1.5)
% hold on
% plot(air_M13_D5.actualTime,air_M13_D5.height/air_M13_D5.height(1),'LineWidth',1.5)
% plot(air_M24_D10.actualTime,air_M24_D10.height/air_M24_D10.height(1),'LineWidth',1.5)
% plot(air_M24_D22.actualTime,air_M24_D22.height/air_M24_D22.height(1),'LineWidth',1.5)
% plot(air_M5_D22.actualTime,air_M5_D22.height/air_M5_D22.height(1),'LineWidth',1.5)
% 
% grid on
% xlim([0 13e-4])
% xlabel('Time, s')
% 
% nexttile
plot(argon_M24_D10.tau2,argon_M24_D10.height/argon_M24_D10.height(1),'LineWidth',1.5)
hold on
plot(air_M13_D5.tau2,air_M13_D5.height/air_M13_D5.height(1),'LineWidth',1.5)
plot(air_M24_D10.tau2,air_M24_D10.height/air_M24_D10.height(1),'LineWidth',1.5)
plot(air_M24_D22.tau2,air_M24_D22.height/air_M24_D22.height(1),'LineWidth',1.5)
plot(air_M5_D22.tau2,air_M5_D22.height/air_M5_D22.height(1),'LineWidth',1.5)


nexttile
plot(argon_M24_D10.actualTime,argon_M24_D10.horizDiam/argon_M24_D10.horizDiam(1),'LineWidth',1.5)
hold on
plot(air_M13_D5.actualTime,air_M13_D5.horizDiam/air_M13_D5.horizDiam(1),'LineWidth',1.5)
plot(air_M24_D10.actualTime,air_M24_D10.horizDiam/air_M24_D10.horizDiam(1),'LineWidth',1.5)
plot(air_M24_D22.actualTime,air_M24_D22.horizDiam/air_M24_D22.horizDiam(1),'LineWidth',1.5)
plot(air_M5_D22.actualTime,air_M5_D22.horizDiam/air_M5_D22.horizDiam(1),'LineWidth',1.5)

grid on
xlim([0 13e-4])
xlabel('Time, s')

nexttile
plot(argon_M24_D10.tau,argon_M24_D10.horizDiam/argon_M24_D10.horizDiam(1),'LineWidth',1.5)
hold on
plot(air_M13_D5.tau,air_M13_D5.horizDiam/air_M13_D5.horizDiam(1),'LineWidth',1.5)
plot(air_M24_D10.tau,air_M24_D10.horizDiam/air_M24_D10.horizDiam(1),'LineWidth',1.5)
plot(air_M24_D22.tau,air_M24_D22.horizDiam/air_M24_D22.horizDiam(1),'LineWidth',1.5)
plot(air_M5_D22.tau,air_M5_D22.horizDiam/air_M5_D22.horizDiam(1),'LineWidth',1.5)


grid on
xlim([0 1.1])
xlabel('Dimensionless Time, t/tc')


title(t,'Minor Axis Parameter Study')
ylabel(t,'Normalized X Length, x/x0')
t.TileSpacing='compact';

leg = {'argon, M2.4, D10mm','air, M1.3, D5mm','air, M2.4, D10mm','air, M2.4, D22mm','air, M5, D22mm'};
lg=legend(leg);
lg.Layout.Tile = 'south';
lg.Orientation='horizontal';
lg.NumColumns=3;
lg.FontSize=10;


allCases = [argon_M24_D10;air_M13_D5;air_M24_D10;air_M24_D22;air_M5_D22];
figure
for i = 1:5

    stdDev = std(allCases(i).height/allCases(i).height(1));
    upperCurve = allCases(i).height/allCases(i).height(1) + stdDev;
    lowerCurve = allCases(i).height/allCases(i).height(1) - stdDev;

    patch([allCases(i).tau;flip(allCases(i).tau)],[upperCurve;flip(lowerCurve)],"blue",'edgecolor','none')
    hold on

    alpha 0.1
    plot(allCases(i).tau, allCases(i).height/allCases(i).height(1),'b')
end



%upper = 

plot(argon_M24_D10.tau,argon_M24_D10.height/argon_M24_D10.height(1),'LineWidth',1.5)
plot(air_M13_D5.tau,air_M13_D5.height/air_M13_D5.height(1),'LineWidth',1.5)
plot(air_M24_D10.tau,air_M24_D10.height/air_M24_D10.height(1),'LineWidth',1.5)
plot(air_M24_D22.tau,air_M24_D22.height/air_M24_D22.height(1),'LineWidth',1.5)
plot(air_M5_D22.tau,air_M5_D22.height/air_M5_D22.height(1),'LineWidth',1.5)