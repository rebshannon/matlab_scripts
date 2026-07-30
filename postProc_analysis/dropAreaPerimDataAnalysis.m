% Rebecca Shannon
% 6/19/24
% read area and perimeter data from fiji images

%clear

%% LOAD AND DEFINE VARIABLES

U = 267;            % choose velocity
BID = 21; % choose bubble IDs

addpath /projectnb/turbomac/REBECCA/cavSym2024/areaPerimData/
addpath /projectnb/aeracous/REBECCA/DOD_CAVSYM/postProcessing/daughterStats/
addpath /projectnb/turbomac/REBECCA/matlab/

load 'U100_perim_bubArea.mat'

dataHere = daughterStats(5).primaryDropSize(1:340);

%PERIM

%% FIND CHANGEPOINTS FOR AREA

% for ID = 1:2
% 
%     resid = 1;
%     dResid = 1;
%     chgpts = 0;
% 
%     while dResid > 1e-14
%     
%         resid0 = resid;
%         chgpts = chgpts + 1;
%         
%         [itp,resid] = findchangepts(liqArea(1:tend,ID),MaxNumChanges=chgpts);
%         dResid = resid0 - resid;
%         
%     end
%     
%     figure
%     findchangepts(liqArea(1:tend,ID),MaxNumChanges=chgpts)
%     grid on
%     xlabel('Time (s)')
%     ylabel('Area (m^2)')
% 
% end

%% FIND CHANGEPOINTS FOR PERIMETER

for ID = BID

    resid = 1;
    dResid = 1;
    chgpts = 0;
    
    while dResid > 1e-15
        
        chgpts = chgpts + 1;
        resid0 = resid;


        [itp,resid] = findchangepts((dataHere),MaxNumChanges=chgpts,Statistic="linear",MinDistance=10);
        dResid = resid0 - resid;

        %allResid(ID,chgpts) = resid;
                
    end
    
    figure
    findchangepts(((dataHere)),MaxNumChanges=chgpts,Statistic="linear",MinDistance=10)
    grid on
    xlabel('Time (\mus)')
    ylabel('Perimeter (m)')

end