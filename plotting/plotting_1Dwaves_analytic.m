%% REBECCA SHANNON
%% 2/24/25 - plotting analytic solutions

% For the p_inc = 500
% plot at 1mm upstream of interface
% interface is at x = 1mm
% plot from probes

fileLocation= ['/projectnb/turbomac/REBECCA/negP/analyticSolns/oscilInletBC' ...
    '/waveTracking/oneWave_PTFoam/oneWave_waterToAir/postProcessing/probeDat/0/p'];

axisFont = 14;

p = readmatrix(fileLocation);

figure
plot(p(:,1),p(:,2)-1e5,'LineWidth',1.5,'Color',"#56B4E9")
grid on

set(gca,'FontSize',axisFont)
title({'Water to Air Interface for p_{inc} = 5e5Pa','Pressure 1mm Upstream of Interface'})

xlabel('Time, s','FontWeight','bold')
xlim([0 5e-6])

ylabel('Pressure, Pa','FontWeight','bold')
set(gca,"YTick",[-5e5:1e5:5e5])
ylim([-5e5 5e5])


% figure size and background
set(gcf, 'Position', [100, 100, 800, 600]); % Adjust figure size
set(gcf, 'Color', 'w'); % Set background color to white