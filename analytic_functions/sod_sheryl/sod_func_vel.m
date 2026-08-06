function y = sod_func_vel(P)
% defines function to be used in sod_with_velocity
% source: pg 208 of https://soaneemrana.org/onewebmedia/NUMERICAL%20COMPUTATION%20OF%20INTERNAL%20&%20EXTERNAL%20FLOWS%20BY%20C.%20HIRSEH%20%28VOL.-2%29.pdf

%Initial conditions

p_L = 1e5;
rho_L = 1;
u_L = 50;

p_R = 1e3;
rho_R = 0.01;
u_R = 100;

gamma = 1.4;
gp1 = gamma +1.0;
gm1 = gamma -1.0;
alpha = gp1/gm1;

cR = sqrt(gamma * p_R/rho_R);
cL = sqrt(gamma* p_L/rho_L);

% 16.6.45 (think there's a typo)
y = (P-1) / sqrt(1+alpha*P) * sqrt(2/gamma/gm1) -  ...
    ( ...
        2/gm1*cL/cR * ... 
        ( 1 - (P*p_R/p_L)^(gm1/2/gamma) ) + ...
        (u_L - u_R)/cR ...
    );

% same equation in different form
% y = (P-1) / sqrt(1+alpha*P) * sqrt(2/gamma/gm1) -  ...
%     ( ...
%         2/gm1*cL/cR * ... 
%          ( (p_R/p_L)^(gm1/2/gamma) * ( (p_L/p_R)^(gm1/2/gamma) - P^(gm1/2/gamma) ) ) + ...
%         (u_L - u_R)/cR ...
%     );


end