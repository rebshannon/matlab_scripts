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
caseName = 'lowP/oneWave_water';%oneWave_airToWater';
i=1;

tStart = 8e-7;
writeInterval = 2e-7;
tEnd = 2e-5;
    
cd(strcat('/projectnb/aeracous/REBECCA/blastAMRcases/negP_1Dtests/',caseName,'/postProcessing/singleGraph/'));

%% READ ALL SINGLEGRAPH DATA
% split up based on timestep number format
% specifically for 1us timesteps

% read first matrix

if tStart == 0
    M = readmatrix('0/line_T_p.xy','FileType','text');
    rho = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
    rho(1,:) = 0;
else
    M = readmatrix(strcat(num2str(tStart),'/line_T_p_rho.xy'),'FileType','text');
    rho = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
    rho(1,:) = M(:,4);
end

% initialize
T = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
p = zeros(round((tEnd-tStart)/writeInterval+1),size(M,1));
x = M(:,1);
timeInt = tStart:writeInterval:tEnd;
pMax = zeros(round((tEnd-tStart)/writeInterval+1),1);
pMin = zeros(round((tEnd-tStart)/writeInterval+1),1);

% extract data for t0
colNum = 1;
T(colNum,:) = M(:,2);
p(colNum,:) = M(:,3);
pMax(colNum) = max(M(:,3));
pMin(colNum) = min(M(:,3));

for t = timeInt

    if t == tStart
        continue
    end

    colNum = colNum + 1;
    
    if t < 1e-6
         
        M = readmatrix(sprintf('%.0e/line_T_p_rho.xy',t),'FileType','text');
%        sprintf('%.0e',t)
        T(colNum,:) = M(:,2);
        p(colNum,:) = M(:,3);
        rho(colNum,:) = M(:,4);
        pMax(colNum) = max(M(:,3));
        pMin(colNum) = min(M(:,3));
        continue
    end

     if t < 10e-6

         if rem(t,1e-6) == 0
              M = readmatrix(sprintf('%.0e/line_T_p_rho.xy',t),'FileType','text');
 %             sprintf('%.0e',t)
         else 
              M = readmatrix(sprintf('%.1e/line_T_p_rho.xy',t),'FileType','text');
%              sprintf('%.1e',t)
         end
 
         T(colNum,:) = M(:,2);
         p(colNum,:) = M(:,3);
         rho(colNum,:) = M(:,4);
         pMax(colNum) = max(M(:,3));
         pMin(colNum) = min(M(:,3));
         continue
     end

     if t < 100e-6

         if rem(round(t,6),10e-6) == 0
             M = readmatrix(sprintf('%.0e/line_T_p_rho.xy',t),'FileType','text');
%             sprintf('%.0e',t)
         elseif rem(round(t,6),1e-6)==0
             M = readmatrix(sprintf('%.1e/line_T_p_rho.xy',t),'FileType','text');
%             sprintf('%.1e',t)
         else
              M = readmatrix(sprintf('%.2e/line_T_p_rho.xy',t),'FileType','text');
%             sprintf('%.2e',t)
         end

         T(colNum,:) = M(:,2);
         p(colNum,:) = M(:,3);
         rho(colNum,:) = M(:,4);
         pMax(colNum) = max(M(:,3));
         pMin(colNum) = min(M(:,3));
         continue
     end

     t_strip = strip(num2str(t),'right','0');
     M = readmatrix(strcat(t_strip,'/line_T_p_rho.xy'),'FileType','text');
     T(colNum,:) = M(:,2);
     p(colNum,:) = M(:,3);
     rho(colNum,:) = M(:,4);
     pMax(colNum) = max(M(:,3));
     pMin(colNum) = min(M(:,3));

%     sprintf(strcat(t_strip))
    
    
end


%% SEND TO STRUCTURE


myStructure.p = p;
myStructure.rho = rho;
myStructure.T = T;
myStructure.x = x;
myStructure.time = timeInt;
myStructure.maxP = pMax;
myStructure.minP = pMin;

water.lowP = myStructure;

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
