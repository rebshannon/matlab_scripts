function dydt = RPM(t, y, Pa, R0, Pinf_e)

% Function solves for the radius vs time for single bubble oscillation
% Initial conditions: time series, initial size, acoustic excitation,
        % equilibrium radius

% Constants

rho = 1000;%998.2061;%998.2;              % density                              [kg/m3]
Pv = 2.3*10^3;         % vapour pressure (water/air)          [Pa]
s = 0.07;               % surface tension (water/air)          [N/m]
mu = 3.645e-4;%1.84e-5;%0.001; %  3.645e-4;        % shear liquid viscosity (0.001)       [Pa*s]
K = 1.4;                  % polytropic exp for air, adiabatic
omega = 2*pi*7.7e-6;    % acoustic frequency @20KHz

% solver

Pg_e = Pinf_e - Pv + 2*s/R0;
dydt=[ y(2) ; 1/(rho.*y(1))*(-3/2*y(2).^2*rho + Pg_e*(R0./y(1)).^(3*K) + Pv ...
    - Pinf_e - 2*s./y(1) - 4*mu*y(2)/y(1)) ];
