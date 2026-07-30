% Save interface data for KHI initilization in mat file

% Rebecca Shannon 10/16/23

%% Script

% move to KHI initilization directory 
cd ../2D_jetting_splashing/kobelCylinder/jettingOnly/jet7g/interface_points/

for i = [1]
    
    i

    % move to next case
    time = sprintf('time %d',i);
    
    % name of interface line matrix and read
    interfaceMatrix = sprintf('jet7g_interface_05_%d.csv',i);
    M = readmatrix(interfaceMatrix);
    
    % if mod index = 1 then add M2 andd M3 to (x,y) coordinates
    % filters to only one corner of each cell (hopefully)

    % counter for (x,y) coordinates
    k = 0;
    x = zeros(floor(length(M)/4),1);
    y = zeros(floor(length(M)/4),1);

    % filter out repeat coordinates
    for j = 1:length(M)
        if mod(j,4) == 1
            k = k + 1;
            x(k) = M(j,2);
            y(k) = M(j,3);
            z(k) = M(j,4);
        end
    end

    plot(x,y,'.')
    hold on


end

xlabel('X Location (m)')
ylabel('Y Location (m)')
title({'Bubble-Drop Interfaces',})%'V_{perturb} = 1 m/s, X_{perturb} = 0.1 mm'})
%legend('V_{air} = 1 m/s','V_{air} = 10 m/s','V_{air} = 50 m/s')
