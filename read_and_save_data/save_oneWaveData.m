%% REBECCA SHANNON
% 12/17/25
% extract max pressure at each time for the one wave analytic problems
% specific for blastAMRcases/negP_1Dtests

load('/projectnb/aeracous/REBECCA/blastAMRcases/negP_1Dtests/blast_negP_singleGraph.mat')

myData = air;

for i = 1:length(myData.highP.time)
    myData.highP.maxP(i) = max(myData.highP.p(i,:));
end

for i = 1:length(myData.lowP.time)
    myData.lowP.maxP(i) = max(myData.lowP.p(i,:));
end

air = myData;