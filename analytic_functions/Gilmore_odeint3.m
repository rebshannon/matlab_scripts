function [t, R]=Gilmore_odeint3(R0,v0,requ,pvapour,pac,frequ,t_data)
    %
    % Gilmore_odeint
    %
    %% Parameter Definitions:
    % R0 = initial radius [m]
    % v0 = initial speed/velocity [m/s]
    % requ = rest radius [m]
    % pvapour = vapor pressure [Pa]
    % pac = sound pressure (external pressure) [Pa]
    % frequ = frequency of sound excitation [Hz]
    % t_data = times for which solution values are to be output [us]
    %
    % Return Values:
    % [t, r]
    % t = Time [s]
    % R = bubble radius [m]
    %
    % H. Soehnholz, T. Kurz
    %
    % Last change: 19.12.2012
    %% Setting Constants
    % Font size for axis labels
    set(0, 'DefaultAxesFontSize', 12);
    fontsz = 12;
    % Parameter
    
    % liquid properties

    pstat = 100000;             % static pressure   [Pa]
    rho0 = 1027.0;              % liquid density    [kg/m^3]
    mu = 3.645e-4; %0.001;;     % viscosity         [Pa s]
    Btait = 3046e5;             % B from Tait equation (tait pressure)
    ntait = 7.15;               % Tait exponent 

    % bubble properties

    surftension = 0.07;        % Surface tension [N/m]
    kappa = 1; %4/3;            % polytropic exponent...
                                % (1 = isothermal, 1.4 = adiabatic)
    T0 = 5e-8;                  % time step
    bvan = 0.0016;              % van der Waals constant b
    
    npts = 1000;
    nper = 5;

    % last time step

    tend = t_data(end) * T0;
    
    R0
    v0
    requ % Bubble equilibrium radius [m]

    %% Scaling

    % scale factors

    scale_t = T0;
    scale_R = requ;
    scale_U = requ / T0;
    scale_p = scale_U * scale_U * rho0;

    %scale parameters

    sc_pstat = pstat / scale_p;
    sc_pac = pac / scale_p;
    sc_pvapour = pvapour / scale_p;
    sc_sigma = surftension / scale_R / scale_p;
    sc_mu = mu / scale_R / scale_p * scale_U;
    sc_Btait = Btait / scale_p;
    sc_frequ = frequ * scale_t;
    sc_omega = 2. * pi * sc_frequ;
    threekappa = 3. * kappa;
    sc_twosigma = 2. * sc_sigma;
    sc_fourmu = 4. * sc_mu;
    sc_pequ = sc_pstat + sc_twosigma - sc_pvapour;
    ntaitinv = 1. / double(ntait);
    ntaitsub1 = ntait - 1;
    ndivnsub1 = double(ntait) / double(ntaitsub1);
    sc_c0 = sqrt((sc_pstat + sc_Btait) * ntait);
    sc_c0_square = sc_c0 * sc_c0;

    % initial radius and velocity scaled (by Req and timestep)
    
    R0 = R0 / scale_R; 
    v0 = v0 / scale_U; 
    
    %% Initial values and ODE solver options
    
    % time

    sc_t = 0;                       % t start
    sc_tper = tend / scale_t;       % t end
    sc_tint = 10e-9 / scale_t;      % time step
    range = [sc_t:sc_tint:sc_tper]; % define tiem range

    % initial values and ODE

    start = [R0 v0]; % Starting values for R, dR/dt
    options = odeset('AbsTol',1e-10,'RelTol',1e-6); 
    sol = ode45(@gilmore_dgl, range, start, options); 
    
    solneu = deval(sol, t_data);
 
    % back to real values from scaled

    t = t_data .* scale_t;
    R = solneu(1,:) .* scale_R;

    %% Gilmore function

    function dx=gilmore_dgl(t, x)
        dx=zeros(2,1);
        pinf = sc_pstat - sc_pac * sin(sc_omega * t);
        dotpinf = -sc_pac * sc_omega * cos(sc_omega * t);
        adiabat = sc_pequ * ((1. - bvan) / (x(1) .^ 3 - bvan)) .^ kappa;
        pb = adiabat + sc_pvapour;
        tmpP = (sc_twosigma + sc_fourmu * x(2)) / x(1);
        p = pb - tmpP;
        P1 = -threekappa*adiabat* x(1) .^ 2 ...
        * x(2)/ (x(1) .^ 3 - bvan ) ...
        + tmpP * x(2) / x(1);
        tmpA = pinf + sc_Btait;
        tmpB = (p + sc_Btait) / tmpA;
        tmpC = tmpB .^ (-ntaitinv);
        tmpB = tmpB * tmpC;
        H = ndivnsub1 * (tmpB - 1) * tmpA;
        c = sqrt(sc_c0_square + ntaitsub1 * H);
        H1overc = tmpC / c;
        H2overc = (tmpB - ntait) / c / ntaitsub1;
        mach = x(2) / c;
        machA = 1. + mach;
        machB = 3. - mach;
        machC = 1. - mach;
        dx(1) = x(2);
        dx(2) = (machA * H - 0.5 * machB * x(2) * x(2) ...
        + machC * x(1) * (H1overc * P1 + H2overc * dotpinf)) ...
        / (machC * (x(1) + sc_fourmu * H1overc));
    end
end