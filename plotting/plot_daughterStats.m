% Rebecca Shannon
% 8/13/2025

load /projectnb/aeracous/REBECCA/DOD_CAVSYM/postProcessing/daughterStats/cavSym_daughterDropStats.mat

var = {'numDaughter'};
bubbles = {'B1','B2','B3','B4','B45','B2b','B7'};
bubInd = 2:7;


for j = 1:length(var)
    
    for i = bubInd
        figure
        %plot(smooth((daughterStats(i).(var)-daughterStats(1).(var))./daughterStats(1).(var)))
            %/max(daughterStats(i).(var)))
        %plot(smooth(daughterStats(i).(var{j})/max(daughterStats(i).(var{j}))),'LineWidth',1.5)
        plot(smooth(daughterStats(1).(var{j})),'LineWidth',1.5)
        hold on
        plot(smooth(daughterStats(i).(var{j})),'LineWidth',1.5)
        yyaxis right
        plot(bubbleArea.(bubbles{i}),'LineWidth',1.5)
  

    
legend(bubbles{bubInd})
title(strcat(var))
xlabel('Time, s')
ylabel('Size, pixels')
grid on
    end

end

