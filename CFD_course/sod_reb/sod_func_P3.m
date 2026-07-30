function y = sod_func(P, P_1, P_5, rho_5, gamma)
%defines function to be used in analytic_sod

% evaluate P_3 based on a guess pressure
% P_3 = P

lambda = (gamma - 1)/(gamma + 1);
beta = (gamma-1)/(2*gamma);

y = (P - P_5)*sqrt( (1-lambda) / (rho_5*(P+lambda+P_5)) ) - ...
    (P_1^beta - P^beta)*sqrt( ((1-lambda^2) * P_1^(1/gamma)) / (lambda^2*rho_1));

end
