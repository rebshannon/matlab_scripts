%% REBECCA SHANNON
% 3/25/26
% new function to plt residuals from solver mod testing
% assumes that th einitial and final resids have been combined to a single
% file for each variable


%cd('/projectnb/aeracous/REBECCA/solver_mod_testing/dwoTube_solverComp/fieldRel');
startDir = '/p/home/rebshan/vofFoam';

resVars = ["T","p_rgh"];
caseName = "shockTube/sod10";
caseList = {'compInterPTFoam','vofFoam','limVofFoam'};
figure
t = tiledlayout(length(resVars),1);
for var = 1:length(resVars)
    
    nexttile
    for CID = 1:length(caseList)
        
        clear M N
        M = readmatrix(sprintf('%s/%s/%s/logs/%s_all',startDir,caseName,caseList{CID},resVars(var)),"FileType",'text');
        N = reshape(M',[],1);
    % plot initial resids
   
        plot(N,'-*')
        hold on
    end

    xlim([4, 18])
    title(sprintf('initial residuals for %s',resVars(var)))
    set(gca,"YScale",'log')
    grid on
    %xticks([6,9,12,15,18])
    xlabel('iteration number')

    % plot final resids
    % figure
    % for n = 2:2:size(M,2) 
    %     semilogy(M(:,n))
    %     hold on
    % end
    % legend
    % title(sprintf('final residuals for /%s',resVars(var)))

    % plot all resids
    % figure
    % for n = 1:size(M,2) 
    %     semilogy(M(:,n))
    %     hold on
    % end
    % legend
    % title(sprintf('init residuals for /%s',resVars(var)))

 
end

title(t,strcat(caseName,', outer 3, inner 1'))
legend(caseList,'location','southoutside','NumColumns',length(caseList))