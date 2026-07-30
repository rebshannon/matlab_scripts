%% Rebecca Shannon
% 8/27/25
% plot matrix of probe pressure - time vs location and color is the
% pressure
% 0 = shock, 1 = spark


%% IC
load /p/home/rebshan/benchmarking/sembianBenchmarks.mat
%load /p/home/rebshan/benchmarking/aiaaBenchmarks.mat

tstepEnd = 58; % must be the minumum for all the cases you're comparing
timestep = 1e-6;
rhoLiq = 1000;
diam = 0.022;
c = 1503.2; % speed of sound

% set t0 = when the shock reaches the leading edge of the droplet
tstep0 = [243,199];
%tstep0 = [116, 119]
myCase = {'Shock IC','Spark IC'};

% choose your data
%shock
data2D(1,:) = semb_shock_DOD_2D;
dataAS(1,:) = semb_shock_DOD_axisym;

%spark
data2D(2,:) = semb_spark_DOD_2D;
dataAS(2,:) = semb_spark_DOD_axisym;


%% INITIAL CALCS

% Rayleigh time
tc2_2D(:) = sqrt(rhoLiq ./ [data2D(:,1).rho2]) .* diam ./ [data2D(:,1).U2LF];
tc2_AS(:) = sqrt(rhoLiq ./ [dataAS(:,1).rho2]) .* diam ./ [dataAS(:,1).U2LF];

for i = 1:2
    % find nondimensional time
    t2D(:,i) = [data2D(i,1).time(tstep0(i):tstep0(i)+tstepEnd)]./ tc2_2D(i);
    tAS(:,i) = [dataAS(i,1).time(tstep0(i):tstep0(i)+tstepEnd)]./ tc2_AS(i);
    
    % time padding
    tq(:,i) = linspace((tstep0(i)-1)*timestep, (tstep0(i)-1+tstepEnd)*timestep, 100);
end

tq2D = tq ./ tc2_2D;
tqAS = tq ./ tc2_AS;

% x padding sme for both
xLoc = linspace(-diam/2*0.8, diam/2*0.8, 9);
xq = linspace(-diam/2*0.8,diam/2*0.8,100);

mat2D = zeros(length(tq),length(data2D)-1,2);
matAS = zeros(length(tq),length(dataAS)-1,2);
plot2D = zeros(length(tq2D),length(xq),2);
plotAS = zeros(length(tqAS),length(xq),2);

%% REARRANGING HERE
% put pressure data into matrix form
% pad time as you go
for i = 1:2
    for loc = 2:10
        mat2D(:,loc-1,i) = interp1(t2D(:,i),data2D(i,loc).p(tstep0(i):tstep0(i)+tstepEnd),tq2D(:,i));
        matAS(:,loc-1,i) = interp1(tAS(:,i),dataAS(i,loc).p(tstep0(i):tstep0(i)+tstepEnd),tqAS(:,i));
    end

    % interpolate to get smoother plots
    for tStep = 1:length(tq)
        plot2D(tStep,:,i) = interp1(xLoc,mat2D(tStep,:,i),xq);
        plotAS(tStep,:,i) = interp1(xLoc,matAS(tStep,:,i),xq);
    end

end

% nondim xLoc and time
plotX = xq/diam*2;

%% PLOTTING

% for limits
maxLim = max([plot2D/101000,plotAS/101000],[],'all');
minLim = min([plot2D/101000,plotAS/101000],[],'all');

plotTime2D = tq2D .* tc2_2D * c / diam;
plotTimeAS = tqAS .* tc2_AS * c / diam;

for i = 1:2
    figure
    imagesc(plotX,plotTime2D(:,i)-plotTime2D(1,i), plot2D(:,:,i)/101000)
    set(gca,'YDir','normal')
    colormap(turbo)
    
    ylabel('t*','fontsize',16)
    ylim([0 2])
    xlabel('x*','fontsize',16)
    clim([minLim,maxLim])
    title(strcat(myCase{i},' 2D'),'fontsize',16)
    
    figure
    imagesc(plotX,plotTimeAS(:,i)-plotTimeAS(1,i), plotAS(:,:,i)/101000)
    set(gca,'YDir','normal')
    colormap(turbo)
    
    ylabel('t*','fontsize',16)
    ylim([0 2])
    xlabel('x*','fontsize',16)
    clim([minLim,maxLim])
    title(strcat(myCase{i},' Axisymmetric'),'fontsize',16)
end

%% DIFFERENCE

time_diff_2D = tq2D(:,1) * tc2_2D(1);
time_diff_AS = tqAS(:,1) * tc2_AS(1);

figure
imagesc(plotX,mean(plotTime2D,2)-mean(plotTime2D(1,:)), (plot2D(:,:,1)-plot2D(:,:,2))/101000)
set(gca,'YDir','normal')
colormap(turbo)
ylim([0 2])

ylabel('t*','fontsize',16)
xlabel('x*','fontsize',16)
title('2D Difference','fontsize',16)
clim('auto')

figure
imagesc(plotX,mean(plotTimeAS,2)-mean(plotTime2D(1,:)), (plotAS(:,:,1)-plotAS(:,:,2))/101000)
set(gca,'YDir','normal')
colormap(turbo)

ylim([0 2])
ylabel('t*','fontsize',16)
xlabel('x*','fontsize',16)
clim('auto')
title('Axisymetric Difference','fontsize',16)