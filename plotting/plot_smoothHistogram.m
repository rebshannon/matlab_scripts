% Rebecca Shannon
% 8/12/2025

load /projectnb/aeracous/REBECCA/DOD_CAVSYM/postProcessing/daughterStats/cavSym_daughterDropStats.mat

edges = linspace(0,10,15);
leg = {'B4','B45'};%,'B4','B45'};
tstep = 0;

for i = 50:1:350
    tstep = tstep + 1;
    for bubble = 1:length(leg)
        %% B1 case
        % plot histogram without displaying
        figure(1)
        h = histogram(log(allDaughterDrops.(leg{bubble}){i}),'BinEdges',edges,'Visible','off');
    
        % extract histogram info
        centers = h.BinEdges(2:end) - h.BinWidth/2;
        height = h.Values;
        n = h.NumBins; % num bins
        w = h.BinWidth; % bin width
        t = h.BinEdges; % range
        p = fix(n/2); % integer of half the bins
        
        % find dt and cumulative sum
        dt = diff(t); % dt for integral
        Fvals = cumsum([0, height.*dt]);
        
        % make spline of cumulative sum and find 1st derivative
        F = spline(t,[0,Fvals,0]);
        DF = fnder(F);  % computes its first derivative
    
        %% B2 case
        % plot histogram without displaying
        figure(1)
        h2 = histogram(log(allDaughterDrops.B2{i}),'BinEdges',edges,'Visible','off');
    
        % extract histogram info
        cent2 = h2.BinEdges(2:end) - h2.BinWidth/2;
        height2 = h2.Values;
        n2 = h2.NumBins; % num bins
        w2 = h2.BinWidth; % bin width
        t2 = h2.BinEdges; % range
        p2 = fix(n2/2); % integer of half the bins
        
        % find dt and cumulative sum
        dt2 = diff(t2); % dt for integral
        Fvals2 = cumsum([0, height2.*dt2]);
        
        % make spline of cumulative sum and find 1st derivative
        F2 = spline(t2,[0,Fvals2,0]);
        DF2 = fnder(F2);  % computes its first derivative
    
        %% Plotting
        % plot derivative of the spline
        figure(1)
        legend(leg)
        [points(i).(leg{bubble})] = transpose(fnplt(DF, 1.5));
        %fnplt(DF, 1.5)
        hold on
        %ylim([0,140]);
%         ylims = ylim; 
%         ylim([0,ylims(2)]);
    end

    legend(leg)
    title({'Log of Size Distribution',strcat('Time = ',num2str(i),'\mus')})
    xlabel('Natural Log of Droplet Size')
    ylabel('Frequency')
    grid on
    hold off

    %drawnow
        
    pause(0.1)

end
