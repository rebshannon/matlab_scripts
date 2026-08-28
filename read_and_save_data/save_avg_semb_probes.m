%% REBECCA SHANNON
% 7/14/2026

% move to postProcessing directory of interst
% read Sembian probe data and average per timesteptStart = 0

tStart = 0;
tEnd = 239;

DODHOME = '/p/work1/rebshan/';
caseDir = 'sembcomp.NARWHAL/postProcessing';

cd(strcat(DODHOME,caseDir));


for probe = 1:3

    cd(strcat('probe',num2str(probe)))
    numSteps = length(dir(fullfile('.','*.csv')));

    for time = tStart:numSteps-1
        fName = strcat('probe',num2str(probe),'_allPoints_',num2str(time),'.csv');
        M = readmatrix(fName);
        pres = mean(M(:,2));
        tmp(probe).p(time + 1) = pres;
    end

    cd ..
end

tait = tmp;