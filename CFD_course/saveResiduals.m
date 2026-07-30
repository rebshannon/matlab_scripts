%% REBECCA SHANNON
% 4/2/24
% Read and plot residuals from logs directory

clear

cd('/projectnb/aeracous/REBECCA/solver_mod_testing/alphaEqn_test/fedkiw');
%resVar = {'Time_0' 'Ux_0' 'Uy_0' 'p_0' 'p_1'};
resVar = {'Time_0' 'p_rghFinalRes_0' 'p_rghFinalRes_1' 'p_rghIters_0' 'p_rghIters_1' 'p_rgh_0' 'p_rgh_1' 'deltaT_0'};
%resVar = {'Time_0' 'CourantMax_0' 'CourantMax_1' 'CourantMean_0' 'CourantMean_1' 'IntCourantMax_0' 'IntCourantMean_0'};
%resVar = {'Time_0' 'alpha.water_0' 'alpha.water_1' 'alpha.waterIters_0' 'alpha.waterIters_1' 'alpha.waterFinalRes_0' 'alpha.waterFinalRes_1'};
resVar = {'Time_0' 'TFinalRes_0' 'TIters_0' 'T_0'};

for i = 1:length(resVar)
    resid = readmatrix(sprintf('logs/%s',resVar{i}),'FileType','text');
    residuals(:,i) = resid(:,2);
end

%% PLOTTING

figure

for i = 2:length(resVar)
    
    semilogy(residuals(:,1),residuals(:,i))
    hold on
end

    legend('FinalRes 0','FinalRes 1','Iter 0','Iter 1', '0','1','deltaT','location','southeast')
    %legend('Max 0','Max 1', 'Mean 0', 'Mean 1', 'Int Max', 'Int Mean','location','east')
    %legend('water 0','water 1','iter 0','iter 1','final 0','final 1')
    %legend('FinalRes','Iters','0','deltaT')
    xlabel('Time (s)')
    ylabel('Residuals')
    %title('Residuals in U267 D2 B2 PTFoam')
    grid on
