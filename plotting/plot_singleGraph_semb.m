%% Rebecca Shannon
% 7/14/25
% plot data from singleGraph - single point over time
% DOD 2D/3D semb cases
% Need to set dataFile, location, plotOpts and US
% In plotting loops, which cases to be plotted can be chosen
% Currently plotOpts for both 2D and axisym doesn't work

clear
clc

%% Select and load data

addpath('/projectnb/turbomac/REBECCA/matlab/')

dataFile = 'semb_2D_3D_singleGraph.mat';
cd '/projectnb/aeracous/REBECCA/blastAMRcases/originalTests/'
load(dataFile)

% WHICH PLOTS
% 0 = don't plot
% 1 = plot
% [2D, axisymmetric, both]
plotOpts = [0 1 0];

% UPSTREAM OR DOWNSTREAM
% US = 1 is upstream
% US = 0 is downstream
US = 1;


%% Set options

if US == 1
   xInd = 236;
   xPos = 0.006;
   xRel = 'US';
else
   xInd = 264;
   xPos = 0.008;
   xRel = 'DS';
end

%% 2D
if plotOpts(1) == 1

    loop = 1;

    for i = [1 3 6]
        
        data(loop).x = semb2D_singleGraph(i).time;
        data(loop).y = semb2D_singleGraph(i).p(:,xInd);
        leg{loop} = semb2D_singleGraph(i).name;
        loop = loop + 1;
    
    end
    
    xlbl = 'Time, s';
    ylbl = 'Pressure, Pa';
    title = {'Sembian 2D Cases',sprintf('Probe at (%0.3f, 0, 0), %s of bubble',xPos, xRel)};
    LineStyle = '-';
    
    rebplots(data,leg,ylbl=ylbl,xlbl=xlbl,title=title,LineStyle=LineStyle)
end



% AXISYMMETRIC

if plotOpts(2) == 1

    loop = 1;

    for i = [1 3 6]
        
        data(loop).x = sembAxisym_singleGraph(i).time;
        data(loop).y = sembAxisym_singleGraph(i).p(:,xInd);
        leg{loop} = sembAxisym_singleGraph(i).name;
        loop = loop + 1;
    
    end
    
    xlbl = 'Time, s';
    ylbl = 'Pressure, Pa';
    title = {'Sembian Axisymmetric Cases',sprintf('Probe at (%0.3f, 0, 0), %s of bubble',xPos, xRel)};
    LineStyle = '-.';
    
    rebplots(data,leg,ylbl=ylbl,xlbl=xlbl,title=title,LineStyle=LineStyle)
end


%% BOTH

if plotOpts(3) == 1

    loop = 1;

    for i = [1 3 6]
        
        data(loop).x = sembAxisym_singleGraph(i).time;
        data(loop).y = sembAxisym_singleGraph(i).p(:,xInd);
        leg{loop} = sembAxisym_singleGraph(i).name;
        loop = loop + 1;
    
    end
    
    xlbl = 'Time, s';
    ylbl = 'Pressure, Pa';
    title = {'Sembian 2D and Axisymmetric Cases',sprintf('Probe at (%0.3f, 0, 0), %s of bubble',xPos, xRel)};
    LineStyle = '-';
    
    rebplots(data,leg,ylbl=ylbl,xlbl=xlbl,title=title,LineStyle=LineStyle)
end
