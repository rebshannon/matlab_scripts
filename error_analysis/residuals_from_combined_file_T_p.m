%% REBECCA SHANNON
% 3/25/26
% new function to plt residuals from solver mod testing
% assumes that th einitial and final resids have been combined to a single
% file for each variable


startDir = '/p/home/rebshan/limTaitPisoTesting';

resVars = ["T","p_rgh"];
caseName = "sod100";
caseList = {'sod100'};%{'compInterPTFoam','vofFoam','scc_CIPT'};

T = readmatrix(sprintf('%s/%s/logs/T_all',startDir,caseName),"FileType",'text');
p = readmatrix(sprintf('%s/%s/logs/p_rgh_all',startDir,caseName),"FileType",'text');

outerLoops = width(T);
innerLoops = width(p)/outerLoops;

T_plot = reshape(T',[],1);
p_plot = reshape(p',[],1);

T_count = linspace(1,size(T,1),size(T_plot,1));
p_count = linspace(1,size(p,1),size(p_plot,1));

% figure
% t = tiledlayout(length(resVars),1);
% ax1 = nexttile;
% ax2 = nexttile;

nexttile(1)
hold(ax1,'on')
plot(T_count,T_plot,'-*');

xlim([10 20])
title(sprintf('initial residuals for T'))
set(gca,"YScale",'log')
xticks([10:20])
grid on
xlabel('timestep number')

nexttile(2)
hold(ax2,'on')
plot(p_count,p_plot,'-*');

xlim([10 20])
title(sprintf('initial residuals for p'))
set(gca,"YScale",'log')
grid on
xticks([10:20])
xlabel('timestep number')


%title(t,strcat(caseName,', outer 3, inner 1'))
%legend(caseList,'location','southoutside','NumColumns',length(caseList))

