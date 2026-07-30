%% REBECCA SHANNON
% 3/25/26
% new function to plt residuals from solver mod testing
% assumes that th einitial and final resids have been combined to a single
% file for each variable


%cd('/projectnb/aeracous/REBECCA/solver_mod_testing/dwoTube_solverComp/fieldRel');

resVars = ["T","p_rgh"];
caseName = "dwoTube";
figure
t = tiledlayout(2,1);
for var = 1:length(resVars)
    M = readmatrix(sprintf('interTwoPhaseCentralFoam/%s/logs/%s_all',caseName,resVars(var)),"FileType",'text');
    N = reshape(M',[],1);
    % plot initial resids

    M2 = readmatrix(sprintf('vofTwoPhaseCentralFoam/%s/logs/%s_all',caseName,resVars(var)),"FileType",'text');
    N2 = reshape(M2',[],1);
    
    % for n = 1:2:size(M,2) 
    %     semilogy(M(:,n))
    %     hold on
    % 
    % end
    nexttile
    plot(N,'-*')
    hold on
    plot(N2,'-*')
    xlim([4, 18])
    legend('inter','vof')
    title(sprintf('initial residuals for %s',resVars(var)))
    set(gca,"YScale",'log')
    grid on
    xticks([6,9,12,15,18])
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

    clear M M2
end

title(t,strcat(caseName,', outer 3, inner 1'))