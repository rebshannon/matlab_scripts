%% Rebecca Shannon
% 10/11/24
% get volume data from DOD cases

%% CASE LOCATION

fileLocation = '/projectnb/aeracous/REBECCA/newMeshingIdeas/AMR/DOD_meshDensity';
cd(fileLocation)

loop = 1;

% Info for for loops
cells = [200, 300, 400];
RMD = [2, 3, 5];
fileExt = {'_preProc_vol.dat','_biggerBox_preProc_vol.dat'};%'_vol.dat',

%% LOOP THROUGH FILES

for fileExtID = 1:length(fileExt)
    for cellID = 1:length(cells)
        for RMDID = 1:length(RMD)

            fileName = strcat(num2str(cells(cellID)),'cells_',num2str(RMD(RMDID)),'xRMD',string(fileExt{fileExtID}));
            
            % if file exists, read and import data to structure
            if exist(fileName,'file') == 2
            
                A = importdata(fileName);
                [pathstr,name,ext]=fileparts(fileName);

                AMR_meshStudy(loop).caseName = name;
                AMR_meshStudy(loop).time = A.data(:,1);
                AMR_meshStudy(loop).waterVol = A.data(:,2);
                AMR_meshStudy(loop).airVol = A.data(:,3);
                AMR_meshStudy(loop).totVol = A.data(:,2) + A.data(:,3);
                
                loop = loop + 1;
                
            end
        end
    end
end