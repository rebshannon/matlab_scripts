% Rebecca Shannon
% 4/15/25
% postProcess new cav cases 
% make a new array around ROI 

maxNumCompThreads(1);

%% FILE LOCATIONS

% CHOOSE THESE
% set in the qsub_matlab script and should automatically update

% caseName is the case directory, variable is what data should be looked
% at, tend is the last written timestep (microseconds)

caseName = 'bubble/flow/U267_D2mm_B2';
variable = 'alpha';
tstart = 0;
tend = 400;
U = 267;

% LOCATIONS - where to read and write to/from

caseDir = strcat('/projectnb/turbomac/REBECCA/cavSym2024/',caseName);
writeto = strcat('/projectnb/turbomac/REBECCA/cavSym2024/',caseName, ...
    '/postProcess/',variable,'/');
addpath('/projectnb/turbomac/REBECCA/matlab/'); % for genTimes function



for t = tstart:tend

    %% LOAD DATA

    timeDir = strcat(caseDir,'/',allTimes{t+1});
    cd(timeDir)
    centerVal = readmatrix(variable);

