%% Rebecca Shannon
% 8/27/25
% plot matrix of probe pressure - time vs location and color is the
% pressure


load /projectnb/aeracous/REBECCA/benchmarks/sembian/sembianBenchmarks.mat
%load /p/home/rebshan/benchmarking/aiaaBenchmarks.mat

% set t0 = when the shock reaches the leading edge of the droplet
t0 = 201e-6; % star 0.000232775;
tStep0 = 809;%202; % star 809;
tStepEnd = 1000;%239; % star 1000; % must be the minumum for all the cases you're comparing
rhoLiq = 1000;
diam = 0.022;
myCase = 'Semb Spark Star';
c_l = 1498; % speed of sound in water at 300K

% choose your data
data2D = semb_spark_star_2D;
dataAS = semb_spark_star_axisym;

% Rayleigh time
% tc2_2D = sqrt(rhoLiq / data2D(1).rho2) * diam / data2D(1).U2LF;
% tc2_AS = sqrt(rhoLiq / dataAS(1).rho2) * diam / dataAS(1).U2LF;

% Acoustic time
tc2_2D = diam / c_l;
tc2_AS = diam / c_l;

% find nondimensional time
t2D = data2D(1).time(tStep0:end) / tc2_2D;
tAS = dataAS(1).time(tStep0:end) / tc2_AS;

% time padding
% tq = linspace((tStep0-1)*1e-6, (tStep0-1+tStepEnd)*1e-6, 100);
% tq2D = tq ./ tc2_2D;
% tqAS = tq ./ tc2_AS;

% no padding
tq2D = t2D(tStep0:tStepEnd) ./ tc2_2D;
tqAS = tAS(tStep0:tStepEnd) ./ tc2_AS;

% x padding
xLoc = linspace(-diam/2*0.8, diam/2*0.8, 9);
xq = linspace(-diam/2*0.8,diam/2*0.8,length(tq2D));

mat2D = zeros(length(xq),length(data2D)-1);
matAS = zeros(length(xq),length(dataAS)-1);
plot2D = zeros(length(tq2D),length(xq));
plotAS = zeros(length(tqAS),length(xq));

% put pressure data into matrix form
% pad time as you go
% for loc = 2:10
%     mat2D(:,loc-1) = interp1(t2D,data2D(loc).p(tStep0:end),tq2D);
%     matAS(:,loc-1) = interp1(tAS,dataAS(loc).p(tStep0:end),tqAS);
% end

% not padding time
for loc = 2:10
    mat2D(:,loc-1) = data2D(loc).p(tStep0:tStepEnd);
    matAS(:,loc-1) = dataAS(loc).p(tStep0:tStepEnd);
end


% interpolate to get smoother plots
for tStep = 1:length(xq)
    plot2D(tStep,:) = interp1(xLoc,mat2D(tStep,:),xq);
    plotAS(tStep,:) = interp1(xLoc,matAS(tStep,:),xq);
end


% nondim xLoc and time
plotX = xq/diam*2;

figure
imagesc(plotX,tq2D-tq2D(1), plot2D/101325)
set(gca,'YDir','normal')
colormap(turbo)

ylabel('\tau')
xlabel('x*')
title(strcat(myCase,' 2D'))

figure
imagesc(plotX,tqAS-tqAS(1), plotAS/101325)
set(gca,'YDir','normal')
colormap(turbo)

ylabel('\tau')
xlabel('x*')
title(strcat(myCase,' Axisymmetric'))