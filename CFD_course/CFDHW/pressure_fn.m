function P_t = pressure_fn(time)
% QUADRATIC PRESSURE
% if time <= 8.2e-5
%        pressure=3.66e22*time^4-6.25e18*time^3+4.11e14*time^2-1.17e10*time+1.85e5;
%     elseif 8.2e-5 < time < 1.85e-4
%         pressure=9.04e21*time^4-5.31e18*time^3+1.17e15*time^2-1.13e11*time+4.e6;
%     else
%         pressure = 105994.7;
%     end

% STEP FUNCTION PRESSURE
    if time <= 3.4e-5
        pressure = 100000;
    elseif 3.4e-5<time<=8.2e-5
        pressure = 200000;
    elseif 8.2e-5<time<=1.35e-4
        pressure = 100000;
    elseif 1.35e-4<time<=1.85e-4
        pressure=126000;
    else
        pressure = 100000;
    end
P_t=pressure;