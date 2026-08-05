function y = sod_func_vel(P)
%defines function to be used in analytic_sod
% equation given in Expansion Fan region

%Initial conditions

p_L = 1e5;
rho_L = 1;
u_L = 100;

p_R = 1e4;
rho_R = 0.125;
u_R = 0;

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