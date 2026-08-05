%% REBECCA SHANNON
%  8/3/2026

% plot results from single line with analytic results
% figure showing analytic result should already b emade
% load mat file
% make sure the variables coincide with the figures 

% used in conjunction with sod_sheryl and read_singleGraph_postProc

load /p/home/rebshan/vofFoam/shockTube/sod100/sod100_singleGraph.mat

figure(1)
hold on
plot(cIPTFoam.x,cIPTFoam.U)
plot(vofFoam.x,vofFoam.U)
%plot(limVofFoam.x,limVofFoam.U)

figure(2)
hold on
plot(cIPTFoam.x,cIPTFoam.p)
plot(vofFoam.x,vofFoam.p)
%plot(limVofFoam.x,limVofFoam.p)

figure(3)
hold on
plot(cIPTFoam.x,cIPTFoam.rho)
plot(vofFoam.x,vofFoam.rho2)
%plot(limVofFoam.x,limVofFoam.rho2)

for i = 1:3
figure(i)
legend('analytic','compInterPTFoam','vofFoam','limVolFoam')
xlabel('time')
xlabel('x location')
grid on
title({'sod10vel, t = 3.9ms','pressure'})
end