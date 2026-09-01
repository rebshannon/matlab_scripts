%% Rebecca Shannon
% 4/23/24
% majot update 9/1/2026
% read data from probes and save to mat

%% NOTE
% Set case Dir, caseID, and choose SCC or DOD home
% Choose where to save

%% INITIAL SETTINGS

DODHOME = '/p/work1/rebshan/';
SCCHOME = '/projectnb/aeracous/REBECCA/';

% Choose case
caseDir = 'hybridSolvers/vof_DS6/';
caseID = 'comp';

fullCase = strcat(SCCHOME,caseDir,caseID,'/probeDat');  
cd(fullCase);

saveTo = strcat(SCCHOME,caseDir,'DS6_comp.mat');

%% GET LIST OF TIMES

dir_contents = dir(fullCase);
dirs = dir_contents([dir_contents.isdir] & ~ismember({dir_contents.name}, {'.', '..'}));

%% Loop over all times, variables, and probes
% time loop (sometimes rho is in separate dir)
for i = 1:length(dirs)

    dataDir = dir(dirs(i).name);
    varList = dataDir(~[dataDir.isdir] & ~ismember({dataDir.name},{'.','..'}));

    % variable loop
    for var = 1:length(varList)

        M = readmatrix(strcat(varList(var).folder,'/',varList(var).name),'filetype','text');
        varName = varList(var).name;
        
        % probe loop
        for probe = 1:size(M,2)-1
        
            if i == 1
                tmp(probe).time = M(:,1);
            end
            
            tmp(probe).(varName) = M(:,probe+1);

        end

    end

end

%% SAVE 

assignin('base',caseID,tmp)
save(saveTo, caseID)%,'-append')



