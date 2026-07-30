%% Rebecca Shannon
% 4/23/24
% read data from probes and save to mat

%% NOTE: NEED TO CHANGE MAT AND STRUCTURE NAMES BELOW
% also need to set probe locations and the case name
% be sure that you have cleaned the U file to Unew

%% INITIAL SETTINGS

% Choose case
caseName = ['sembTESTalpha/postProcessing/sembProbes/'];
    
cd(strcat('/projectnb/aeracous/REBECCA/blastAMRcases/',caseName));

% set initial dt (for rho and pHold)
dt1 = num2str(0);

% Set probe locations
% manually set for now but wouuld love for it to be automatic

numProbes = 3;
probeLocs = [  -0.016 0 0
               -0.006 0 0
                0.007 0 0];
% [   -0.013    0.0   0
% 	            -0.0088 0.0   0
% 	            -0.0066 0.0   0
%                 -0.0044 0.0   0
% 	            -0.0022 0.0   0
%                  0.0      0.0   0
% 	             0.0022 0.0   0
% 	             0.0044 0.0   0
%                  0.0066 0.0   0
% 	             0.0088 0.0   0]; % drop located at (0 0 0)

% [   0.116 0.00022 0 
%                 0.126 0.00022 0 
%                 0.139 0.00022 0 ]; % shorter Sembian cases

%% READ ALL PROBE DATA

T = readmatrix('0/T');
p = readmatrix('0/p');
%U1 = readmatrix('0/u');
%U2 = readmatrix('0/v');
rho = readmatrix(strcat(dt1,'/rho'));

%% SEND TO STRUCTURE

for probeID = 1:numProbes
    probe(probeID).T = T(:,probeID+1);
    probe(probeID).p = p(:,probeID+1);
    probe(probeID).rho = rho(:,probeID+1);
    probe(probeID).loc = probeLocs(probeID,:);
    probe(probeID).time = T(:,1);
    % probe(probeID).U1 = U1(:,probeID+1);
    % probe(probeID).U2 = U2(:,probeID+1);
    %probe(probeID).U3 = U(:,probeID*numProbes+1);
end

%% SAVE 
% name convention for deist/mesh density: probe_<solver>_<cells per 22mm>

blastSemb11 = probe;
% save('/projectnb/aeracous/REBECCA/benchmarks/sembian/sembianBenchmarks_orig.mat', "semb_spark_star_2D",'-append')

%% RATIOS

% time = p(:,1);
% p2p1 = p(:,3) ./ p(:,2);
% T2T1 = T(:,3) ./ T(:,2); 
% rho2rho1 = rho(:,3) ./ rho(:,2);

