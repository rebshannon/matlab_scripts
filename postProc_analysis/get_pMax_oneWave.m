%% REBECCA SHANNON
% 8/11/26
% single wave cases; get max pressure out
% change case at bottom for shift+enter

%load /projectnb/aeracous/REBECCA/hybridSolvers/vof_singleWave/compInter/compInter_oneWave.mat

% choose case (use below for shift+enter
tmp = air;

% single or multiphase
phases = 1;

if phases == 1

    %% single phase case

    for i = 1:length(tmp)

        [m,n] = max(tmp(i).p);
        tmp(i).pMax = m;
        tmp(i).pMaxLoc = tmp(i).x(n);

    end

else

    %% multiphase case
    % assume alpha = 1 is water  
  
    for i = 1:length(tmp)
    
        [m,n] = max(tmp(i).p(tmp(i).alpha > 0.5));
        tmp(i).pMaxWater = m;
        tmp(i).pMaxWaterLoc = tmp(i).x(n);
    
        [m,n] = max(tmp(i).p(tmp(i).alpha < 0.5));
        tmp(i).pMaxAir = m;
        tmp(i).pMaxAirLoc = tmp(i).x(n);
    
        [m,n] = min(tmp(i).p(tmp(i).alpha > 0.5));
        tmp(i).pMinWater = m;
        tmp(i).pMinWaterLoc = tmp(i).x(n);
    
    end

end

% update case mat
air = tmp;
