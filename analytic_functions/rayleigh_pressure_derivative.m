clear
close all

% predicts farfield pressure bsed on radius vs time data
% uses derivative method

%% Loading
% csv or mat file

% file_location = '/projectnb/turbomac/REBECCA/matlab/farfield_derivative_KE';
% radius_file = 'square_radius.csv';
% cd(file_location);

% M = readmatrix('radius_file')
% time = M(:,1);
% radius = M(:,2);            % [m]
% dRdt = M(:,3);
% 
load('/projectnb/turbomac/REBECCA/AFOSR2023_pulseTiming.mat');
radius = r_C3_R2;
time = t_C3_R2;

%% Inputs and Derivatives

r1D = 0.017;       % displacements where pressure to be calculated [m]
p_i = 0;       % pressure at infinity (static)                 [Pa]
T = 300;         % liquid temperature                            [K]
rho = 1000;          % liquid density                                [kg/m^3]

dRdt = diff(radius)./diff(time);
dRdt2 = diff(dRdt)./diff(time(1:end-1));

%% Rayleigh Pressure 

pressure_at_different_distance = zeros(length(r1D),length(time));

for j = 1:length(dRdt2)

    R = radius(j);
    R_dot = dRdt(j);
    R_2dot = dRdt2(j);
    p0D = p_i + rho*((2*R*R_dot^2 + R^2*R_2dot)./r1D - R^4*R_dot^2/2./r1D.^4);
    pressure_at_different_distance(:,j) = p0D';

end

%% Saving

% mat file
% 
% S.t_der_Gil = time;
% S.P_der_Gil = pressure_at_different_distance;
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
xlim([0 5e-6])
xlabel('Time (s)','FontSize',14)
grid on
