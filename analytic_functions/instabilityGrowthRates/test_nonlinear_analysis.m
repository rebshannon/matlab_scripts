sigma = 0.0072;

rho_d = 998;

epsilon = rho_g / rho_d;


F = calc_F(sigma, Fr, epsilon, rho_d, a, lambda);

t_t = calc_transition_time(epsilon, a, lambda, F, s, eta_0);

zeta_0M = calc_zeta_initial(Fr, a, epsilon, lambda_ob, t_f);

