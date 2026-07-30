NSLOTS=str2num(getenv('NSLOTS')); 
maxNumCompThreads(NSLOTS); %don't go over requested # of cores

clear 
clc

% pull out desired variable from csv to plot and/or save to mat

%% Loading

file_location = '/projectnb/turbomac/REBECCA/surfaces/free/pop_f2/pressure';
variable_file = 'pressure_10mm.final.csv';
cd(file_location);

M = readmatrix(variable_file);
rows = size(M,1)-1;
dt = 6.66665e-6;
%dt = 1.33333e-5;

var(:,2) = M(:,2);
var(:,1) = [0:dt:dt*rows];

%% Plotting

figure
plot(var(:,1),var(:,2),'LineWidth',1.5)
xlim([0 5e-4]);
grid on;
xlabel('Time (s)');
ylabel('Pressure (Pa)');
title({'Pressure vs Time Rigid Wall','Mesh Density'}) 

%% Saving

% S.t_pop4 = var(:,1);
% S.P_pop4 = var(:,2);
% save('../../pressure_10mm.mat','-struct','S','-append');