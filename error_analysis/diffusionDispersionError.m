% Rebecca Shannon
% Diffusion and Dispersion Analysis
% Linear Convection
% 2/6/24

%% Define Range

phi = [0:pi/32:pi];
S = [0.25 0.5 0.75 0.8 1];

%% Error Calcs 
% every row is a new sigma


for i = 1:length(S)
    reG(i,:) = 1 - S(i) + S(i).*cos(phi);
    imG(i,:) = -S(i)*sin(phi);
    
    magG(i,:) = sqrt(reG(i,:).^2 + imG(i,:).^2);
    
    epsD(i,:) = magG(i,:) / 1;
    epsPhi(i,:) = atan2(-imG(i,:),reG(i,:)) ./ (S(i)*phi);
end

%% Plotting

figure
plot(phi,epsD)
grid on
ylabel('\epsilon_D')
xlabel('\phi')
title('Diffusion Error')
legend('\sigma = 0.25','\sigma = 0.5','\sigma = 0.75','\sigma = 1')

figure
plot(phi,epsPhi)
grid on
ylabel('\epsilon_{\phi}')
xlabel('\phi')
title('Dispersion Error')
legend('\sigma = 0.25','\sigma = 0.5','\sigma = 0.75','\sigma = 1')
