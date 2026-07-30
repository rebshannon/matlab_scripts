%% Rebecca Shannon
% 12/9/25
% read csv from postProcess python script that finds droplet diameters
% MFC info so the actual time is calculated

caseHome = '/projectnb/aeracous/REBECCA/MFC/v5.0.6/shockDropParam/2D/';
cd(caseHome)

load shockDropParam2D.mat

for caseNum = 1:13

    folder = strcat('case',num2str(caseNum));
    cd(folder)

    fName = strcat('silo_hdf5/out_case',num2str(caseNum),'.csv');
    M = readmatrix(fName);

    diameters_alpha01(caseNum).horizontal = M(2:end,3);
    diameters_alpha01(caseNum).vertical = M(2:end,4);
    diameters_alpha01(caseNum).equator = M(2:end,5);
    diameters_alpha01(caseNum).centOfMass = M(2:end,6);

    diameters_alpha01(caseNum).timeStep = M(2:end,2);

    time = M(2:end,2) .* shockDropParamIC.dt(caseNum);
    nonDimTime = time / shockDropParamIC.tau2(caseNum);

    diameters_alpha01(caseNum).time =  time;
    diameters_alpha01(caseNum).nonDimTime = nonDimTime;

    cd ../

    save('shockDropParam2D.mat','diameters_alpha01','-append')
end
