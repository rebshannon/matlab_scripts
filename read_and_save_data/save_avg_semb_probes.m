%% REBECCA SHANNON
% 7/14/2026

% move to postProcessing directory of interst
% read Sembian probe data and average per timesteptStart = 0

tStart = 0;
tEnd = 239;


for probe = 1:3
    for time = tStart:tEnd

        fName = strcat('probe',num2str(probe),'/probe',num2str(probe),'_allPoints_',num2str(time),'.csv');
        M = readmatrix(fName);
        pres = mean(M(:,2));
        vofFoam_semb(probe).p(time + 1) = pres;
    end
end

