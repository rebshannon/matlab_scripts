%%  INSTABILITY ANALYSIS
% Rebecca Shannon
% 3/25/25
% analysis from Dworzanczyk et al. - 2025 - Instability Analysis of Drop
% Aerobreakup at High Mach Number
% Currently recreates Flow Parameter plots in Fig. 11

% drop 3 for verifying Fig. 11
% drop 4 for Fig. 17

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

%% LINEAR GROWTH RATE
% ACCELERATION

q2 = 1/2 * rho_2 * U_2LF^2;
a_mag = 3 * Cd * q2 / (2 * rho_d * d);
a_perp = a_mag * cos(phi_n);

% THERMOPHYSICAL PROPERTIES

Cpmax = (p_sd - p_2) / q2;
p_g = p_2 + 1/2 * rho_2 * U_2LF^2 * Cpmax * cos(phi_n).^2;
p = p_2 + q2 * Cpmax * cos(phi_n).^2;
psdBypg = p_sd ./ p_g;

M_g = sqrt(2 / (gamma - 1) * ( psdBypg .^ ((gamma - 1)/gamma) - 1 ));

rho_g = rho_sd ./ (psdBypg).^(1/gamma);
u_g = M_g .* sqrt(gamma * p_g ./ rho_g);

rho = 1 ./ (psdBypg).^(1/gamma);

a_perp = 45555600;
a_perp = 1e7;
%rho_g = 0.01:10:1000;
rho_g = 500;

% GROWTH RATE AT STAGNATION POINT

% frequently used terms
sumRho = rho_d + rho_g(1);
sumMu = mu_d + mu_g;
diffU = u_g(1) - u_d;

for wave = 1:length(k)
    % individual terms (for one wave number)
    % for surface - solver for shear (:,wave); removie (1) on rho_g and
    % a_perp
    viscosityA(:,wave) = - (k(wave).^2 * sumMu) ./ sumRho;
    viscosityB(:,wave) = (k(wave).^4 * sumMu^2) ./ sumRho.^2;
    viscosityC(:,wave) = 2*1i*k(wave).^3 .* ((rho_g(1)*mu_d - rho_d*mu_g) .* diffU) ./ sumRho.^2;
 
    shear(:,wave) = k(wave).^2 .* rho_g(1) .* rho_d .* diffU.^2 ./ sumRho.^2;
 
    acceleration(:,wave) = - (k(wave).*a_perp .* (rho_g(1) - rho_d)) ./ sumRho;
 
    %acceleration(:,wave) = - (k(wave).*6.5e8 .* (rho_g(1) - rho_d)) ./ sumRho;

    surfTension(:,wave) = - k(wave).^3 * sigma ./ sumRho;

end

% PLOTTING
%surf(1./k./d,rad2deg(phi),s*t_C2), may need sqrt on s
%xlabel('lambda'),ylabel('\phi')
%ax=gca;
%set(gca,'xscale','log')
%set(gca,'zscale','log')

% linear growth rate

s_pos = -1i .* k .* (rho_g(1).*u_g(1) - rho_d*u_d) ./  sumRho + viscosityA + ...
    sqrt(shear + acceleration + surfTension + viscosityB + viscosityC);

s_neg = -1i .* k .* (rho_g(1).*u_g(1) - rho_d*u_d) ./  sumRho - viscosityA + ...
    sqrt(shear + acceleration + surfTension + viscosityB + viscosityC);

%% NONDIMENSIONAL FLOW PARAMETERS LINEAR

pR = p / p_sd;
uR = u_g / u_g(end);
rhoR = rho_g / rho_sd;
aR = a_perp / a_perp(1);

%% NONLINEAR

epsilon = rho_g / rho_d;

% Froude number based on 2D or 3D
if dim == 2
    Fr = 0.23;
elseif dim == 3
    Fr = 0.36;
else 
    Fr = 0;
end

% Find F
num = pi^2 * sigma;
den = (1 - epsilon) * rho_d * a * lambda^2;

F = Fr * sqrt( 1 - 4 * (num/den));

% transition time

numrt = (1 - epsilon) * a * lambda;
t_t = ln( F * sqrt(numrt) / ( s * eta_0) ) / s;




%% PLOTTING - LINEAR
% 
% load('dwo2025Plots.mat') % Fig. 11(a, c, and e), analytic solution only
% 
% figure
% plot(rad2deg(phi),pR)
% hold on
% plot(flowParamdwoR1.pX,flowParamdwoR1.pR,'.')
% legend('MATALB','Dworzanczyk Analytic')
% ylabel('Pressure Ratio'); xlabel('\phi');
% grid on
% 
% figure
% plot(rad2deg(phi),uR)
% hold on
% plot(flowParamdwoR1.uX,flowParamdwoR1.uR,'.')
% legend('MATALB','Dworzanczyk Analytic')
% ylabel('Velocity Ratio'); xlabel('\phi');
% grid on
% 
% figure
% plot(rad2deg(phi),rhoR)
% hold on
% plot(flowParamdwoR1.rhoX,flowParamdwoR1.rhoR,'.')
% legend('MATALB','Dworzanczyk Analytic')
% ylabel('Density Ratio'); xlabel('\phi');
% grid on
% 
% figure
% plot(rad2deg(phi),aR)
% hold on
% plot(flowParamdwoR1.aX,flowParamdwoR1.aR,'.')
% legend('MATALB','Dworzanczyk Analytic')
% ylabel('Acceleration Ratio'); xlabel('\phi');
% grid on
% 
% 
% %% Plot all flow parameters in one figure
% w=1.5;
% figure
% hold on
% plot(rad2deg(phi),pR,'Color','k','LineWidth',w)
% plot(flowParamdwoR1.pX,flowParamdwoR1.pR,'.','Color','k','LineWidth',w)
% 
% plot(rad2deg(phi),uR,'Color','b','LineWidth',w)
% plot(flowParamdwoR1.uX,flowParamdwoR1.uR,'.','Color','b','LineWidth',w)
% 
% plot(rad2deg(phi),rhoR,'Color','r','LineWidth',w)
% plot(flowParamdwoR1.rhoX,flowParamdwoR1.rhoR,'.','Color','r','LineWidth',w)
% 
% 
% plot(rad2deg(phi),aR,'Color','g','LineWidth',w)
% plot(flowParamdwoR1.aX,flowParamdwoR1.aR,'.','Color','g','LineWidth',w)
% 
% 
% ylabel('Flow Parameter'); xlabel('\phi');
% legend('Pressure','','Velocity','','Density','','Acceleration','')
% grid on
% ylim([0 1])
