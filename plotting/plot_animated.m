%% REBECCA SHANNON
% 10/29/24
% Make an animated line plot based on time series data

% load mat
%load tFoam_centerLineDat.mat

edges = linspace(0,10,15);
leg = {'150 cells','400 cells','lim'};%,']B4','B45'};
tstep = 0;

for i = 1:10
        figure(1)
        set(gcf, 'Position', [100, -100, 800, 600]); % Adjust figure size
        set(gcf, 'Color', 'w'); % Set background color to white
%     
%         histogram(log(allDaughterDrops.(leg{bubble}){i}),'BinEdges',edges);
%         hold on
%         histogram(log(allDaughterDrops.(leg{bubble}){i}),'BinEdges',edges);
%         histogram(log(allDaughterDrops.(leg{bubble}){i}),'BinEdges',edges);

    
    plot(interPTFoam(i).x(1:400),interPTFoam(i).p(1:400))
    hold on
    plot(compInter(i).x(1:400),compInter(i).p(1:400))
    plot(vofLim3(i).x(1:400),vofLim3(i).p(1:400))

    title({'Pressure along Drop Equator',strcat('Timestep = ',num2str(i))})
    legend(leg)
    xlabel('Location, m')
    ylabel('Pressure, Pa')
    
    hold off

%     %subplot(3,1,1)
%     plot(U267D2B2_SCC.x(:),U267D2B2_SCC.p(:,i+1));
%     hold on
%     %plot(U267D2B2_DOD_r8.x(:),U267D2B2_DOD_r8.p(:,i));
%     title(['Pressure, t = ',num2str(i)])
%     hold off
% 
%     subplot(3,1,2)
%     plot(U267D2B2_SCC.x(:),U267D2B2_SCC.T(:,i+1));
%     hold on
%     %plot(U267D2B2_DOD_r8.x(:),U267D2B2_DOD_r8.T(:,i));
%     title('Temperature')
%     hold off

%     subplot(3,1,3)
%     plot(U267D2B2_SCC.x(:),U267D2B2_SCC.rho(:,i));
%     hold on
%     plot(U267D2B2_DODr8.x(:),U267D2B2_DODr8.rho(:,i));
%     title('Density')
%     hold off

        xlim([-0.000635, 0.000635])
        ylim([-6e6, 6.5e6])

    
    drawnow
        
    pause(0.5)

end


h = animatedline;
axis([0,10,-1,160])
leg = {'B1','B4','B45'};%,'B4','B45'};

x = distSize_fnPoints(50).B1(:,1);

for k = 1:length(x)
    clearpoints(h)
    for bubble = 1:length(leg)
            addpoints(h,x,distSize_fnPoints(k+49).(leg{bubble})(:,2))
    end
    drawnow
    pause(0.1)
end