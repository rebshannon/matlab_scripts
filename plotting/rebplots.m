function rebplots(dat, lgd, lbl, opts)
    % Plot and format line plots 
    % rebplots(dat, lgd, xlbl=xlbl,ylbl=ylbl,title=title)
    % UNNAMED ENTRIES (should be in order)
    % dat = structure with the (x,y) data to be plotted
            % structure fields should be x,y
            % add new row(?) for each series to be plotted
    % lgd = legend entries, cell array
    %
    % NAMED ENTRIES (must be labeled)
    % xlbl, ylbl = string for x and y labels, 
    % title = string for figure title
    % fontSize (12), fontName (Arial)
    % LineStyle (-), LineWidth (1)
    %
    % REBECCA SHANNON 
    % 4/1/2025

arguments
    dat struct
    lgd
    lbl.ylbl (1,1) string = ''
    lbl.xlbl (1,1) string = ''
    lbl.title string = ''
    lbl.fontSize (1,1) {mustBeNumeric} = 17
    lbl.interpreter (1,1) string = 'latex'
    lbl.fontName (1,1) string = 'Helvetica'
    opts.LineStyle (1,1) string = '-'
    opts.LineWidth (1,1) {mustBeNumeric} = 1.5
    opts.wide (1,1) {mustBeNumeric} = 900
    opts.tall (1,1) {mustBeNumeric} = 600
    %opts.colorOrder 

end

numSeries = size(dat,2);

figure
hold on

for i = 1:numSeries

    plot(dat(i).x,dat(i).y,'LineWidth',opts.LineWidth,'LineStyle',opts.LineStyle);

end

grid on
legend(lgd,'FontSize',lbl.fontSize,'FontName',lbl.fontName)
ylabel(lbl.ylbl,'FontSize',lbl.fontSize,'FontName',lbl.fontName,'Interpreter',lbl.interpreter)
xlabel(lbl.xlbl,'FontSize',lbl.fontSize,'FontName',lbl.fontName,'Interpreter',lbl.interpreter)
title(lbl.title)

ax = gca;
ax.FontSize = floor(lbl.fontSize);
ax.FontName = lbl.fontName;


set(gcf, 'Position', [100, -100, opts.wide, opts.tall]); % Adjust figure size
set(gcf, 'Color', 'w'); % Set background color to white


% set(sub,'Position',[2886 425 200 190])
% set(sub,'Position',[2886 425 220 200])
% ax=gca;
% ax.TickLabelInterpreter='latex';
% ax.FontSize=11;