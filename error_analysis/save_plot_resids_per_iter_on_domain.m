%% REBECCA SHANNON
% save all residuals printed to file
% residulas are printed by iteration number on the wholde domain
% shock tube application - solver_mod_testing/dwoTube 


home = '/projectnb/aeracous/REBECCA/solver_mod_testing/';
testCat = 'dwoTube_solverComp/';
caseName = 'cSqr';

workingDir = strcat(home,testCat,caseName);

cd(workingDir)
plotPoint = 96;
timeSteps = 10;


 cont0 = readmatrix('prePContErr.csv');
 cont1 = readmatrix("midContErr.csv");
 cont2 = readmatrix("massErr.csv");

% psi1 = readmatrix('psi1.csv');
% psi2 = readmatrix("psi2.csv");
    % prgh = readmatrix("p_rgh.csv");
% prgh0 = readmatrix("p_rgh0.csv");

xVal = linspace(0.25,16,64);
%xVal = linspace(0.25,8,32);
%xVal = linspace(-3.75,12,64);

figure
plot(xVal,abs(cont0(1:64,plotPoint)),'-*')
hold on
plot(xVal,abs(cont1(1:64,plotPoint)),'-*')
%plot(abs(cont2(1:16,plotPoint)),'-*')
plot(xVal,abs(cont2(1:64,plotPoint)),'-*')


grid on
set(gca,'yscale','log')
%xlim([4,8])
%xlim([0,4])
title({strcat(testCat,caseName),'continuity at shock'})
legend('before PISO','mid PSIO','after PISO')

% %% psi and pressure
% figure
% plot(xVal,abs(psi1(1:64,plotPoint)),'-*')
% hold on
% plot(xVal,abs(psi2(1:64,plotPoint)),'-*')
% %plot(abs(cont2(1:16,plotPoint)),'-*')
% 
% yyaxis right
% plot(xVal,abs(prgh0(1:64,plotPoint)),'-*')
% plot(xVal,abs(prgh(1:64,plotPoint)),'-o')
% 
% grid on
% %set(gca,'yscale','log')
% %xlim([4,8])
% %xlim([0,4])
% title({strcat(testCat,caseName),'pressure/psi at shock'})
% legend('rho1','rho2','prgh0','prgh')