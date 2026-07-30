function rebreplots(fig, lgd, lbl, opts)
    % Reformat a plot
    % rebreplots(fig, lgd, xlbl=xlbl,ylbl=ylbl,title=title)
    % UNNAMED ENTRIES (should be in order)
    % fig = sfigure that is already plotted
    %
    % lgd = legend entries, cell array
    %
    % NAMED ENTRIES (must be labeled)
    % xlbl, ylbl = string for x and y labels, 
    % title = string for figure title
    % fontSize (12), fontName (Arial)
    % LineStyle (-), LineWidth (1)
    % interpreter (latex)
    %
    % REBECCA SHANNON 
    % 10/6/2025

arguments
    fig
    lgd
    lbl.ylbl (1,1) string = ''
    lbl.xlbl (1,1) string = ''
    lbl.title string = ''
    lbl.fontSize (1,1) {mustBeNumeric} = 12
    lbl.interpreter (1,1) string = 'latex'
    lbl.fontName (1,1) string = 'Arial'
    opts.LineStyle (1,1) string = '-'
    opts.LineWidth (1,1) {mustBeNumeric} = 1.5
    opts.wide (1,1) {mustBeNumeric} = 900
    opts.tall (1,1) {mustBeNumeric} = 600

end


lines = findobj(fig,'Type','Line');

for i = 1:numel(lines)


    lines(i).LineWidth = opts.LineWidth;
    lines(i).LineStyle = opts.LineStyle;

end

grid on
legend(lgd,'FontSize',lbl.fontSize,'FontName',lbl.fontName)
ylabel(lbl.ylbl,'FontSize',lbl.fontSize,'FontName',lbl.fontName,'Interpreter',lbl.interpreter)
xlabel(lbl.xlbl,'FontSize',lbl.fontSize,'FontName',lbl.fontName,'Interpreter',lbl.interpreter)
title(lbl.title)

ax = gca;
ax.FontSize = floor(lbl.fontSize);
ax.FontName = lbl.fontName;
ax.TickLabelInterpreter = lbl.interpreter;

set(fig,'Position',[100, -100, opts.wide, opts.tall]); % Adjust figure size
set(fig, 'Color', 'w'); % Set background color to white