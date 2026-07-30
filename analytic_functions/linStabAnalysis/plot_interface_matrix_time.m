% KHI initialization
% Save interface data for all time in mat file

% Rebecca Shannon 10/24/23

%%
clear
addpath('/projectnb/turbomac/REBECCA/matlab/linStabAnalysis');

%% OpenFOAM Results

% move to KHI initilization directory 
caseID = '41_3';
caseDirectory=sprintf('/projectnb/turbomac/REBECCA/2D_jetting_splashing/initializeKHI/init%s/interface',caseID);
cd(caseDirectory);

% loop variables and creating vectors
timeSteps = 200;
loop = 0;
peaks = zeros(timeSteps,3);
valleys = zeros(timeSteps,3);

for i = [1:timeSteps] % for init41, t = 170us is just before the BC instability comes in

    % indexing
    loop = loop + 1;

    % name of interface line matrix and read
    interfaceMatrix = sprintf('init%s_interface_%d.csv', caseID, i);
    M = readmatrix(interfaceMatrix);
    L(i) = length(M/4);
    
    % if mod index = 1 then add M2 andd M3 to (x,y) coordinates
    % filters to only one corner of each cell

    % counter for (x,y) coordinates
    k = 0;
    x = zeros(ceil( length(M)/4 ), 1);
    y = zeros(ceil( length(M)/4 ), 1);
   
    % filter out repeat coordinates
    for j = 1:length(M)
        if mod(j,4) == 1
            k = k + 1;
            x(k,1) = M(j,2);
            y(k,1) = M(j,3);
        end
    end

    % find the maximum point of the interface
    % upward moving wave
    [yMax,n] = max(y);
    peaks(loop,1) = i*1e-6;
    peaks(loop, 2) = x(n);
    peaks(loop, 3) = yMax;
    
    % find the minimum point of the interface 
    %downward moving wave
    [yMin,n] = min(y);
    valleys(loop,1) = i*1e-6;
    valleys(loop, 2) = x(n);
    valleys(loop, 3) = yMin;

    %plots all interface lines
    hold on
    plot(x, y, '.')
    xlim([0.75e-3, 2e-3])
    ylim([0 0.3e-3])
end

%% Tuaber Analysis

% constants and IC from case
Ao = 2e-6;            % initial amplitude of perturbation [m]
time = peaks(:,1);  % name the time variable
rho1 = 997;         % lower fluid denisty [kg/m3]
rho2 = 1.552;       % upper fluid density [kg/m3]
dU = 49.92;         % difference in fluid velocity (upper - lower) [m/s]
T = 0.072;          % surface tension [N/m]
lambda = 1e-4;      % initial wavelength of perturbation [m]

% function for analytical growth rate and interface amplitude
[sigma, amplitude] = fnTauber(rho1, rho2, dU, T, lambda, Ao, time);   

% plot relative amplitudes A(t)/Ao

figure
plot(time, amplitude);
hold on
plot(time,peaks(:,3)/peaks(1,3));
xlabel('Time (s)')
ylabel('A(t)/A_o')
grid on
title({'Amplitude of Interface Wave','Y_{pert} = 2 \mum, X_{pert} = 0.1 mm, V_{air} = 50 m/s'})
legend('Linear Stability Analysis','OpenFOAM Result')