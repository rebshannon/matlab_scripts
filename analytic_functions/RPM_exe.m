% calls RPM.m function to solve Rayleigh-Plesset ODE
% to change fluid, change constants in RPM.m

%% RP Function

Pa = 0;             % initial acoustic excitation   [Pa]
P_infty = 100000;   % liquid pressure at infinity   [Pa]
R0 = 150e-6;  % equilibrium radius            [m]
tspan = [0 0.0001]; % time to solve for             [s]
y0 = [50e-6, 0];     % initial radius and dR/dt      [m, m/s]

opts = odeset('Reltol',1e-9,'AbsTol',1e-9,'Stats','on'); % reltol originally 1e-9
[t,y] = ode45(@RPM, tspan, y0, opts, Pa, R0, P_infty);    

max(y(:,1))
%max(y(:,2))

%% Plotting
% % 
%figure
hold on
plot(t,y(:,1),'linewidth',1.5)
% ylabel('R (m)','FontSize',14)
% xlabel('Time (s)','FontSize',14)
% grid on
% xlim([0 tspan(end)])

% 
% figure
% plot(t,y(:,2),'LineWidth',1.5)
% ylabel('R_dot (m)','FontSize',14)
% xlabel('Time (s)','FontSize',14)
% grid on
% xlim([0 tspan(end)])
% title('R_eq = 5mm')

%% Saving

% mat file

% S.t_C3_R4=t;
% S.r_C3_R4=y(:,1);
% % % S.dydt=y(:,2);
% save('../AFOSR2023_pulseTiming.mat','-struct','S','-append');

% csv

% rows=size(y,1);
% fid=fopen('radius_from_P_t_step.csv','w');    %file to write in
% fprintf(fid,'time, radius\n');        %headers
% for i=1:rows
%     fprintf(fid,'%.8e, %.8e\n',t(i),y(i,1));
% end

%% Load csv

% M = readmatrix(['khanh_P_comp.csv'])
% time_k=[0:5e-9:0.4995e-5];%M(:,1);
% P_k=M(:,1);
% P_k2=M(:,2);
