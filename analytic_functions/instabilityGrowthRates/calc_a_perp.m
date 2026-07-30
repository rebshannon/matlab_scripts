function a_perp, rho_g, p_g, u_g = calc_flow_param(U_2LF^2, Cd, rho_d, rho_2,rho_sd, d, phi_n, p_sd,gamma, p_2)

% acceleration
q2 = 1/2 * rho_2 * U_2LF^2;
a_mag = 3 * Cd * q2 / (2 * rho_d * d);
a_perp = a_mag * cos(phi_n);


% pressure
Cpmax = (p_sd - p_2) / q2;
p_g = p_2 + 1/2 * rho_2 * U_2LF^2 * Cpmax * cos(phi_n).^2;
p = p_2 + q2 * Cpmax * cos(phi_n).^2;
psdBypg = p_sd ./ p_g;

% density and velocity
M_g = sqrt(2 / (gamma - 1) * ( psdBypg .^ ((gamma - 1)/gamma) - 1 ));

rho_g = rho_sd ./ (psdBypg).^(1/gamma);
u_g = M_g .* sqrt(gamma * p_g ./ rho_g);

rho = 1 ./ (psdBypg).^(1/gamma);
