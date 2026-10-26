%% REBECCA SHANNON
% 7/14/2026

% move to postProcessing directory of interst
% read Sembian probe data and average per timesteptStart = 0

clear

tStart = 0;

HOME = '/p/work1/rebshan/';
%SCCHOME = '/projectnb/aeracous/REBECCA/';

caseList = {'3O1I','3O3I','6O1I','fixed'};
caseNameList = {'O3I1','O3I3','O6I1','fixed'};

saveTo = '~/vofFoam/semb_kraposhinIC/pisoStudy.mat';

for caseID = 1:length(caseList)

    caseDir = strcat('semb_',caseList{caseID},'/postProcessing');
    caseName = caseNameList{caseID};

    cd(strcat(HOME,caseDir));
    
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
    
    assignin('base',caseName,tmp)

    if isfile(saveTo)
        save(saveTo,caseName,'-append')
    else
        save(saveTo,caseName)
    end
end
