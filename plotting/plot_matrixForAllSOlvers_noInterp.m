%% Rebecca Shannon
% 9/29/25
% plot matrix of probe pressure - time vs location and color is the
% pressure
% good for Star, MFC, ALPACA, and OpenFOAM data



load /projectnb/aeracous/REBECCA/benchmarks/sembian/sembianBenchmarks.mat
load /projectnb/aeracous/REBECCA/MFC/v4.9.6/sembian/WENO_order_study.mat
solverList = {'OF','star','alpaca','mfc'}; % list solvers used. 
%solverList = {'D2','AS'};
    % NOTE: order is important when setting IC

% compile time and pressures into single structure
% allData.D2 = semb_spark_DOD_2D;
% allData.AS = semb_spark_DOD_axisym;
allData.OF = semb_spark_DOD_2D;
allData.star = semb_spark_star_2D;
allData.alpaca = semb_spark_alpaca_2D;
allData.mfc = D2_O5;

% NOTE: These entries must follow the same order as the entries for solverList var    
t_shift = [201e-6, 0.000233217412, 0.000225249,0.000209];
%t_shift = [201e-6, 201e-6];

% constants
p_amb = 101325; % ambient pressure (atmospheric)
c_l = 1498; % speed of sound in water @ 300K
D = 0.022; % drop diameter

% number of time interpolation points
points = 32; % points in color plot

%nondimensional boundaries
t_acous_start = 0; % acoustic time interval
t_acous_end = 2;
probe_start = -0.8; % probe location interval
probe_end = 0.8;
nonDim_probeLocations = linspace(-0.8,0.8,9); % assume 9 probes evenly spaced
plot_nonDimx = (nonDim_probeLocations + 1) / 2;

% initialize max and min pressure values (for setting plot limits)
maxLim = 0;
minLim = 1e7;

t_const = c_l / D; % acoustic time constant

% set nondimensional time and location based on inputs
nonDim_t = linspace(t_acous_start,t_acous_end,points); 
nonDim_x = linspace(probe_start,probe_end,points);


% pull out pressure 
for loop = 1:length(solverList)
    
    solvName = solverList{loop};

    % shift time (t0 = impact on probe 1) and nondimensionalize
    nonDim_totalTime = (allData.(solvName)(1).time - t_shift(loop)) * t_const;

    % find closest point to the desired time interval
    [~,startInd] = min(abs(nonDim_totalTime - t_acous_start));
    [~,endInd] = min(abs(nonDim_totalTime - t_acous_end));

    % add buffer room around ROI
    startInd = startInd - 1;
    endInd = endInd + 1;

    % pull out time in ROI
    nonDim_selectedTime.(solvName) = nonDim_totalTime(startInd:endInd);
        
    % pull out pressure in ROI
    for probeNum = 2:length(allData.(solvName))
        
        pressure.(solvName)(:,probeNum-1) = allData.(solvName)(probeNum).p(startInd:endInd);

        % interpolate the time
        tInterp_pressure.(solvName)(:,probeNum-1) = interp1(nonDim_selectedTime.(solvName),pressure.(solvName)(:,probeNum-1),nonDim_t);
        
    end

   % normlaize pressure
   plotPressure.(solvName) = tInterp_pressure.(solvName) / 1e5;

    % find max and min pressure values
    maxLim = max(max([plotPressure.(solvName)],[],'all'),maxLim);
    minLim = min(min([plotPressure.(solvName)],[],'all'),minLim);

    % make color plot
%     figure
%     imagesc(plot_nonDimx,nonDim_t,plotPressure.(solvName))
%     set(gca,'YDir','normal')
%     colormap(turbo)

end

% add color bar limits and titles
for i = 1:length(solverList)
    figure(i)
    clim([-10,maxLim])
    title(solverList{i})
end

% plot each solver compared to OF
maxDiffLim = 0;
minDiffLim = 1e10;
% for i = 1:length(solverList)
%     figure
%     solvName = solverList{i};
%     pressureDiff = plotPressure.(solvName) - plotPressure.D2;
%     
%     % find max and min pressure values
%     maxDiffLim = max(max(pressureDiff,[],'all'),maxDiffLim);
%     minDiffLim = min(min(pressureDiff,[],'all'),minDiffLim);
% 
%     imagesc(plot_nonDimx,nonDim_t,pressureDiff)
%     title(strcat(solvName,' minus OF'))
%     set(gca,'YDir','normal')
%     colormap(turbo)
% end


% for i = 1:length(solverList)
%     figure(i+length(solverList))
%     clim([minDiffLim,maxDiffLim])
% end

% find and plot the standard deviation
for x = 1:length(nonDim_t)
    for y = 1:length(nonDim_probeLocations)
        for i = 1:length(solverList)
            solvName = solverList{i};
            pressure_at_points(i) = plotPressure.(solvName)(x,y);
        end
        
        sprintf(strcat("x = ",num2str(x), " y = ", num2str(y)))
        stdDev_allSolvers(x,y) = std(pressure_at_points);

        
    end
end

figure
imagesc(plot_nonDimx,nonDim_t,stdDev_allSolvers)
set(gca,'YDir','normal')
colormap(turbo)
title('Standard Deviation 32 points')