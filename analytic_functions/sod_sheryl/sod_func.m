function y = sod_func(P)
%defines function to be used in analytic_sod
%Initial conditions

p_L = 1e5;
rho_L = 1;
u_L = 0;

p_R = 1e4;
rho_R = 0.125;
u_R = 0;

gamma = 1.4;
gp1 = gamma +1.0;
gm1 = gamma -1.0;
cR = sqrt(gamma * p_R/rho_R);
cL = sqrt(gamma* p_L/rho_L);


y = (P -1)- sqrt(2*gamma/gm1)*cL/cR* sqrt(1 + gp1/gm1*P) * ...
    ( (p_L/p_R)^(gm1/2/gamma) - (P)^(gm1/2/gamma) )/ ((p_L/p_R)^(gm1/2/gamma));
end