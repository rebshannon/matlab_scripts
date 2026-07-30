%% REBECCA SHANNON
% take data from diameter out csv
% first section saves as mat 
% second section does plotting


workingDir = '/projectnb/aeracous/REBECCA/DOD_CAVSYM/';
BID = {'1','2','3','4','45','2b','7','8','86','10','11','12','13'};
alphaThreshold = 0.1;

cd(workingDir)


%% save data
for i = 1:13

    %caseDir = strcat(workingDir,'U267_D2_B',BID{i},'/postProcessing/pvData/',...
    %    'out_U267_D2_B',BID{i},'_alpha0',num2str(10*alphaThreshold),'.csv');
    caseDir = strcat('newDiameterData/alpha01/out_U267_D2_B',BID{i},'_alpha0',num2str(10*alphaThreshold),'.csv');
    M = readmatrix(caseDir);

    diameterData_alpha01(i).time = M(2:end,2);
    diameterData_alpha01(i).horizontal = M(2:end,3);
    diameterData_alpha01(i).vertical = M(2:end,4);
    diameterData_alpha01(i).equator = M(2:end,5);
    diameterData_alpha01(i).centOfMass = M(2:end,6);
    diameterData_alpha01(i).leadingEdge = M(2:end,7);
    diameterData_alpha01(i).leadingEdgeEq = M(2:end,8);

end

%% plot data

ratio_h1 = diameterData_alpha01(1).horizontal ./diameterData_alpha01(1).vertical;
ratio_e1 = diameterData_alpha01(1).equator ./ diameterData_alpha01(1).vertical;

for i = [6,3,2] %8:13

    L = length(diameterData_alpha01(i).time);

    figure(1)
    plot((diameterData_alpha01(i).horizontal-diameterData_alpha01(1).horizontal(1:L))./diameterData_alpha01(1).horizontal(1:L))
    hold on

    figure(2)
    plot(smooth((diameterData_alpha01(i).vertical-diameterData_alpha01(1).vertical(1:L))./diameterData_alpha01(1).vertical(1:L)))
    hold on

    figure(3)
    plot((diameterData_alpha01(i).equator-diameterData_alpha01(1).equator(1:L))./diameterData_alpha01(1).equator(1:L))
    hold on
     
    figure(4)
    ratio_h = diameterData_alpha01(i).horizontal ./ diameterData_alpha01(i).vertical;
    ratio_e = diameterData_alpha01(i).equator ./ diameterData_alpha01(i).vertical;
    plot((ratio_h - ratio_h1(1:L)) ./ ratio_h1(1:L))
    hold on

    figure(5)
    plot((ratio_e - ratio_e1(1:L)) ./ ratio_e1(1:L))

    % plot(((diameterData_alpha01(i).leadingEdge-diameterData_alpha01(i).leadingEdge(1))...
    %     -(diameterData_alpha01(1).leadingEdge-diameterData_alpha01(1).leadingEdge(1)))...
    %     /0.002)%./(diameterData_alpha01(1).leadingEdge-diameterData_alpha01(1).leadingEdge(1)))
    hold on
end



for i = 1:7

    figure(5)
    plot((diameterData_alpha01(i).horizontal))
    hold on

    figure(6)
    plot((diameterData_alpha01(i).vertical))
    hold on

    figure(7)
    plot((diameterData_alpha01(i).equator))
    hold on

    figure(8)
    plot((diameterData_alpha01(i).leadingEdge))
    hold on
end