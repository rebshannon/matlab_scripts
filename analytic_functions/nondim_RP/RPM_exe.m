NSLOTS=str2num(getenv('NSLOTS')); 
maxNumCompThreads(NSLOTS); %don't go over requested # of cores
%% Rayleigh Plesset (Noltingk - Neppiras - Poritsky)
% Ankush Gupta
% ME721 Fall 2017
% Boston University
close all
%clear

% Plots the radius vs time for 3 different sized bubbles
% Change y0 for each case to change the maximum radiu
% Maximum radius would be the starting point
% Constants are input in the ODE function - RMP.m
% saves R vs t to mat file **comment out if not needed**

%% RP Equation
Pa = -70000;       % Initial acoustic excitation (leave zero if nothing is going on)
R0 = 10e-6;   % Equilibrium radius


%% 1st Plot
tspan = [0 30e-6]; %time 0.0015
y0 = [1, 0];      %maximum radius = R0 * y0 [nondimensionalized]

opts = odeset('Reltol',1e-9,'AbsTol',1e-9,'Stats','on'); %Reltol originally 1e-9
[t,y] = ode45(@RPM,tspan,y0,opts,Pa,R0);            % This is the RP ODE solver

%% Plotting
%subplot(3,1,1);
figure
plot(t,y(:,1),'linewidth',1.5)
ylabel('R/R_0','FontSize',18)
xlim([0 10e-6])
legend({'R_{max} = 1.3*R_0'},'Location','northeast')

% ylabel('R/R_0','FontSize',18)
xlabel('Time in \mus','FontSize',14)
% grid off
% xlim([0 50])

% plot radius
% radius = y(:,1)*R0;
% plot(t,radius)
% hold on
% plot(time_OF,radius_OF);


%% Saving
% %save data to mat file
% S.t=t(1:11500);
% S.y=y(1:11500,1);
% save('Ro_13micron_Re_10micron','-struct','S');

% %wrte data to csv
% rows=size(radius,1);
% fid=fopen('radius_RP_initial_100dydt.csv','w');    %file to write in
% fprintf(fid,'time, radius\n');        %headers
% for i=1:rows
%     fprintf(fid,'%.1e, %.8e\n',t(i),radius(i));
% end


%% Loading
% %read contants of final csv file
% M = readmatrix('../tutorials/compInterFoam_tutorial10/radius/radius_OF.csv');%%
% time_OF=M(:,1);
% radius_OF=M(:,2);
%  
%% Extra
%%% 2nd Plot
% tspan = [0 0.0015];
% y0 = [2, 0];
% 
% opts = odeset('Reltol',1e-9,'AbsTol',1e-9,'Stats','on');
% [t,y] = ode45(@RPM,tspan,y0,opts,Pa,R0);
% 
% 
% subplot(3,1,2); 
% plot(t*1E6,y(:,1),'linewidth',1.5)
% ylabel('R/R_0','FontSize',18)
% xlim([0 50])
% legend({'R_{max} = 2*R_0'},'Location','northeast')
% 
% %% 3rd Plot
% tspan = [0 0.0015];
% y0 = [10, 0];
% 
% opts = odeset('Reltol',1e-9,'AbsTol',1e-9,'Stats','on');
% [t,y] = ode45(@RPM,tspan,y0,opts,Pa,R0);
% 
% subplot(3,1,3); 
% plot(t*1E6,y(:,1),'linewidth',1.5)
% ylabel('R/R_0','FontSize',18)
% xlabel('Time in \mus','FontSize',18)
% grid off
% xlim([0 50])
% legend({'R_{max} = 10*R_0'},'Location','northeast')
% 

% radius=y(:,1)*R0*1e6;
% time=t;
% plot(time,radius)
% grid on
% ylabel('Radius (\mum)','FontSize',14)
% %xlim([0 2.5e-10])
% xlabel('Time (s)','FontSize',14)