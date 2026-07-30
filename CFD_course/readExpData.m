load 110299_4_radius
radius = X110299_4_radius/25.4;
nu = 0.00016412;
dt = 60/7808/1430;
load(['sw_up_tr_u_v_w_30.mat'])

sampCycle = 1430;
cycles = 100;
time = [0:dt:dt*sampCycle*cycles];
df = 1/dt;
freqs = df*[0:(sampCycle*cycles-1)/2]/(sampCycle*cycles); %% ????

% 129 revs of 1430 points


%define cell to store variable names
var = {u1(:,1:cycles), v1(:,1:cycles), w1(:,1:cycles),...
    up1_2(:,1:cycles), sw1_2(:,1:cycles), tr1_2(:,1:cycles)};
%axial = u1
%tangential = v1
%radial = w1
%upwash = up1_2
%streamwise = sw1_2
%transverse = tr1_2

%% 1. Plot 100 revs of one velocity component - single time signal

for i = 1:3
    U_1D(i,:) = reshape(var{i},[1,sampCycle*cycles]);
end

    figure
    plot(time(1:end-1),U_1D(1,:))
    title('u1 Component of Velocity')
    xlabel('Time')
    ylabel('Velocity')
    grid on

%% 2. Plot ensemble average of a single rev for same component

for i = 1:3
    UMean(i,:) = mean(var{i},2);
end

figure
plot(time(1:sampCycle),UMean(1,:))
title('Mean of u1 Component of Velocity')
xlabel('Time')
ylabel('Velocity')
grid on

%% 3. Plot turbulence for same velocity component (100 revs)

UMean100Revs = repmat(UMean,[1,cycles]);
UTurb = U_1D - UMean100Revs;

meanTurb = mean(UTurb,2);

figure
plot(time(1:end-1),UTurb(1,:))
title('Turbulence of u1 Component of Velocity')
xlabel('Time')
ylabel('Turbulence')
grid on


%% 4. Overall average for all three components (100 revs)

% Umean = (u,v,w) components, mean
for i = 1:3
    UMeanTot(i) = mean(reshape(var{i},[sampCycle*cycles,1]));
end

%% 5. Turbulence intensity for u, v, w

for i = 1:3
    Urms(i) = rms(UTurb(i,:))
end

%% 6. TKE

TKE = 1/2 * sum(Urms.^2);

%% 7. fft of u1 component (semilogx without f = 0)

u1fft = fft(U_1D(1,:));

figure
semilogx(freqs(2:end),abs(u1fft(2:71500))/(1430*100))
grid on
ylabel('FFT of u1')
xlabel('Frequencies')
title('FFT of u1')


%% 8. fft of u1 ensemble average (semilogx without f = 0)

u1Meanfft = fft(UMean(1,:));

figure
semilogx(freqs(2:1430/2)*100,abs(u1Meanfft(2:1430/2))/(1430)) % mult by 100 for fewer samples
grid on
ylabel('FFT of the mean u1')
xlabel('Frequencies')
title('FFT of mean of u1')

%% 9. fft of u1 turbulence (semilogx)

u1Turbfft = fft(UTurb(1,:));

figure
semilogx(freqs,abs(u1Turbfft(1:end/2))/(1430*100))
grid on
ylabel('FFT of the turbulence u1')
xlabel('Frequencies')
title('FFT of turbulence of u1')

%% In class stuff, probably wrong
% % single mean value
% umean = mean(reshape(u1(:,1:100),[143000,1]));
% 
% % mean u1 for each rev 
% uMeanRev = mean(u1,2);
% 
% % plot mean rev and one normal rev
% figure(1)
% plot(uMeanRev)
% hold on
% plot(u1(:,1))
% legend('u mean','u first rev')
% title('Avg Velocity vs First Revolution')
% ylabel('u')
% grid on
% 
% % copies uMeanRev to a 100 column matrix (100 copies of uMeanRev)
% uMeanRevs = repmat(uMeanRev,[1,100]);
% 
% % subtract mean rev from total velocity to get turbulence
% uTurb = u1(:,1:100) - uMeanRevs;
% 
% % find average of uTurb - should be about 0
% uTurbMean = mean(uTurb,1);
% uTurbMeanVal = mean(uTurbMean);
% 
%% FFT
% u1D = reshape(u1,[1,1430*129]);
% 
% uFreq = fft(u1D);
% % do an fft
% plot(abs(uFreq(2:end/2))) % there is a peak here around the right spot
% df = 1/dt;
% freq = dt*[0:length(u1)-1/2]/length(u1) ;% ish
% % want a spike at 2860
% %plot(freq,abs(uFreq(1:end/2)))
% 
% plot(freq,abs(uFreq(2:1431)))
% 
% uFreq1=fft(u1(:,1));

% fft(entrie signal)
% fft(ensemble average)
% fft(turbulence)

%% 1D Method
% % find mean but on a 1D matrix
% % make u1 1D
% u1_1D = reshape(u1,[1,1430*129]);
% 
% % make uMeanRev into 1D
% uMeanRevs_1D = reshape(uMeanRevs,[1,143000]);
% 
% % 1D uTurb
% uTurb_1D = u1_1D(1:100*1430) - uMeanRevs_1D;
% 
% % avg turbulence
% uTurbMean_1D = mean(uTurb_1D);
% 

%% original code
% u1fft = fft(utot)';
% u1fft = [0 u1fft(2:22*W) 0 u1fft(22*W+2:22*W*2) 0 u1fft(22*W*2+2:22*W*3) 0 u1fft(22*W*3+2:22*W*4) 0 u1fft(22*W*4+2:end/2)];
% u1fft = [u1fft fliplr(u1fft)];
% u1scrub = ifft(u1fft,'symmetric');
% u1bprime = reshape((((u1scrub).^2)),BPF,H*W/BPF);
% u1bprime = sum(u1bprime')/(H*W/BPF);