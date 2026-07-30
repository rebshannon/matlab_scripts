% Rebecca Shannon
% 10/2/24
% Read Brendon's Star data
% find data from a probe

%% DEFINE PROBES
% probe location (m), based on brendon's sim
% for this case, (0, 0, 0) is the center of the drop

probeLocs = [ -16e-3 4.4e-5 0 
               -6e-3 4.4e-5 0 
                7e-3 4.4e-5 0 ];

%% INITIALIZE VARIABLES

numProbes = size(probeLocs,1);

myDir = uigetdir; % choose directory with data
myFiles = dir(fullfile(myDir,'*.csv')); % get every csv file
numTimeSteps = length(myFiles);

probeInd = zeros(numProbes,1);
probe = struct('T',zeros(numTimeSteps,1),'p',zeros(numTimeSteps,1),'Umag',zeros(numTimeSteps,1),'time',zeros(numTimeSteps,1),'loc',zeros(numProbes,3));

%% LOOP OVER ALL TIME SERIES CSVs

for tInd = 1:length(myFiles)

    % find and read next file
    baseFileName = myFiles(tInd).name;   
    fprintf(1, 'Now reading %s\n', baseFileName);   
    starDat = readmatrix(baseFileName);             

    %% FIND PROBE INDICES
    % find the closest index to the specified probes
    % only needs to run for first loop
    % assumes that all csvs have same xyz points

    if tInd == 1
        for probeID = 1:numProbes
        
            totDif = abs(starDat(:,10) - probeLocs(probeID,1)) ...
                        + abs(starDat(:,11) - probeLocs(probeID,2)) ...
                        + abs(starDat(:,12) - probeLocs(probeID,3));
        
            [value, probeInd(probeID)] = min(totDif);
        
        end
    end

    %% PUT DATA IN A STRUCTURE ARRAY
    % pull out data for each probe and put in structure array
        % structures: probe
        % fields:     T, p, Umag, time

    for probeID = 1:numProbes
        
        probe(probeID).T(tInd) = starDat(probeInd(probeID),1);
        probe(probeID).p(tInd) = starDat(probeInd(probeID),2);
        probe(probeID).Umag(tInd) = starDat(probeInd(probeID),3);
        probe(probeID).time(tInd) = tInd;
        probe(probeID).loc = probeLocs(probeID,:);

    end

end
   
%% SAVE
% save probe data and the probe locations to a mat
save('brendProbeDat.mat','probe','-append');