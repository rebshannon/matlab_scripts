%% Rebecca Shannon
% 10/8/24
% find average of probe area data

%% PREPROCESS

% choose case name and location

MYHOME = '/projectnb/aeracous/REBECCA/';
caseLocation = 'blastAMRcases/';
caseName = 'sembTESTalpha';

cd(strcat(MYHOME,caseLocation,caseName));
probesName = 'probeAvg';
probesLocation = strcat('postProcessing/',probesName);

load '../sembBlastTests.mat'

% set end time and the size of data

tend = 400;
points = 100;

time = zeros(tend,1);
p = zeros(tend,1);
T = zeros(tend,1);
U0 = zeros(tend,1);
U1 = zeros(tend,1);


%% READ PROBE DATA AND AVERAGE

for tInd = 1:tend
   
    fileName = strcat(probesLocation,'/',probesName,'_3_',num2str(tInd-1),'.csv');
    probeTimeMat = readmatrix(fileName);

    time(tInd) = mean(probeTimeMat(:,1));
    p(tInd) = mean(probeTimeMat(:,6));
    T(tInd) = mean(probeTimeMat(:,2));
    U0(tInd) = mean(probeTimeMat(:,3));
    U1(tInd) = mean(probeTimeMat(:,4));


end

blastSemb11Avg(3).time = time;
blastSemb11Avg(3).p = p;
blastSemb11Av(3).Ux = U0;
blastSemb11Avg(3).Uy = U1;
blastSemb11Avg(3).T = T;


save('../sembBlastTests.mat','blastSemb11Avg','-append')
