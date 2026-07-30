clear all
close all

% predicts farfield pressure bsed on radius vs time data
% uses energy method

%% Loading
% csv file or mat file

% file_location = '/projectnb/turbomac/REBECCA/dorien_tut_comp/EoS/eos_6/pressure';
% radius_file = 'pressure_100.final.csv';
% cd(file_location);
% 
% M = readmatrix(radius_file);
% time = M(:,1);
% radius = M(:,2);            % [m]

load('/projectnb/turbomac/REBECCA/AFOSR2023_pulseTiming.mat')
radius = r_C1_R1;
time = t_C1_R1;
 
%% Inputs

r1D = 0.017;       % displacement where pressure to be calculated  [m]
p_i = 101325;       % pressure at infinity (static)                 [Pa]
R_m = max(radius);      % maximum bubble radius                         [m]
T = 300;         % liquid temperature                            [K]
rho = 1000;          % liquid density                                [kg/m^3]

%% Rayleigh Pressure 

pressure_at_different_distance = zeros(length(r1D),length(time));

for j = 1:length(time)
  
    R = radius(j);
    p0D = p_i*(1 + (4/3)*(R./r1D) * ((1/4)*(R_m^3/R^3) - 1) - (R^4./(3*r1D.^4)) * ((R_m^3/R^3) - 1));
    pressure_at_different_distance(:,j) = p0D';
  
end

%% Saving

% mat file
% 
% S.t_KE_1 = time;
% S.P_KE_1 = pressure_at_different_distance;
% save('../grow_param/pressure_500.mat','-struct','S','-append');

% csv

% rows = size(pressure_at_different_distance);
% fid = fopen('wavetTrans_pressure.csv','w');   
% fprintf(fid,'time, pressure\n');     
% for i = 1:rows(2)
%      fprintf(fid,'%.1e, %.8e\n',time(i),pressure_at_different_distance(i));
% end


%% Plotting

figure
plot(time,pressure_at_different_distance,'linewidth',1.5)
ylabel('Pressure (Pa)','FontSize',14)
xlim([0 1e-5])
xlabel('Time (s)','FontSize',14)
grid on