%% REBECCA SHANNON
% 1/28/2026
% read output from surfaces function object and save as mat


%% SET UP

% Choose case
caseHome = '/p/work1/rebshan/';
caseName = '2D_DS6_smallTest';
caseID = 'surf_cpd400_small_2D'; % for saving
alphaList = {'01','99'};

saveTo = '~/official_vof_cases/DS6_verif/DS6_verif.mat';


for a = 1:length(alphaList)

    alpha = alphaList{a};

    % move to dir
    cd(strcat(caseHome,caseName,'/postProcessing/surface',alpha));
    alpha = strcat('a',alphaList{a});

    % Get list of all directories in current folder
    current_dir = pwd;
    dir_contents = dir(current_dir);
    
    % Filter for directories only (exclude '.' and '..')
    dirs = dir_contents([dir_contents.isdir] & ~ismember({dir_contents.name}, {'.', '..'}));
    
    % Initialize storage for data
    % Initialize struct array to store data
    data_struct.(alpha) = struct('time', []);
    count = 1;
    
    %% READ ALL SURFACE DATA
    % based on timesteps present in singleGraph dir
    
    % read first matrix
    
    for i = 1:length(dirs)
        
        dir_name = dirs(i).name;
        dir_path = fullfile(current_dir,dir_name);
        
        % Try to convert directory name to number (timestep)
        time = str2double(dir_name);
        
        % Skip if directory name is not a valid number
        if isnan(time)
            continue;
        end
        
        % List files
        files = dir(fullfile(dir_path, '*'));
        files = files(~[files.isdir]);
    
        fprintf('Processing directory: %s (t = %e)\n', dir_name, time);
    
        % Read data from each file in this timestep directory
        for j = 1:length(files)
            try
                fName = files(j).name;
                file_path = fullfile(dir_path, fName);
    
                % get names of the variable printed
                var = split(fName,["_"]);
                var = var{1};
                
                data = readmatrix(file_path, 'FileType','text');
                
                if j == 1
                
                    % read time, x,y,z
                    data_struct.(alpha)(i).time = time;
                    data_struct.(alpha)(i).x = data(:,1);
                    data_struct.(alpha)(i).y  = data(:,2);
                    data_struct.(alpha)(i).z  = data(:,3);
    
                end
    
                if var == 'p'
                    % read pressure
                    data_struct.(alpha)(i).p = data(:,4);
                elseif var == 'U'
                    % read velocity
                    data_struct.(alpha)(i).Ux = data(:,4);
                    data_struct.(alpha)(i).Uy = data(:,5);
                    data_struct.(alpha)(i).Uz = data(:,6);
                else
                    % if I add another scalar
                    data_struct.(alpha).(var) = data(:,4);
                end
    
            catch
                % Skip files that can't be read
            end
        end
    end
    
    % Sort by timestep
    [sorted_timesteps, idx] = sort([data_struct.(alpha).time]);
    data_struct.(alpha) = data_struct.(alpha)(idx);
    
    
    fprintf('\n=== Summary ===\n');
    fprintf('For alpha = %s\n',alpha);
    fprintf('Total timesteps found: %d\n', length([data_struct.(alpha).time]));
end

assignin('base',caseID,data_struct)

if isfile(saveTo)
    save(saveTo,caseID,'-append')
else
    save(saveTo,caseID)
end