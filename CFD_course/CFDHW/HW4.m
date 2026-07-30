% Rebecca Shannon
% Diffusion and Dispersion Analysis
% Linear Convection - Leap Frog
% 2/8/24

%% Define Range

phi = [0:pi/25:2*pi];
S = [0.25 0.5 0.8 1];
%S = 0.8;

%% Error Calcs 
% every row is a new sigma

for i = 1:length(S)
    reG(i,:) = sqrt(1-(S(i)^2)*(sin(phi).^2));
%     reG(i,:) = 1i*sqrt((S(i)^2)*(sin(phi).^2)-1);
    imG(i,:) = -S(i)*sin(phi);
%     S(i)^2*(sin(phi).^2)-1

%     (reG(i,:))+1i*imG(i,:) 
%     pause
    
    magG(i,:) = sqrt(reG(i,:).^2 + imG(i,:).^2);
    
    epsD(i,:) = magG(i,:);
    epsPhi(i,:) = atan2(-imG(i,:),reG(i,:)) ./ (S(i)*phi);
end

%% Plotting

figure
plot(phi/pi,epsD)
grid on
ylabel('\epsilon_D')
xlabel('\phi/\pi')
title('Diffusion Error')
legend('\sigma = 0.25','\sigma = 0.5','\sigma = 0.8','\sigma = 1')

figure
plot(phi/pi,epsPhi)
grid on
ylabel('\epsilon_{\phi}')
xlabel('\phi/\pi')
title('Dispersion Error')
legend('\sigma = 0.25','\sigma = 0.5','\sigma = 0.8','\sigma = 1')