%%  INSTABILITY ANALYSIS
% Rebecca Shannon
% 4/4/25
% analysis from Dworzanczyk et al. - 2025 - Instability Analysis of Drop
% Aerobreakup at High Mach Number
% Currently recreates Flow Parameter plots in Fig. 11


%% CONSTANTS
% NOTE: some constants are not used for the flow parameter plots but will
% be used for the growth rate calculation (not working as of 3/31/25)

% ELLIPSE RATIO (1 for circle)
bByc = 1;

% fluid properties
sigma = 0.0072;   % surface tension
rho_d = 998;    % drop density
gamma = 1.3;     % specific heat ratio; accounts for thermochemical effects
mu_d = 1.002e-3; % drop viscosity
mu_g = 0;        % gas viscosity
Cd = 2.32;       % drag coefficient 

% drop diameter - Table 1 
d = 0.00199;

% dimensional flow parameters from Table 2
u_d = 0; % relative drop velocity is zero
U_2LF = 1408;
rho_2 = 6.53;
p_2 = 2946e3;

rho_3 = 20.55;
U_3 = 532;
p_3 = 14575e3;

% drop stagnation point values - calculated
% drop 3 values
% rho_sd = 25.1435; % from fig 5a
% p_sd = 18945085; % bernoulli p_sd = 1/2*rho_3*U_3^2 + p_3
% calculate the values
rho_sd = 1.1893805 * rho_3; % from fig. 5a
p_sd = 1/2 * rho_3 * U_3^2 + p_3; % bernoulli

% region to solve over
% angle from stagnation point on drop and wave number
phi = 0 : pi/100 : pi/2; %% RADIANS

% kaxis = logspace(0,-2,26);
% k = 1./kaxis./d;
% k = logspace(2,7,51);
%lambda = 
lambda = logspace(-6,-3,51);
k = 1./lambda;
%k = 36457;
%k = 1/d;      % used for growth rate, not implemented

phi_n = atan( (1/bByc)^2 * tan(phi) ); % angle for perpendicular acceleration
t_C2 = sqrt(rho_d/rho_2)*d/U_2LF;  % Rayleigh breakup time

%% Flow Parameters

[a_perp, rho_g, p_g, u_g, p] = calc_flow_param(U_2LF, Cd, rho_d, rho_2,rho_sd, d, phi_n, p_sd,gamma, p_2);

% nondimensional
pR = p / p_sd;
uR = u_g / u_g(end);
rhoR = rho_g / rho_sd;
aR = a_perp / a_perp(1);

w=1.5;
figure
hold on
plot(rad2deg(phi),pR,'Color','k','LineWidth',w)
plot(flowParamdwoR1.pX,flowParamdwoR1.pR,'.','Color','k','LineWidth',w)

plot(rad2deg(phi),uR,'Color','b','LineWidth',w)
plot(flowParamdwoR1.uX,flowParamdwoR1.uR,'.','Color','b','LineWidth',w)

plot(rad2deg(phi),rhoR,'Color','r','LineWidth',w)
plot(flowParamdwoR1.rhoX,flowParamdwoR1.rhoR,'.','Color','r','LineWidth',w)


plot(rad2deg(phi),aR,'Color','g','LineWidth',w)
plot(flowParamdwoR1.aX,flowParamdwoR1.aR,'.','Color','g','LineWidth',w)


ylabel('Flow Parameter'); xlabel('\phi');
legend('Pressure','','Velocity','','Density','','Acceleration','')
grid on
ylim([0 1])

%% Linear Growth Rate

