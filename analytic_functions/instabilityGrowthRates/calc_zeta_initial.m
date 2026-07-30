function zeta_0M = calc_zeta_initial(Fr, a, epsilon, lambda_ob,t_f)

num = Fr * sqrt( a * (1-epsilon) * lambda_ob);
denTerm = 2*pi*a * (1-epsilon) / (lambda_ob * (1+epsilon));


zeta_0M = num/ (exp( 0.5 * (t_f * sqrt(denTerm) + ln(denTerm))));