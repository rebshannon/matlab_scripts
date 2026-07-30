%% Tauber - Linear Stability Analysis for Immiscible Fluid Interface
% Rebecca Shannon
% 10/23/23

%% fluid properties

T = 0.0072;     % surface tension [N/m]

% fluid 1 = upper fluid
    rho_1 = 1000;    % denisty fluid 1 [kg/m^3]
    %U_1 = ;         % velocity fluid 1 [m/s]
    mu_1 = 1.12e-3;         % viscosity fluid 1 [Pa*s]

% fluid 2 = lower fluid
    rho_2 = 100;    % density fluid 2  [kg/m^3]
    %U_2 = ;         % velocity fluid 2 [m/s]
    mu_2 = mu_1/10;         % viscosity fluid 2 [Pa*s]

%% perturbation properties
    % form: A(t) = A_0 * exp[st + ikx]
    % where s = phase velocity (imaginary) + growth rate (real)

% A =     % amplitude as a function of time
% A_0 =       
lambda = 1;             % wavelength [m]
zeta = 0.025*lambda;    % initial interface amplitude [m]

%% constants

%dU = U_2 - U_1;                 % velocity difference [m/s]
k = 1/lambda;                    % wave numer [1/m]
zeta_tilde = zeta*k;            % nondimensional initial interface amplitude [-]
r = rho_1/rho_2;                % nondimensional density ratio [-]
We = 1.65;%(rho_1*dU) / (T*k);        % Weber number [-]
Re_1 = 5000;%(rho_1*dU*lambda) / mu_1 % Reynold number fluid 1 [-]
Re_2 = 5000;%(rho_2*dU*lambda) / mu_2 % Reynold number fluid 2 [-]


% Domain size and interval
    xl = 0;                 % [m]
    xr = 1;                 % [m]
    
    n = 1501;               % number of grid points [-]
    dx = (xr-xl)/(n-1);     % grid density [m]
    x = [xl:dx:xr];         % vector with gridpoints

crWe = 1 + 1/r;
maxWe=3/2*crWe;
We = [crWe:0.55/4:111.1];     % 200 points on line, one point is max growth rate


for i = 1:length(We)

    sigma_tilde(i) = 1/We(i) * sqrt(1/(1+r) * (r/(r+1) - 1/We(i)));

end


%% Vortex Sheet Strength

for i = 1:n
    
    gamma_tilde(i) = -1/We + (r-1)/(r+1) * zeta_tilde/We + 2*zeta_tilde*sigma_tilde*sin(x(i));

end

plot(x,gamma_tilde)