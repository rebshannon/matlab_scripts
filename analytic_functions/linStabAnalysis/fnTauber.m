function [sigma,amplitude] = fnTauber(rho1, rho2, dU, T, lambda,Ao, t)

% Rebecca Shannon
% 11/1/23

% Function uses linear stability analysis from Tuaber (2002) to find the
%   growth rate  and amplitude ratio of a wave
% Applited to KHI

r = rho1 / rho2;
We = rho2*dU^2*lambda/T
sigma_tilde = 1/We * sqrt(1/(1 + r) * (r/(r+1) - 1/We));

sigma = sigma_tilde*rho2*dU^3/T;
amplitude = exp(sigma*t);

end
