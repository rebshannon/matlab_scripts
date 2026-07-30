%% Rebecca Shannon
% load single line grahp data from cavity tutorials and plot

% cd /projectnb/am423/rshannon/cavityTuts


%% Load .xy files

% Choose case
%myDir = uigetdir; % choose directory with data
myHome = '/projectnb/turbomac/REBECCA/';
myCase = 'negP/analyticSolns/oscilInletBC/waveTracking/'; 
postProcessing = ['oneWave_PTFoam/oneWave_waterToAir/postProcessing/singleGraph/renumbered'];


myDir = strcat(myHome,myCase,postProcessing);
myFiles = dir(fullfile(myDir)); % get every csv file
numTimeSteps = length(myFiles);


%caseName = ['analyticSolns/oscilInletBC/waveTracking/oneWave_waterToAir'];
cd(myDir);

loop = 1;

%timeList = genAllTimesCell(tend);

for j = 3:numTimeSteps

        % no rho in 0 timestep so add that here
        
        if myFiles(j).name == '0'

            MTpRho = readmatrix(strcat(myFiles(j).name,"/line_T_p.xy"),'FileType','text'); % MTp = [x T p rho]
            rho(:,loop) = zeros(length(MTpRho),1);

        else

            MTpRho = readmatrix(strcat(myFiles(j).name,"/line_T_p_rho.xy"),'FileType','text'); % MTp = [x T p rho]
            rho(:,loop) = MTpRho(:,4);

        end

    
        Mu = readmatrix(strcat(myFiles(j).name,"/line_U.xy"),'FileType','text'); % Mu = [x Ux Uy Uz]

        x(:,loop) = Mu(:,1);
        Ux(:,loop) = Mu(:,2);
        %UyP(:,loop) = Mu(:,3);
        %UzP(:,loop) = Mu(:,4);
        T(:,loop) = MTpRho(:,2);
        p(:,loop) = MTpRho(:,3);
      
        loop = loop +1;

end

maxP = max(abs(p - 1e5), [], 1);
minP = min(p,[],1);

matName = strcat(myHome,myCase,'anylSolns.mat');
waterToAir_t1e6_x1e3_PT = struct('p',p,'rho',rho,'T',T,'Ux',Ux,'x',x,'maxP',maxP);
save(matName,'waterToAir_t1e6_x1e3_PT','-append');


%% Plotting

% 
% figure
% plot(x(:,1),Ux(:,1),x(:,2),Ux(:,2))%,x,Ux(:,3),x,Ux(:,4))
% xlabel('x')
% ylabel('Ux')
% grid on
% title('Velocity (u) at x = 0.1')%, t = 0.5')
% legend('20 cells','30 cells','40 cells')
% 
% figure
% plot(x(:,1),Uy(:,1),x(:,2),Uy(:,2))%,x,Uy(:,3),x,Uy(:,4))
% xlabel('x')
% ylabel('Uy')
% grid on
% title('Velocity (v) at x = 0.1')%, t = 0.5')
% legend('20 cells','30 cells','40 cells')
% 
% figure
% plot(x(:,1),p(:,1),x(:,2),p(:,2))%,x,p(:,3),x,p(:,4))
% xlabel('x')
% ylabel('p')
% grid on
% title('Pressure (p) at x = 0.1')%, t = 0.5')
% legend('20 cells','30 cells','40 cells')


%% New Plotting

% % Ux
% figure
% plot(x(:,1),Ux(:,1),'Color','b')
% hold on
% plot(x(:,2),Ux(:,2),'.','Color','b')
% 
% % plot(x(:,3),Ux(:,3),'Color','r')
% % plot(x(:,4),Ux(:,4),'.','Color','r')
% % 
% % plot(x(:,5),Ux(:,5),'Color','y')
% % plot(x(:,6),Ux(:,6),'.','Color','y')
% 
% xlabel('x (m)')
% ylabel('Ux (m/s)')
% grid on
% title('Velocity (u) at x = 0.05')%, t = 0.5')
% %legend('Re = 10, Coarse','Re = 10, Fine','Re = 100, Coarse','Re = 100, Fine',...
%  %   'Re = 1000, Coarse','Re = 1000, Fine','Location','southwest')
% legend('120 Cells','160 Cells','120 Cells, k-epsilon','Location','southwest')
% 
% % Uy
% figure
% 
% plot(x(:,1),Uy(:,1),'Color','b')
% hold on
% plot(x(:,2),Uy(:,2),'.','Color','b')
% 
% % plot(x(:,3),Uy(:,3),'Color','r')
% % plot(x(:,4),Uy(:,4),'.','Color','r')
% % 
% % plot(x(:,5),Uy(:,5),'Color','y')
% % plot(x(:,6),Uy(:,6),'.','Color','y')
% 
% xlabel('x (m)')
% ylabel('Uy (m/s)')
% grid on
% title('Velocity (v) at x = 0.05')%, t = 0.5')
% %legend('Re = 10, Coarse','Re = 10, Fine','Re = 100, Coarse','Re = 100, Fine',...
%  %   'Re = 1000, Coarse','Re = 1000, Fine','Location','southwest')
% legend('120 Cells','160 Cells','120 Cells, k-epsilon','Location','southwest')
% 
% % p
% figure
% 
% plot(x(:,1),p(:,1),'Color','b')
% hold on
% plot(x(:,2),p(:,2),'.','Color','b')
% 
% % plot(x(:,3),p(:,3),'Color','r')
% % plot(x(:,4),p(:,4),'.','Color','r')
% % 
% % plot(x(:,5),p(:,5),'Color','y')
% % plot(x(:,6),p(:,6),'.','Color','y')
% 
% xlabel('x (m)')
% ylabel('p (Pa)')
% grid on
% title('Pressure at x = 0.05')%, t = 0.5')
% %legend('Re = 10, Coarse','Re = 10, Fine','Re = 100, Coarse','Re = 100, Fine',...
%  %   'Re = 1000, Coarse','Re = 1000, Fine','Location','northwest')
% legend('120 Cells','160 Cells','120 Cells, k-epsilon','Location','southwest')
