%% REBECCA SHANNON
% 8/5/2026
% Sod shock tube solver with initial velocity
% source: pg 208 of https://soaneemrana.org/onewebmedia/NUMERICAL%20COMPUTATION%20OF%20INTERNAL%20&%20EXTERNAL%20FLOWS%20BY%20C.%20HIRSEH%20%28VOL.-2%29.pdf

%% INITIAL CONDITIONS

p_L = 1e5;
rho_L = 1;
u_L = 50;

p_R = 1.0e3;
rho_R = 0.01;
u_R = 100;

% location of discontinuity at t = 0
xi = 5;

% time at which solution is desired
t = 0.0029;

%% GEOMETRY

% spatial interval over which to compute solution
% domain size
xl = 0;
xr = 10;

% number of points in range 
n = 1000;
dx = (xr-xl)/(n-1);
x = xl:dx:xr;

%% CONSTANTS

gamma = 1.4;
gp1 = gamma +1.0;
gm1 = gamma -1.0;
alpha = gp1/gm1;

cR = sqrt(gamma * p_R/rho_R);
cL = sqrt(gamma* p_L/rho_L);

% initialize variables
u = zeros(1,n);
p = zeros(1,n);
rho = zeros(1,n);

%% Pressure in Region 2 - interative solve
% contact discontinuity -> shock
% solve for P/P_R    pi is initial value  - have to repeat initial cond
% inside of sod_func

% P_ = p2 / p_R

P_ = fzero('sod_func_vel',3*pi);
p2 = P_*p_R;

%% SHOCK WAVE

% contact discontinuity speed
V = u_R + cR * ( (P_-1) / sqrt(1+alpha*P_) * 1 / sqrt(gamma*gm1/2)); % 16.6.36
u2 = V;

% density
rho2 = rho_R * ( 1 + alpha*P_) / (alpha + P_); % 16.6.35

% shock speed 
C_shock = cR^2 * (P_-1)/(gamma * (u2 - u_R)) + u_R; % 16.6.37

%% CONTACT SURFACE
% find region 3 pressure and velocity

p3 = p2; % 16.6.39
u3 = u2; % 16.6.40

%% EXPANSION FAN
% equations for region in the expansion fan are in Assign Values

% density in region 3 (bottom of fan)
rho3 = rho_L*(p3/p_L)^(1/gamma); % 16.6.41b

% speed of sound in region 3 
c3 = cL + (u_L - u3) * gm1/2; % 16.6.42

%% REGION ENDPOINTS

xshock = xi + C_shock*t; % between 2 and R
xdiscontinuity = xi + V*t; % between 3 and 2
xfootfan = xi + (u3-c3)*t; % between 5 and 3
xtopfan = xi - (cL-u_L)*t; % between L and 5

%% ASSIGN VALUES

for i = 1:n
    
    if (x(i) < xtopfan)  
        % region L (5)
        p(i) = p_L;
        u(i) = u_L;
        rho(i) = rho_L;
    elseif (x(i) < xfootfan)  % u5 formula
        % region 5 - expansion fan
        % text calls this region 5 but there is no region 4
        u(i) = 2/gp1 *((x(i)-xi)/t + cL + gm1/2*u_L); % 16.6.49
        c5 = u(i) - ( (x(i) - xi)/t); % 16.6.48
        p(i) = p_L*(c5/cL)^(2*gamma/gm1); % 16.6.50 (last, think there's a typo)
        rho(i) = (p(i)/p_L)^(1/gamma)*rho_L; % 16.6.46
    elseif (x(i) < xdiscontinuity)
        % region 3
        u(i) = u3;
        p(i) = p3;
        rho(i) = rho3;
    elseif (x(i) < xshock) 
        % region 2
        u(i) = u2;
        p(i) = p2;
        rho(i) = rho2;
    else 
        % region R (1)
        u(i) = u_R;
        p(i) = p_R;
        rho(i) = rho_R;
    end
end
            
%% Plotting

figure(1)
plot(x,u);
ylabel('velocity')
xlabel('x location')
figure(2)
plot(x,p);
ylabel('pressure')
xlabel('x location')
figure(3)
plot(x,rho);
ylabel('density');
xlabel('x location');
