% Rebecca Shannon
% 3/7/24
% postProcess cell data

maxNumCompThreads(1);

%% FILE LOCATIONS

% CHOOSE THESE
% set in the qsub_matlab script and should automatically update

% caseName is the case directory, variable is what data should be looked
% at, tend is the last written timestep (microseconds)

caseName = 'bubble/flow/U267_D2mm_B2';
variable = 'alpha';
tstart = 0;
tend = 120;
U = 267;

% LOCATIONS - where to read and write to/from

caseDir = strcat('/projectnb/turbomac/REBECCA/cavSym2024/',caseName);
writeto = strcat('/projectnb/turbomac/REBECCA/cavSym2024/',caseName, ...
    '/postProcess/',variable,'/');
addpath('/projectnb/turbomac/REBECCA/matlab/'); % for genTimes function

% % initialize starting runMax/runMin **SET TO CONSTANT MAX/MIN
% runMax = 0;
% runMin = 1e12;

TMin = 200;
TMax = 650;
%pMin = 1e4;
%pMax = 5e8;

%% LOAD NUMBERING

% this file contains the numbering order for OpenFOAM grid
% columns 1 and 2 are counting, column 3 is global cell ID
cellIDs = readmatrix(['/projectnb/turbomac/REBECCA/cavSym2024/bubble/' ...
    'flow/U267_D2mm_B3/cleanTextFiles/cellIDtoCellIDs.csv']);
cellIDs = cellIDs + 1;

%% LOOP THROUGH TIMESTEPS
% centerVal = the value of that variable at each cell center
% centSq = just the cells where meshing is constant (3000 x 3000 for cav24)
% cellIDs = OpenFOAM ID for each cell
% cellNum = OpenFOAM ID for the current cell 
% dataMat = value of each variable at the corect location (this is what you
%           want to save

allTimes = genAllTimesCell(tend); % make string cell holding all timestep folders

for t = tstart:tend
    
    % useful to output time if not running in batch  
    %t

      if strcmp(variable,'T') && t == 0
          
          % T @ t = 0 does not have a list of values so set constant value
          dataMat = zeros(3000,3000) + 300;
  
      else
     
        %% LOAD DATA
        
         timeDir = strcat(caseDir,'/',allTimes{t+1});
         cd(timeDir)
         centerVal = readmatrix(strcat(variable,'Trim'));
     
         % centers = centers(:,2:5);
         % centers(:,1) = centers(:,1) + 1;
             
         %% GET CELL IDS
         % this section only keeps the center square with constant spacing
         % 6 mm x 6 mm region
         % also keeps the boundary, so one cell beyond
         
         %centSq = zeros(length(cellIDs),size(centers,2));
         centSq = zeros(length(cellIDs),size(centerVal,2));
         
         for i = 1:length(cellIDs)
         
             cellNum = cellIDs(i,3);
             centSq(i,:) = centerVal(cellNum,:);
         
         end
         
         %% DIAGONAL NUMBERING TO A SQUARE
         % reshapes 1D matrix to 2D
         
         % # cells on one side of square domain
         N = sqrt(length(centSq)); 
         count = 1;
         dataMat = zeros(N,N,size(centerVal,2));
         %dataMat=zeros(3002,3002,3);
         
         % lower left corner through corner diagonal
         for i = N:-1:1
         
             yind = i;
             xind = 1;
         
             while yind < N +1
           
                 % dataCell{xind,yind} = centers(count,:);
                 dataMat(yind,xind,:) = centSq(count,:);
         
                 count = count + 1;
                 yind = yind + 1;
                 xind = xind + 1;
         
             end
         
         end
         
         % upper right corner
         for i = 2:N
         
             yind = 1;
             xind = i;
         
             while xind < N + 1 
         
                 dataMat(yind,xind,:) = centSq(count,:);
         
                 count = count + 1;
                 yind = yind + 1;
                 xind = xind + 1;
         
             end
         
         end
         
         % get rid of boundary values
         dataMat = dataMat(2:end-1,2:end-1,:);
         
         %image(dataMat(:,:,2),dataMat(:,:,3))
         
         %x = 1e-6:2e-6:(6e-3-1e-6);
         %image(x,x,dataMat(:,:,1),'CDataMapping','scaled')
 
     end

%     % find max/min value if this is T or p
%     if strcmp(variable,'T') || strcmp(variable,'p')
%     	% find running max and min of data
%     	runMax = max(max(dataMat,[],"all"),runMax);
%     	runMin = min(min(dataMat,[],"all"),runMin);
%     end

    %% WRITE TO TXT FILE
    % writes dataMat to new file in writeto directory
    
%     fileName = strcat(variable,num2str(t),'.txt');
%     writematrix(dataMat,strcat(writeto,fileName))

    %% WRITE TO PNG FILE
    % writes dataMat to new file in writeto directory
    
    fileName = strcat(variable,num2str(t),'.png');
    imwrite(dataMat,strcat(writeto,fileName))

    %% DELETE TRIM FILE 
    trimFile = strcat(variable,'Trim');
    delete(trimFile)

end

%% RESCALE DATA 
% T and p variables need to be rescaled - based on max/min 
% max/min taken as approx values from U267 B2-4 and nB

cd(writeto)
   
 if strcmp(variable,'T') 
     
      for t = 0:tend
      
         fileName = strcat(variable,num2str(t),'.txt');
         scaleVar = readmatrix(fileName);
      
         % rescale
         scaleVar = (scaleVar - TMin) / (TMax - TMin);
  
         % rewrite
         writeFileName = strcat(variable,'Scale',num2str(t),'.txt');
 	     writematrix(scaleVar,strcat(writeto,writeFileName))
	
	     % delete unscaled file
	     delete(fileName)
     
     end

elseif strcmp(variable,'p')
    
     for t = 0:tend
         fileName = strcat(variable,num2str(t),'.txt');
         scaleVar = readmatrix(fileName);
      
         % rescale
         scaleVar = (scaleVar - pMin) / (pMax - pMin);
  
         % rewrite
         writeFileName = strcat(variable,'Scale',num2str(t),'.txt');
 	     writematrix(scaleVar,strcat(writeto,writeFileName))

	     % delete unscaled file
	     delete(fileName)

         %t
    end
  
 end




%% FLIPPED ORIENTATION
% 
% count = 1;
%
% for i = 1:N
% 
%     xind = i;
%     yind = 1;
% 
%     while yind < i + 1
%   
%         % dataCell{xind,yind} = centers(count,:);
%         dataMat(xind,yind,:) = centers(count,:);
% 
%         count = count + 1;
%         xind = xind - 1;

%         yind = yind + 1;
% 
%     end
% 
% end
% 
% 
% for i = 2:N
% 
%     xind = N;
%     yind = i;
% 
%     while yind < N + 1 
% 
%         dataMat(xind,yind,:) = centers(count,:);
% 
%         count = count + 1;
%         xind = xind - 1;
%         yind = yind + 1;
% 
%     end
% 
% end

 
