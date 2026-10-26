%% REBECCA SHANNON
% 3/25/26
% new function to plt residuals from solver mod testing
% assumes that th einitial and final resids have been combined to a single
% file for each variable


startDir = '/p/work1/rebshan/semb_';

resVars = ["T","p_rgh"];
%caseName = "sod100";
caseList = {'3O1I','3O3I','6O1I','fixed'};
caseNameList = {'O3I1','O3I3','O6I1','fixed'};

for caseID = 1:length(caseList)

    caseName = caseList{caseID};

    T = readmatrix(sprintf('%s%s/logs/T_all',startDir,caseName),"FileType",'text');
    p = readmatrix(sprintf('%s%s/logs/p_rgh_all',startDir,caseName),"FileType",'text');
    
    outerLoops = width(T);
    innerLoops = width(p)/outerLoops;
    totalLoops = outerLoops * innerLoops;
    
    T_plot = reshape(T',[],1);
    p_plot = reshape(p',[],1);
    
    %T_count = linspace(1/outerLoops,size(T,1),size(T_plot,1));
    %p_count = linspace(1/innerLoops,size(p,1),size(p_plot,1));

    T_count = 0:1/outerLoops:size(T,1)-1/outerLoops;
    p_count = 0:1/totalLoops:size(p,1)-1/totalLoops;
    
    if caseID == 1
        figure(1)
        t = tiledlayout(length(resVars),1);
        ax1 = nexttile;
        ax2 = nexttile;
    end
    
    nexttile(1)
    hold(ax1,'on')
    plot(T_count,T_plot,'-*');
    
    xlim([2000 2005])
    title(sprintf('initial residuals for T'))
    set(gca,"YScale",'log')
    xticks(1:length(T_count))
    grid on
    xlabel('timestep number')
    
    nexttile(2)
    hold(ax2,'on')
    plot(p_count,p_plot,'-*');
    
    xlim([3000 3005])
    title(sprintf('initial residuals for p'))
    set(gca,"YScale",'log')
    grid on
    xticks(1:length(p_count))
    xlabel('timestep number')
    
end

title(t,strcat(caseName,', outer 3, inner 1'))
legend(caseList,'location','southoutside','NumColumns',length(caseList))

