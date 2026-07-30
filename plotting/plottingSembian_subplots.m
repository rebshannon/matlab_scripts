%% REBECCA SHANNON
%% 2/24/25 - Plotting for Sembian cases comparison
% plots in MPa

% import mat files
addpath '/projectnb/turbomac/REBECCA/negP/2Dcases/sembMeshDensity'
addpath '/projectnb/turbomac/REBECCA/negP/2Dcases/sembMeshDensity/sembCase_400cells_PTFoam/'
addpath '/projectnb/turbomac/REBECCA/negP/2Dcases/sembMeshDensity/dod_postProcDat/probeDat/0/'
load sembPaperData.mat
load sembMeshDensity.mat
load 400cells_PTFoam_avg.mat


figure;
t = tiledlayout(3,1)
t.TileSpacing = 'none' 
t.Padding = 'compact'

w = 1.5;
labelFont = 14;
axisFont = 12;

% probe 1
nexttile;
plot(probe1exp(:,1)*1e-6 - 3.34057e-5, probe1exp(:,2) ,'--','LineWidth', w,'color',"#56B4E9");
hold on
plot(probe1sim(:,1)*1e-6 - 3.34057e-5, probe1sim(:,2) ,'LineWidth', w,'color',"#56B4E9");
plot(probe1Avg_400cells.time-190e-6,probe1Avg_400cells.p*1e-5,'LineWidth', w,'color',"#D55E00");
%plot(probe_400cells_PTFoam(1).time-193e-6,probe_400cells_PTFoam(1).p*1e-6,'LineWidth',w,'color',"#E69F00")
ylabel('Probe 1');
title('OpenFOAM Validation with Sembian et al.','FontSize',labelFont);
set(gca, 'XTickLabel', []); % Remove x-axis labels for top subplot
set(gca,'FontSize',axisFont)
grid on; % Add gridlines
xlim([-5e-6 90e-6])

% probe 2
nexttile;
plot(probe2exp(:,1)*1e-6 - 3.34057e-5, probe2exp(:,2)*0.1 , '--','LineWidth', w,'Color',"#56B4E9");
hold on
plot(probe2sim(:,1)*1e-6 - 3.34057e-5, probe2sim(:,2)*0.1 ,'LineWidth', w,'color',"#56B4E9");
plot(probe2Avg_400cells.time-187e-6,probe2Avg_400cells.p*1e-6,'LineWidth', w,'color',"#D55E00");
%plot(probe_400cells_PTFoam(2).time-189e-6,probe_400cells_PTFoam(2).p*1e-6,'LineWidth',w,'color',"#E69F00")
ylabel('Probe 2');
set(gca, 'XTickLabel', []); % Remove x-axis labels for top subplot
grid on; % Add gridlines
set(gca,'FontSize',axisFont)
xlim([-5e-6 100e-6])

% probe 4
nexttile;
plot(probe3exp(:,1)*1e-6 - 3.34057e-5, probe3exp(:,2)*0.1 , '--','LineWidth', w,'color',"#56B4E9");
hold on
plot(probe3sim(:,1)*1e-6 - 3.34057e-5, probe3sim(:,2)*0.1 ,'-','LineWidth', w,'color',"#56B4E9");
plot(probe3Avg_400cells.time-184e-6,probe3Avg_400cells.p*1e-6,'LineWidth', w,'color',"#D55E00");
%plot(probe_400cells_PTFoam(3).time-184e-6,probe_400cells_PTFoam(3).p*1e-6,'LineWidth',w,'color',"#E69F00")
ylabel('Probe 3')
grid on; % Add gridlines
set(gca,'FontSize',axisFont)
xlim([-5e-6 100e-6])
xlabel('Time, s','FontWeight','bold')

% legend
legend_labels = {'Sembian Exp.', 'Sembian Sim.', 'OpenFOAM Avg'};%,'OpenFOAM Inst.'};%, 'Curve 4'};
lgd = legend(legend_labels, 'Orientation', 'horizontal', 'NumColumns', 3,'FontSize',12);
lgd.Layout.Tile = 'south'; % Place legend below the plots

ylabel(t,'Pressure, MPa','fontsize',axisFont,'FontWeight','bold')
% figure size and background
set(gcf, 'Position', [100, 100, 800, 600]); % Adjust figure size
set(gcf, 'Color', 'w'); % Set background color to white