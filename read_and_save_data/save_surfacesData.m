%% REBECCA SHANNON
% 1/28/2026
% read output from surfaces function object and save as mat


%% SET UP

caseName = 'benchmarks/AIAA-shot6/OpenFOAM';
tStep = 1e-7;
tStart = 0;
tEnd = 3e-5;

cd(strcat('/projectnb/aeracous/REBECCA/',caseName))
cd './postProcessing/surfaces'

if tStart == 0
    P = readmatrix('0/p_freeSurf.raw','FileType','text');
    U = readmatrix('0/U_freeSurf.raw','FileType','text');
else
    P = readmatrix(strcat(num2str(tStart),'/p_freeSurf.raw','FileType','text'));
    U = readmatrix(strcat(num2str(tStart),'/U_freeSurf.raw','FileType','text'));
end

% % initialize
% p = zeros(round((tEnd-tStart)/tStep+1),size(P,1));
% Ux = zeros(round((tEnd-tStart)/tStep+1),size(U,1));
% Uy = zeros(round((tEnd-tStart)/tStep+1),size(U,1));
% Uz = zeros(round((tEnd-tStart)/tStep+1),size(U,1));
% x = zeros(round((tEnd-tStart)/tStep+1),size(U,1));
% y = zeros(round((tEnd-tStart)/tStep+1),size(U,1));
% z = zeros(round((tEnd-tStart)/tStep+1),size(U,1));
timeInt = tStart:tStep:tEnd;

% extract data for t0
colNum = 1;
myStructure.p{colNum,:} = P(:,4);
myStructure.Ux{colNum,:} = U(:,4);
myStructure.Uy{colNum,:} = U(:,5);
myStructure.Uz{colNum,:} = U(:,6);
myStructure.x{colNum,:} = U(:,1);
myStructure.y{colNum,:} = U(:,2);
myStructure.z{colNum,:} = U(:,3);

for t = timeInt

    if t == tStart
        continue
    end

    colNum = colNum + 1;
    
    if t < 1e-6
        P = readmatrix(sprintf('%.0e/p_freeSurf.raw',t),'FileType','text');
        U = readmatrix(sprintf('%.0e/U_freeSurf.raw',t),'FileType','text'); 
%        sprintf('%.0e',t)

        myStructure.p{:,colNum} = P(:,4);
        myStructure.Ux{colNum,:} = U(:,4);
        myStructure.Uy{colNum,:} = U(:,5);
        myStructure.Uz{colNum,:} = U(:,6);
        myStructure.x{colNum,:} = U(:,1);
        myStructure.y{colNum,:} = U(:,2);
        myStructure.z{colNum,:} = U(:,3);

    elseif t < 10e-6

        if rem(t,1e-6) == 0
            P = readmatrix(sprintf('%.0e/p_freeSurf.raw',t),'FileType','text');
            U = readmatrix(sprintf('%.0e/U_freeSurf.raw',t),'FileType','text'); 
 %             sprintf('%.0e',t)
        else 
            P = readmatrix(sprintf('%.1e/p_freeSurf.raw',t),'FileType','text');
            U = readmatrix(sprintf('%.1e/U_freeSurf.raw',t),'FileType','text'); 
%              sprintf('%.1e',t)
        end

        myStructure.p{:,colNum} = P(:,4);
        myStructure.Ux{colNum,:} = U(:,4);
        myStructure.Uy{colNum,:} = U(:,5);
        myStructure.Uz{colNum,:} = U(:,6);
        myStructure.x{colNum,:} = U(:,1);
        myStructure.y{colNum,:} = U(:,2);
        myStructure.z{colNum,:} = U(:,3);
       
    elseif t < 100e-6

        if rem(round(t,8),10e-6) == 0
            P = readmatrix(sprintf('%.0e/p_freeSurf.raw',t),'FileType','text');
            U = readmatrix(sprintf('%.0e/U_freeSurf.raw',t),'FileType','text'); 

%             sprintf('%.0e',t)
        elseif rem(round(t,8),1e-6)==0
            P = readmatrix(sprintf('%.1e/p_freeSurf.raw',t),'FileType','text');
            U = readmatrix(sprintf('%.1e/U_freeSurf.raw',t),'FileType','text'); 

%             sprintf('%.1e',t)
        else
            P = readmatrix(sprintf('%.2e/p_freeSurf.raw',t),'FileType','text');
            U = readmatrix(sprintf('%.2e/U_freeSurf.raw',t),'FileType','text'); 

%             sprintf('%.2e',t)
        end
        myStructure.p{:,colNum} = P(:,4);
        myStructure.Ux{colNum,:} = U(:,4);
        myStructure.Uy{colNum,:} = U(:,5);
        myStructure.Uz{colNum,:} = U(:,6);
        myStructure.x{colNum,:} = U(:,1);
        myStructure.y{colNum,:} = U(:,2);
        myStructure.z{colNum,:} = U(:,3);

    else
        t_strip = strip(num2str(t),'right','0');
        P = readmatrix(strcat(t_strip,'/p_freeSurf.raw'),'FileType','text');
        U = readmatrix(strcat(t_strip,'/U_freeSurf.raw'),'FileType','text'); 

        myStructure.p{:,colNum} = P(:,4);
        myStructure.Ux{colNum,:} = U(:,4);
        myStructure.Uy{colNum,:} = U(:,5);
        myStructure.Uz{colNum,:} = U(:,6);
        myStructure.x{colNum,:} = U(:,1);
        myStructure.y{colNum,:} = U(:,2);
        myStructure.z{colNum,:} = U(:,3);

    end

end

myStructure.time=transpose(timeInt);
