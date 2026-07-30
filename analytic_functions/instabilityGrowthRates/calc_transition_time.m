function t_t = calc_transition_time(epsilon, a, lambda, F, s, eta_0)

numrt = (1 - epsilon) * a * lambda;
t_t = ln( F * sqrt(numrt) / ( s * eta_0) ) / s;