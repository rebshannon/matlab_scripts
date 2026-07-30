function dydt = RPM(t,y,Pa, R0)

% Function solves for the radius vs time for single bubble oscillation
% Initial conditions: time series, initial size, acoustic excitation,
        % equilibrium radius

%% Constants
rho = 998; %kg/m3
Pv = 2.33*10^3;  %Vapour Pressure water/air (Pa)
Pinf_e = 2.49e5;%24112;%1e5;   % (Pa) Pressue far away from bubble at eqlm
S = 0.07; %0.0725; % N/m  Surface tension water/air
mu = 3.645e-4; %0.001;  % Pa.s  Shear liquid viscosity
K = 4/3;  %Polytropic Exp for Air adiabatic
Om = 2*pi*331.52E3; %  @20KHz    Acoustic Frequency

%% actual ODE

Pg_e = Pinf_e - Pv + 2*S/R0;
dydt = [y(2);1/(rho*R0^2.*y(1))*(-3/2*R0^2*rho*y(2).^2 + Pg_e*y(1).^(-3*K) + Pv - Pinf_e - Pa*sin(Om*t) - 2*S./y(1)/R0 - 4*mu*y(2)./y(1))];

