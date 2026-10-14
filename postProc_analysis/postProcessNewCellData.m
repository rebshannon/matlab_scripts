%% REBECCA SHANNON
% 4/16/25

% take data form cavSym (new) and arrange into 2500x5000 arrays
% inputs as a csv with (x,y) coord and the cell data
% expected input: 
    % [t, Cell Type, T, U0, U1, U2, alpha.water, x, y, z, p, p_rgh, rho]
    % one row per cell, 1~2510002 rows

NSLOTS=str2double(getenv('NSLOTS'));
maxNumCompThreads(NSLOTS); %don't go over requested # of cores

% select which home directory
% HOME = '/p/work1/rebshan/';
HOME = '/projectnb/aeracous/REBECCA/';

% make case selections
BID = 1; % bubble ID number
U = 100; % air velocity

caseID = sprintf('U%dB%d/',U,BID);

caseLoc = sprintf('%sDOD_CAVSYM/%s',HOME,caseID);
cd(caseLoc)

tStart = 0;

% selection for different mesh densities
% not factored in yet
% cellDensity = 2e-6;
% cellNumber = 3000;

% find all timesteps
numSteps = length(dir(fullfile('./postProcessing/pvData/','*.csv')));

for t = tStart:numSteps

    M = readmatrix(strcat('postProcessing/pvData/cellCenterData_',num2str(t),'.csv'));
    
    for i = 1:length(M)
        
         if abs(M(i,8)) == 5.000000e-03 || abs(M(i,9)) == 5.000000e-03
             continue
         end
     
         x(i) = round(M(i,8)*1e6+5001)/2;
         y(i) = round((M(i,9)*1e6+1))/2;
         result(y(i),x(i)) = M(i,7);

%        if abs(M(i,8)) == cellDensity*cellNumber|| abs(M(i,9)) == cellDensity*cellNumber
%            continue
%        end
    
%        x(i) = round((M(i,8)-cellDensity/2)/cellDensity+(cellNumber+1));
%        y(i) = round(((M(i,9)-cellDensity/2)/cellDensity+1));
%        result(y(i),x(i)) = M(i,7);
    end
   
    
    % Flip the image vertically (to create the mirrored top half)
    flipped_img = flip(result, 1);  % '1' flips along the vertical (up-down) axis
    
    % Combine the flipped part (top) and original part (bottom)
    complete_img = [flipped_img; result];  % Vertically concatenate
    
    % Save the resulting image (5000x5000 pixels)
    fName = strcat(caseID,'_alpha_t',num2str(t,'%03.f'),'.png');
    imwrite(complete_img,strcat('postProcessing/pngResults/',fName));
%    imwrite(complete_img, 'complete_image.jpg');
    
    % Optional: Display the result
%   figure;
 % imshow(complete_img);
%   title('Mirrored Complete Image (5000x5000)');
    
    %fName = strcat('U267D2B1_alpha_t',num2str(t),'.png');
    %imwrite(result,strcat('pngResults/',fName));

end


