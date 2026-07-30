%% Solve Sod Shock Problem

%% Info
% subscript 1 corresponds to left initial conditions
% subscript 5 corresponds to right initial conditions

%% Initial Conditions
% set desired initial conditions

% Left Side
P_1 = 1e5;
rho_1 = 1;
u_1 = 0;
x0 = 5;         % initial shock location

% Right Side
P_5 = 1e4;
rho_5 = 0.125;
u_5 = 0;

% Domain
xmin = 0;
xmax = 10;
npoints = 10000;
t = 6.1e-3;     % time to solve at

%% Constants

gamma = 1.4;
lambda = (gamma -1)/(gamma +1);
beta = (gamma -1)/(2*gamma);

cs1 = sqtr(gamma*P_1/rho_1);
cs5 = sqtr(gamma*P_12rho_2);

%% Solve for Unknowns

P_3 = fzero('sod_func_P3',50000);    % put in a guess after the function name
u_3 = u_5 + (P_3 - P_5)/sqrt(rho_5/2 * ((gamma+1)*P_3 + (gamma-1)*P_5));
rho_3 = rho_1*(P_3/P_1)^(1/gamma);

P_4 = P_3;
u_4 = u_3;
rho_4 = rho_5 * (P_4 + lambda*P_5) / (P_5 + lambda*P_4);





