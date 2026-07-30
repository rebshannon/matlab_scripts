%% Rebecca Shannon
% 8/7/2025
% Take connected region data saved from Fiji and post process

% input is a bunch of 2 column csv files; the first column in index of
    % droplet/daughter droplet and the second column is the size (in pixels?
    % points)

NSLOTS=str2num(getenv('NSLOTS'));

% choose case and times
BID = '1';

caseName = strcat('U267_D2_B',BID);
caseLoc = strcat('/projectnb/aeracous/REBECCA/DOD_CAVSYM/',caseName);

tStart = 0;
tEnd = 399;

cd(caseLoc)
%load ../postProcessing/daughterStats/cavSym_daughterDropStats.mat


if BID == '2b'               % adjusted BID for when there's doubles or repeats (e.g. 2b and 45)
    aBID = 6;                   % 2b = 6
elseif BID == '45'
    aBID = 5;                % 45 = 5
else
    aBID = BID;          % all others are the same as BID
end
aBID=str2double(aBID);

%% READ AND SAVE DATA

for t = tStart:tEnd

    % read data
    M = readmatrix(strcat('postProcessing/connectedRegionsData/U267D2B',BID,'conReg_t',num2str(t,'%03.f'),'.csv'),'NumHeaderLines',1);
    sorted_M = sort(M(:,2));
    
    allDaughterDrops.(strcat('B',BID)){:,t+1} = sorted_M(1:end-1);

    % statistics for daughter droplets
    daughterStats(aBID).modeSize(t+1) = mode(sorted_M(1:end-1));
    daughterStats(aBID).avgSize(t+1) = mean(sorted_M(1:end-1));
    daughterStats(aBID).medianSize(t+1) = median(sorted_M(1:end-1));
    daughterStats(aBID).stdDevSize(t+1) = std(sorted_M(1:end-1));
    daughterStats(aBID).numDaughter(t+1) = length(sorted_M) - 1;
    
    % max and min size
    if length(sorted_M) - 1 == 0

        daughterStats(aBID).maxSize(t+1) = nan;
        daughterStats(aBID).minSize(t+1) = nan;

    else

        daughterStats(aBID).maxSize(t+1) = max(sorted_M(1:end-1));
        daughterStats(aBID).minSize(t+1) = min(sorted_M(1:end-1));
    
    end

    % primary droplet
    daughterStats(aBID).primaryDropSize(t+1) = max(M(:,2));
    daughterStats(aBID).totalSize(t+1) = sum(M(:,2));

end

save('../postProcessing/daughterStats/cavSym_daughterDropStats.mat','allDaughterDrops', 'daughterStats')

