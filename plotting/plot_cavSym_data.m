% REBECCA SHANNON
% plot data from cavSym paper

load("/projectnb/aeracous/REBECCA/DOD_CAVSYM/diameterStats.mat")
addpath("/projectnb/turbomac/REBECCA/matlab/")

bubbleOrder = [1,4,7,5,6,3,2];
lgd = {'Control','p_{lo}, d = 0.3','p_{lo}, d = 0.5','p_{lo}, d = 0.8','p_{hi}, d = 0.3','p_{hi}, d = 0.5','p_{hi}, d = 0.8'};
varList = {'vertical','centOfMass'};
time = 1e-6:1e-6:400e-6;

xlbl = 'Time, s';

for varID = 1:length(varList)
    var = varList{varID};

    % plot complete data set
    for BID = 1:7
        bubble = bubbleOrder(BID);
        dat(BID).x = time;
        dat(BID).y = diameterData(bubble).(var)/diameterData(bubble).(var)(1);
    end

    rebplots(dat,lgd,ylbl=strcat(var,' diameter, m'),xlbl=xlbl)
    colororder(full_colorPalette)
    clear dat

    % plot percent difference
    for BID = 2:7
        bubble = bubbleOrder(BID);
        dat(BID).x = time;
        dat(BID).y = (diameterData(bubble).(var)-diameterData(1).(var))./diameterData(1).(var);
    end

    rebplots(dat,lgd(2:end),ylbl=strcat('percent difference in ',var,' diameter'),xlbl=xlbl)
    colororder(pctDiff_colorPalette)
    
end
