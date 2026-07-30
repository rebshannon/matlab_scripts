%% Rebecca Shannon
% 7/11/25
% read data from singleGraph and save to mat

%clear colNum i myStructure p rho t* T x writeInterval
%clc

%% NOTE: NEED TO CHANGE MAT AND STRUCTURE NAMES BELOW
% also need to set the case name
% note that each row is a new time
% time = row - 1 (starts at 0)

%% INITIAL SETTINGS

% Choose case
caseName = 'DOD_compare';%oneWave_airToWater';
caseLoc = 'hybridSolvers/vof/dataFromDOD/vofDS6/singleGraph';
i=1;

tStart = 0;
writeInterval = 2.1409e-7;
tEnd = 9.63405e-6;
    
cd(strcat('/projectnb/aeracous/REBECCA/blastAMRcases/originalTests/',caseLoc));

%% READ ALL SINGLEGRAPH DATA
% split up based on timestep number format
% specifically for 1us timesteps

% read first matrix

if tStart == 0
    M = readmatrix('singleGraph_pv_0.csv','FileType','text');
    rho = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
    rho(1,:) = 0;
else
    M = readmatrix(strcat('singleGraph_pv_',num2str(tStart),'.csv'),'FileType','text');
    rho = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
    rho(1,:) = M(:,7);
end

% initialize
T = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
p = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
Ux = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
Uy = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
x = M(:,8);
timeInt = tStart:writeInterval:tEnd;
% pMax = zeros(round((tEnd-tStart)/writeInterval+1),1);
% pMin = zeros(round((tEnd-tStart)/writeInterval+1),1);

% extract data for t0
colNum = 1;
T(colNum,:) = M(:,2);
p(colNum,:) = M(:,6);
% pMax(colNum) = max(M(:,6));
% pMin(colNum) = min(M(:,6));
Ux(colNum,:) = M(:,3);
Ux(colNum,:) = M(:,4);

for t = timeInt

    if t == tStart
        continue
    end

    colNum = colNum + 1;
    
    M = readmatrix(strcat('singleGraph_pv_',num2str(tStart),'.csv'),'FileType','text');
    T(colNum,:) = M(:,2);
    p(colNum,:) = M(:,6);
%     pMax(colNum) = max(M(:,6));
%     pMin(colNum) = min(M(:,6));
    Ux(colNum,:) = M(:,3);
    Ux(colNum,:) = M(:,4);

%     sprintf(strcat(t_strip))
    
    
end


%% SEND TO STRUCTURE


myStructure.p = p;
myStructure.rho = rho;
myStructure.T = T;
myStructure.x = x;
myStructure.time = timeInt;
myStructure.Ux = Ux;
myStructure.Uy = Uy;
% myStructure.maxP = pMax;
% myStructure.minP = pMin;

dodBlastSemb11 = myStructure;

%save('../../../blast_negP_analyticSoln.mat','airToWater_singleGraph','-append')
% load ../../../semb_2D_3D_singleGraph.mat
% sembAxisym_singleGraph(i).T = T;
% sembAxisym_singleGraph(i).p = p;
% sembAxisym_singleGraph(i).rho = rho;
% sembAxisym_singleGraph(i).x = x;
% sembAxisym_singleGraph(i).time = transpose(0:1e-6:299e-6);
% sembAxisym_singleGraph(i).name = caseName;
% 
% %% SAVE 
% 
% save('../../../semb_2D_3D_singleGraph.mat', "sembAxisym_singleGraph",'-append')
