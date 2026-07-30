%% KOBEL PARAM CALCULATOR
% Rebecca Shanon
% 11/18/25
% enter max bubble radius, droplet radius, and bubble location
% get the kobel nondim parameters

Rd = input('Enter droplet radius in meters: ');
Rb = input('Enter maximum bubble radius in meter: ');
d = input('Enter bubble location relative to droplet center: ');

alpha = Rb / Rd;
epsilon = d / Rd;

bubrad = strcat('Relative radius is ',num2str(alpha));
eccentricity = strcat('Eccentricity is ',num2str(epsilon));

if alpha > 0.5
    zone = 'C';
elseif -1.25*eccentricity+0.75 <alpha
    zone = 'A';
else
    zone = 'B';
end

zoneName = strcat('Breakup Regime is ',zone);

sprintf(bubrad)
sprintf(eccentricity)
sprintf(zoneName)