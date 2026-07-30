function allTimes = genAllTimesCell(tend)
% create a data cell with strings for all of the timesetps 0:tend
%   number format matches OpenFOAM format
%   assumes 1 microsecond timestep
%   will always write out 0:100
%   Rebecca Shannon, 3/12/24

    allTimes{1} = '0';
    
    % first 9 microseconds
    
    for i = 1:9
        time = strcat(num2str(i),'e-06'); 
        allTimes{i+1} = time;
    end
    
    % 1e-05 section
    loop = 11;
    
    for ten = 1:9
        for deci = 0:9
            
            if deci == 0

                time = strcat(num2str(ten),'e-05');
                allTimes{loop} = time;
                loop = loop + 1;

            else

                time = strcat(num2str(ten),'.',num2str(deci),'e-05'); 
                allTimes{loop} = time;
                loop = loop + 1;

            end

        end
    end
    
    
    % 0.0001 section
    loop = length(allTimes)+1;
    hunds = 0;
    tens = 1;
    
    for i = (loop-1):tend
    
        if mod(i,100) == 0
        
            hunds = hunds + 1;
            time = strcat('0.000',num2str(hunds));
            
        elseif mod(i,10) == 0
    
            time = strcat('0.000',num2str(hunds),num2str(tens));
            tens = tens + 1;  
    
        else
    
            time = strcat('0.000',num2str(i));
    
        end
    
        % reset tens counter
        if tens == 10
            tens = 1;
        end
    
        allTimes{loop} = time;
        loop = loop + 1;

    end
end
