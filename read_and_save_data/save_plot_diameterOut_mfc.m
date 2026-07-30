%% REBECCA SHANNON
% take data from mfc post process cell diameter
% save as mat
% plot

workingDir = '/p/work1/rebshan/';

MachList = 2;
bubList = [100, 500];
probeList = [8, 9, 10];
ellipse = false;

if ellipse
    prefix = "el";
else
    prefix = "";
end

diameterData = struct();
loop = 1;

for mach = 1:length(MachList)
    for bub = 1:length(bubList)
        for probe = 1:length(probeList)
              
            caseName = strcat(prefix,'M',num2str(MachList(mach)),'B',num2str(bubList(bub)),'_200c_p',num2str(probeList(probe)));
            caseDir = strcat(workingDir,caseName,'.NARWHAL/');

            if ~isfolder(caseDir)
                fprintf('%s is not a directory\n',caseName)
                continue
            end

            fprintf('processing %s\n', caseName)
           
            % save data
            M = readmatrix(strcat(caseDir,'silo_hdf5/out_',caseName,'.NARWHAL_alpha01.csv'));

            tmp_diameter.name = caseName;
            tmp_diameter.time = M(2:end,2);
            tmp_diameter.horizontal = M(2:end,3);
            tmp_diameter.vertical = M(2:end,4);
            tmp_diameter.equator = M(2:end,5);
            tmp_diameter.centOfMass = M(2:end,6);
            tmp_diameter.leadingEdge = M(2:end,7);
            tmp_diameter.leadingEdgeEq = M(2:end,8);

            if loop == 1
                diameterData = tmp_diameter;
            else 
                diameterData(end+1) = tmp_diameter;
            end

            clear tmp_diameter
            loop = loop + 1;

        end
    end
end



    