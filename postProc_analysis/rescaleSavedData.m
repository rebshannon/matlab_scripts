% find min/max of already extracted T and p


cd /projectnb/turbomac/REBECCA/cavSym2024/bubble/flow/U267_D2mm_B2/postProcess/p

runMin = 1e4;
runMax = 5e8;

% for t = 0:122
%     
%     fileName = strcat('T',num2str(t),'.txt');
%     dataMat = readmatrix(fileName);
% 
%     runMax = max(max(dataMat,[],"all"),runMax);
%     runMin = min(min(dataMat,[],"all"),runMin);
% 
%     t
% 
% end

for t = 0:122
 
    fileName = strcat('pScale',num2str(t),'.txt');
    scaleVar = readmatrix(fileName);
 
    % rescale
    %scaleVar = (scaleVar - runMin) / (runMax - runMin);
    scaleVar = log10(scaleVar);

    % rewrite
    writeFileName = strcat('pLogScale',num2str(t),'.txt');
    writematrix(scaleVar,writeFileName)

    t
    %delete(fileName)

end