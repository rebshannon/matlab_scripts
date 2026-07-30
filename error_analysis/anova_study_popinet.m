%% ANOVA study of popinet grids

% load data

load ../surfaces/rigid/popinet_grid_study_anova.mat

% response
% choose Rmax, RmaxTime, endTime
 
y = endTime;

% factors

g1 = areaRatio;
g2 = aspectRatio;
g3 = boxSize;
g4 = boxSpacing;
g5 = farFieldCells;

% anova

[p,tbl,stats] = anovan(y,{g1,g2,g3,g4,g5})
