%% REBECCA SHANNON
% 7/14/2026

% move to postProcessing directory of interst
% read Sembian probe data and average per timesteptStart = 0

clear

tStart = 0;
tEnd = 239;

DODHOME = '/p/work1/rebshan/';
SCCHOME = '/projectnb/aeracous/REBECCA/';

caseID = 'comp';

caseDir = strcat('semb',caseID','.NARWHAL/postProcessing');
cd(strcat(DODHOME,caseDir));


for probe = 1:3

    cd(strcat('probe',num2str(probe)))
    numSteps = length(dir(fullfile('.','*.csv')));

    for time = tStart:numSteps-1
        fName = strcat('probe',num2str(probe),'_allPoints_',num2str(time),'.csv');
        M = readtable(fName);
        tmp(probe).p(time + 1) = mean(M.p);
        tmp(probe).time(time + 1) = M.Time(2);
    end

    cd ..
end

assignin('base',solver,tmp)
save('~/vofFoam/semb_kraposhinIC/new_avg_probes.mat',solver,'-append')
