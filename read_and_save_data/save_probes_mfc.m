%% REBECCA SHANNON
% read probes from MFC
%% test for git branching

% probe and case info
numProbes = 10;
caseNum = 1:13;
dimension = '2D';

% sim constants
cfl = 0.15;
cells_per_diam = 300;
rhoWater = 1000;

load('/projectnb/aeracous/REBECCA/MFC/v5.0.6/shockDropParam/shockDropParamData.mat')

for caseID = caseNum
    
    % move to case location
    caseLocation = strcat('/projectnb/aeracous/REBECCA/MFC/v5.0.6/shockDropParam/'...
        ,dimension,'/case',num2str(caseID),'/D');
    cd(caseLocation)
        
    % calc times
    c_l = sqrt(1.4 * shockDropParamIC.p2(caseID) / shockDropParamIC.rho1(caseID));
    dx = shockDropParamIC.D(caseID ) / cells_per_diam;
    tau = shockDropParamIC.D(caseID ) / shockDropParamIC.U2(caseID ) * ...
        sqrt(rhoWater / shockDropParamIC.rho2(caseID ));
    dt = cfl * dx / c_l;
    endTime = tau;
    
    % initialize stuff
    numTimeSteps = length(readmatrix("probe1_prim.dat"));
    time = zeros(numTimeSteps,1);
    timeStep = zeros(numTimeSteps,1);
    nonDimTime = zeros(numTimeSteps,1);
    
    % write time info
    for tstep = 0:numTimeSteps
        time(tstep+1) = tstep * dt;
        timeStep(tstep+1) = tstep;
        nonDimTime(tstep+1) = time(tstep+1) / tau;
    end

    % read probe info
    for i = 1:numProbes    
        fName = strcat('probe',num2str(i),'_prim.dat');
        M = readmatrix(fName);
        probes(caseID).p(:,i) = M(:,4);
        probes(caseID).U(:,i) = M(:,3);
        probes(caseID).rho(:,i) = M(:,2);
        probes(caseID).time(:,i) = time;
        probes(caseID).timeStep(:,i) = timeStep;
        probes(caseID).nonDimTime(:,i) = nonDimTime;
    end
end

% save
% shockDropParam2D = probes;
% save('../../shockDropParam2D.mat','shockDropParam2D');%,'-append')
