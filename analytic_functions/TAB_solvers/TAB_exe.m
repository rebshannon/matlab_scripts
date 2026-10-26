% calls RPM.m function to solve Rayleigh-Plesset ODE
% to change fluid, change constants in RPM.m

%% Constants

rho_d = 1000; % drop density
d0 = 0.00127; % drop diameter
sigma = 0.0072; % surface tension
mu_d = 3.645e-4; % drop viscosity
rho_g = 5.38521; % air density (upstream)
U_g = 822; % air velocity

tSpan = [0, 2e-5]; % time span of interest
C2 = 2; % constant

%% Nondimensionalize and Initial Condisions

Oh = mu_d / sqrt(rho_d*d0*sigma);
We = rho_g * U_g^2 * d0 / sigma;

y0 = [d0/d0, 0]; % initial position and velocity
tSpanBar = tSpan ./ sqrt(rho_d*d0^3/sigma);

%% Solve ODE
opts = odeset('Reltol',1e-9,'AbsTol',1e-9,'Stats','on'); % reltol originally 1e-9
[tBar,y] = TAB(tSpanBar, y0, Oh, We, C2,opts);  


%% Reformat data

t = tBar * sqrt(rho_d*d0^3/sigma); % make time dimensional

t_c = sqrt(rho_d/rho_g)*d0/U_g; % Ranger Nicholls breakup time
tau = t / t_c; % cast to nondimensional breakup time

d = y*d0;

tbi = 1.9*(We-12)^(-0.25)* (1 + 2.2*Oh^1.6);
tau_shift = tau + tbi;

%% Plotting

figure
hold on
plot(tau,y,'linewidth',1.5)
plot(tau_shift, y,'linewidth',1.5)
legend('TAB','TAB + shift')

grid on


