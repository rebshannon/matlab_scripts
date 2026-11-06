%% Rebecca Shannon
% 7/11/25
% read data from singleGraph and save to mat

% need to change
    % 1. caseLoc
    % 2. save structure name
    % 3. save structure location (at end)

%clear colNum i myStructure p rho t* T x writeInterval
%clc

%% NOTE: NEED TO CHANGE MAT AND STRUCTURE NAMES BELOW
% also need to set the case name
% note that each row is a new time
% time = row - 1 (starts at 0)

%% INITIAL SETTINGS

% Choose case
caseHome = '/p/work1/rebshan/';
caseName = '2D_DS6_smallTest';
caseID = 'cpd400_small_2D'; % for saving

saveTo = '~/official_vof_cases/DS6_verif/DS6_verif.mat';

% move to dir
cd(strcat(caseHome,caseName,'/postProcessing/singleGraph'));

% Get list of all directories in current folder
current_dir = pwd;
dir_contents = dir(current_dir);

% Filter for directories only (exclude '.' and '..')
dirs = dir_contents([dir_contents.isdir] & ~ismember({dir_contents.name}, {'.', '..'}));

% Initialize storage for data
% Initialize struct array to store data
data_struct = struct('time', {});
count = 1;

%% READ ALL SINGLEGRAPH DATA
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

            % get names of variables printed
            vars = split(fName,["_" "."]);
            vars = vars(2:end-1);
            
            data = readmatrix(file_path, 'FileType','text');
            
            data_struct(count).time = time;
            data_struct(count).x = data(:,1);
            
            var_ind = 1;
            for v = 1:length(vars)
                if vars{v} == "water"
                    continue
                end
                var_ind = var_ind + 1;
                data_struct(count).(vars{v}) = data(:,var_ind);
            end

            count = count + 1;

        catch
            % Skip files that can't be read
        end
    end
end

% Sort by timestep
[sorted_timesteps, idx] = sort([data_struct.time]);
data_struct = data_struct(idx);

% combine to matrices
fields = fieldnames(data_struct);
for f = 1:length(fields)
    if fields{f} == 'x'
        tmp.x = data_struct(1).x;
    else
        tmp.(fields{f}) = [data_struct.(fields{f})];
    end
end

fprintf('\n=== Summary ===\n');
fprintf('Total timesteps found: %d\n', length([data_struct.time]));

separateSave = strcat('sep_',caseID);
matrixSave = strcat('mat_',caseID);

assignin('base',separateSave, data_struct)
assignin('base',matrixSave, tmp)


if isfile(saveTo)
    save(saveTo,separateSave,matrixSave,'-append')
else
    save(saveTo,separateSave,matrixSave)
end

