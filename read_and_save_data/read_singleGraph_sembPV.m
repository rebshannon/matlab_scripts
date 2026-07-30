%% Rebecca Shannon
% 7/11/25
% read data from singleGraph and save to mat

clear
clc

%% NOTE: NEED TO CHANGE MAT AND STRUCTURE NAMES BELOW
% also need to set the case name
% note that each row is a new time
% time = row - 1 (starts at 0)

%% INITIAL SETTINGS

% Choose case
caseName = ['blastTest'];
i=1;

tStart = 0;
writeInterval = 1e-6;
tEnd = 283e-6;
readFile = 'singleGraph_pv_';
    
cd(strcat('/p/home/rebshan/sembian_blast/',caseName,'/postProcessing/singleGraph/0'));

%% READ ALL SINGLEGRAPH DATA
% split up based on timestep number format
% specifically for 1us timesteps

% read first matrix


M = readmatrix(strcat(readFile,num2str(0),'.csv'));
x = M(:,7);

timeInt = [tStart:writeInterval:tEnd] / writeInterval;

% initialize
T = zeros(round(tEnd/writeInterval),size(M,1));
p = zeros(round(tEnd/writeInterval),size(M,1));
rho = zeros(round(tEnd/writeInterval),size(M,1));
U1 = zeros(round(tEnd/writeInterval),size(M,1));
U2 = zeros(round(tEnd/writeInterval),size(M,1));

% extract data for t0
colNum = tStart + 1;
T(colNum,:) = M(:,2);
p(colNum,:) = M(:,6);
rho(colNum,:) = 0;
U1(colNum,:) = M(:,3);
U2(colNum,:) = M(:,4);

for t = timeInt

    colNum = colNum + 1;

    if t == 0
        continue
    end

    M = readmatrix(strcat(readFile,num2str(t),'.csv'));
    T(colNum,:) = M(:,2);
    p(colNum,:) = M(:,6);
    rho(colNum,:) = M(:,7);
    U1(colNum,:) = M(:,3);
    U2(colNum,:) = M(:,4);
    
end


%% SEND TO STRUCTURE

struct.T = T;
struct.p = p;
struct.rho = rho;
struct.x = x;
struct.time = transpose(tStart:writeInterval:tEnd);
%struct.name = caseName;

%% SAVE 

semb_blastTest = struct;
save('../../../../BLPIMP_singleGraph.mat', "semb_blastTest",'-append')
