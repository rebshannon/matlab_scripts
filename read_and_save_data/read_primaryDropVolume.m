%% Rebecca Shannon
% 8/18/25
% read data from dropletMass and save to mat
% assumes only largest region is saved

%% NOTE: NEED TO CHANGE MAT AND STRUCTURE NAMES BELOW
% also need to set probe locations and the case name
% be sure that you have cleaned the U file to Unew

%% INITIAL SETTINGS

% Choose case
caseName = ['AIAA-shot6/DOD_2D'];
    
cd(strcat('/projectnb/aeracous/REBECCA/benchmarks/',caseName,'/postProcessing/dropletMass/'));



%% READ THE CSV
M = readmatrix('dropletMass.csv');

%% SEND TO STRUCTURE

primDrop.T = M(:,2);
primDrop.U0 = M(:,3);
primDrop.U1 = M(:,4);
primDrop.U2 = M(:,5);
primDrop.alpha = M(:,6);
primDrop.p = M(:,7);
primDrop.rho = M(:,8);
primDrop.volume = M(:,9);
%primDrop.normMass = M(:,3);

%% SAVE 
% name convention for deist/mesh density: probe_<solver>_<cells per 22mm>

primDrop_DOD_2D = primDrop;
save('/projectnb/aeracous/REBECCA/benchmarks/AIAA-shot6/shot6_Benchmarks.mat', "primDrop_DOD_2D",'-append')


