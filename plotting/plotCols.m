function plotCols(DATA,scales,opts)
% Plot data in a n by 2 array where the first column is the x axis
%       and the second column is the y axis
%  DATA: a 2 column vector that you want to plot
%           column 1 will be the x axis
%           column 2 will be the y axis
%  x, y = scales, specify 'log', 'linear' or leave blank
%           will default to linear-linear
%
%  REBECCA SHANNON 
%  9/25/24, updated 4/1/2025
    
arguments
    DATA double
    scales.xscl string = 'linear'
    scales.yscl string = 'linear'
    opts.LineWidth (1,1) {mustBeNumeric} = 1
end

 
if isequal(scales.xscl,'linear') &&  isequal(scales.yscl,'linear')
    plot(DATA(:,1),DATA(:,2),'LineWidth',opts.LineWidth)

elseif isequal(scales.xscl,'log') &&  isequal(scales.yscl,'linear')
    semilogx(DATA(:,1),DATA(:,2),'LineWidth',opts.LineWidth)

elseif isequal(scales.xscl,'linear') &&  isequal(scales.yscl,'log')
    semilogy(DATA(:,1),DATA(:,2),'LineWidth',opts.LineWidth)

elseif isequal(scales.xscl,'log') &&  isequal(scales.yscl,'log')
    loglog(DATA(:,1),DATA(:,2),'LineWidth',opts.LineWidth)

else
    sprintf('****** INVALID INPUT ******\n x and y must be "linear" or "log"\n Both will default to "linear" if empty""')

end
    



