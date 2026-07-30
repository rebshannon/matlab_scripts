NSLOTS=str2num(getenv('NSLOTS')); 
maxNumCompThreads(NSLOTS); %don't go over requested # of cores
clear 

% Rebecca Shannon
% adapted from Ankush
% finds the equivalent bubble radius based on volume csv data
% NOTE: make sure to set the right timestep and choose the correct volume 
%   calculation

%% Volume File

file_location = ['/projectnb/turbomac/REBECCA/2D_jetting_splashing/kobelCylinder/jettingOnly/jet3rp3P/'];
volume_file = ['volume' ...
    '/volume.final.csv'];
cd(file_location);

M = readmatrix(volume_file);
rows = size(M,1);

% choose settings from OpenFOAM

dt = 0.5e-6;    % writeInterval                     [s]
slice = 5;      % size of axisymmetric slice        [deg]
sym = 1;        % 1 for full axisym, 2 for half symmetry
depth = 0.5e-3;   % depth of domain for 2D cases      [m]

%% Calculation 

% calculate radius from volume, assuming volume in column 2
% calculation needs to be adjusted for different grids

t=0;
radius = zeros(size(rows));

for i=1:rows

% axisymmetric

%      V_slice = M(i,2);                     
%      V_full = V_slice*360/slice*sym;             
%      radius(i,2) = (3/4/pi*V_full)^(1/3); 

% 2D tutorial

   V_2D = M(i,2);
   Area=V_2D/depth;   
   radius(i,2)=sqrt(Area/pi)

    radius(i,1) = t;
    t = t + dt;

end

%% Saving

% wrte data to csv

% fid = fopen('dorien_pw_fine_grow_6.csv','w');    
% fprintf(fid,'time, radius\n');       
% for i = 1:rows
%     fprintf(fid,'%.1e, %.8e\n',radius(i,1),radius(i,2));
% end

% save to mat file
% %  
%  S.t_jet3rp = radius(:,1);
%  S.r_jet3rp = radius(:,2);
%  % % % %save('../../relFact_study.mat','-struct','S','-append');
% % % % % % % % 
%  save('../jettingOnly_radius.mat','-struct','S');

%% Plotting

hold on
plot(radius(:,1),radius(:,2),'LineWidth',1.5)
grid on;
xlabel('Time (s)');
ylabel('Radius (m)');
title({'Radius vs Time','10 micron bubble'}) 


% plot(t,r_relFact_1,t,r_relFact_2,t,r_relFact_3,t,r_relFact_4)
% grid on
% xlim([0 5e-6])
% figure
% plot(t,r_relFact_5,t,r_relFact_6,t,r_relFact_7,t,r_relFact_8)