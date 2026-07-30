%% REBECCA SHANNON
% 4/16/25

% take data form cavSym (new) and arrange into 2500x5000 arrays
% inpus as a csv with (x,y) coord and the cell data
% expected input: 
    % [t, Cell Type, T, U0, U1, U2, alpha.water, x, y, z, p, p_rgh, rho]
    % one row per cell, 1~2510002 rows

NSLOTS=str2num(getenv('NSLOTS'));

cd /projectnb/aeracous/REBECCA/DOD_CAVSYM/U267_D2_B3_double_full/

tStart = 0;
tEnd = 1;

for t = tStart:tEnd

    M = readmatrix(strcat('postProcessing/pvData/cellCenterData_',num2str(t),'.csv'));
    
    for i = 1:length(M)
        
        if abs(M(i,8)) == 5.000000e-03 || abs(M(i,9)) == 5.000000e-03
            continue
        end
    
        x(i) = round(M(i,8)*1e6+5001)/2;
        y(i) = round((M(i,9)*1e6))/2;
        result(y(i),x(i)) = M(i,7);
    end
   
    
    % Flip the image vertically (to create the mirrored top half)
    flipped_img = flip(result, 1);  % '1' flips along the vertical (up-down) axis
    
    % Combine the flipped part (top) and original part (bottom)
    complete_img = [flipped_img; result];  % Vertically concatenate
    
    % Save the resulting image (5000x5000 pixels)
    fName = strcat('U267D2B3doubleF_alpha_t',num2str(t,'%03.f'),'.png');
    imwrite(complete_img,strcat('postProcessing/pngResults/',fName));
    imwrite(complete_img, 'complete_image.jpg');
    
    % Optional: Display the result
%   figure;
%   imshow(complete_img);
%   title('Mirrored Complete Image (5000x5000)');
    
    %fName = strcat('U267D2B1_alpha_t',num2str(t),'.png');
    %imwrite(result,strcat('pngResults/',fName));

end


