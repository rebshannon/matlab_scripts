%REBECCA SHANNON
% 8/25/2025

% Plot probe data from Smebian/AIAA shot 6
% plot all probes to track wave for a specific case


%load /projectnb/aeracous/REBECCA/semb_2D_3D_singleGraphData/semb_2D_3D_probes.mat
%load /projectnb/aeracous/REBECCA/benchmarks/sembian/sembianBenchmarks.mat
load /projectnb/aeracous/REBECCA/benchmarks/AIAA-shot6/shot6_Benchmarks.mat
addpath '/projectnb/turbomac/REBECCA/matlab'

numProbes = 9;

probeCase = shot6Benchmark_DOD_2D;

xlbl = 'Time, s';
ylbl = 'Pressure, Pa';
%leg = {'2D OpenFOAM','Axisym OpenFOAM', '2D ECOGEN'};
figure
for i = 1:numProbes

    leg{i} = strcat('Probe ',num2str(i));

    data(i).x = probeCase(i).time;
    data(i).y = probeCase(i).p;


end

title = {'AIAA Shot 6 Case Benchmark Comparison',sprintf('Probe %0.0f',i)};

rebplots(data,leg,title=title,xlbl=xlbl,ylbl=ylbl)