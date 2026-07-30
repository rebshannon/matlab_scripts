function F = calc_F(sigma, Fr, epsilon, rho_d, a, lambda)

num = pi^2 * sigma;
den = (1 - epsilon) * rho_d * a * lambda^2;

F = Fr * sqrt( 1 - 4 * (num/den));
