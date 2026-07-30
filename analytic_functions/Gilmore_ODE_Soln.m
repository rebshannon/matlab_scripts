NSLOTS=str2num(getenv('NSLOTS')); 
maxNumCompThreads(NSLOTS); %don't go over requested # of cores

% ICs and mat properties

R0 = 5e-6;              % initial radius                [m]
v0 = 0;                % initial velocity              [m/s]
requ = 10e-6;            % equilibrium radius            [m]
pvapour = 2300;         % vapor pressure                [Pa]
pac = 100000;           % external pressure             [Pa]
frequ = 0;              % frequency of sound excitation
t_data = [0:1:500];    % number of timesteps (set dt in fn)

% call Gilmore and solve

[t, R] = Gilmore_odeint3(R0, v0, requ, pvapour, pac,frequ, t_data);

%% Plotting
hold on
plot(t,R)
grid on
xlabel('Time, s')
ylabel('Radius, m')
title('Gilmore Radius vs Time')
%xlim([0 2e-4])

%% Saving

% mat file
% 
% S.tGilmore=t;
% S.rGilmore=R;
% save('../grow_param/radius_comp.mat','-struct','S','-append');

