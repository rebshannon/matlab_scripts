% NSLOTS=str2num(getenv('NSLOTS')); 
% maxNumCompThreads(NSLOTS); %don't go over requested # of cores

% Calculate the initial pressure in the bubble or the expected equilibirum
%   radius
% When finding the inital pressure, use Ro = equilibrium radius and 
%   Pi = initial internal pressure
% When finding the equilibrium radius, use Req = equiliibrium radius and
%   Pin = initial internal pressure

%% Constants
% equilibrium radius or initial internal pressure

Ro = 150e-6;%8.2465e-3;          % [m]
Pin = 1e8;         % [Pa]

% constants for air bubble in water 

Po = 100000;        % pressure outside bubble (atmospheric)     [Pa]
Pv = 2300;          % vapor pressure (water/air)                [Pa]
sigma = 0.07;       % surface tenesion (air-water)             [N/m]
k = 1;            % adiabatic constant (use 1.0 for isothermal, 1.4 for adiabatic)
R = 50e-6;      % initial radius                            [m]

%% Initial Pressure

Pg = Po - Pv + 2*sigma/Ro
Pi = Pg*(Ro/R)^(3*k) + Pv - 2*sigma/R

%% Equilibrium Radius

% Equation being solved: 
    % 0 == (Po-Pv)*Req^(3*k)+2*sigma*Req^(3*k-1)-R^(3*k)*(Pin-Pv*2*sigma/R)
    % *NOTE: "roots" only works if k = 1

A = Po - Pv;
B = 2*sigma;
C = 0;
D = -R^(3*k)*(Pin - Pv + 2*sigma/R);

Req = roots([A B C D]);