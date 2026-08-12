%% REBECCA SHANNON
% script to visualize tait EoS

% water
B = 3046e5;
p0 = 101325;
rho0 = 1000;
gamma = 7.15;

p = 1;

rho = rho0 * ( (p+B) / (p0+B) ) .^ (1/gamma)
psi = rho0 / (gamma * (p0+B)) * ( (p+B) / (p0+B) ) .^ (1/gamma - 1)

%% air

% R = 8.3156;
% T = 300;
% 
% rho_a = p/(R*T);
% psi_a = 1/(R*T);
% 
% % % koch
% % 
% % beta = 0.0015;
% % gamma_a = 1.4;
% % p_n = 101315;
% % rho_n = 1.17;
% 
% for i = 1:length(p)
%     if p(i) < 2.5
%         p_lim(i) = 2.5;
%     else
%         p_lim(i) = p(i);
%     end
% end
% lrho_a = p_lim/(R*T);
% lpsi_a = 1/(R*T);
% 
% % 
% % rho_g = rho_n ./ ( (1-beta) * (p_n./p_lim).^(1/gamma_a) + beta);
% % psi_g = rho_g./(gamma_a * p_lim) .* (1 + beta ./((p_n./p_lim).^(1/gamma_a)*(1-beta)));
% 
% 
% % psi/rho vals
% 
% water_noMod = psi_w./rho_w;
% water_a05 = (0.5*psi_w + 0.5*1e-13) ./ rho_w;
% water_a001 = (0.99*psi_w + 0.01*1e-13) ./ rho_w;
% water_a0 = (1*psi_w + 0*1e-13) ./ rho_w;
% 
% lair_noMod = lpsi_a ./ lrho_a;
% lair_a05 = (0.5*lpsi_a + 0.5*1e-13) ./ lrho_a;
% lair_a001 = (0.01*lpsi_a + 0.99*1e-13) ./ lrho_a;
% lair_a0 = (0*lpsi_a + 1*1e-13) ./ lrho_a;
% 
% diff_noMod = lair_noMod - water_noMod;
% diff_a05 = lair_a05 - water_a05;
% diff_a001 = lair_a001 - water_a001;
% diff_a0 = lair_a0 - water_a0;
% 
% 




