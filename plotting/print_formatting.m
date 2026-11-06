%% REBECCA SHANNON
% 10/27/26

% formatting a plot
% make figure as h
% plot desired data

%% Single Column


% constants
width = 3.34; % both in inches
height = 2.07;
fontScale = 9;

grid on
ylabel('\Phi_{equator}')
xlabel('\tau = t/t_c')


% text formatting
set(gca,'FontSize',fontScale);
set(gca,'FontName','nimbus roman')

% scaling
h.Units = "inches";
h.Position = [2 3 width height];

% whitespace
set(gca,'LooseInset',max(get(gca,'TightInset'),0.007))

%% annotate
% b = annotation('textbox',String='(a) Equator');
% b.FontName = 'nimbus romam';
% b.FontSize = fontScale;
% b.LineStyle = 'none';
% b.HorizontalAlignment='center';
% b.VerticalAlignment='bottom';
% b.Position = [0 0 1 0.1];
% 
% % move axis up so it doesn't cover the text
% a = gca;
% a.Position(2) = a.Position(2) + 0.075;
% a.Units = 'inches';
% 
% % extend figure to cover axes
% h.Units = 'points';
% h.Position(4) = h.Position(4) + 0.075*h.Position(4);

%% inset axis

axes('Position',[0.25 0.25 0.35 0.3])
inax = gca;

