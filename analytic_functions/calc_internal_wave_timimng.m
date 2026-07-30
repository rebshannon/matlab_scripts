%% REBECCA SHANNON
% find acoustic timimg for internal pressure waves


% r = radius
% theta = angle from horizontal to point on perimeter measured from center
% dist = distance wave travels
% s = distance from center (probe location)

r = 0.001;
theta = linspace(0,90,100);
s = linspace(0,r,100);%[4*r/10,6*r/10,8*r/10];

gam_w = 4.4;
p1 = 1e5;
p_w = 6e8;
rhoWater = 1000;

for i = 1:length(s)

h = r * sin(deg2rad(theta));
l = s(i) + r*cos(deg2rad(theta));
dist(:,i) = sqrt( l.^2 + h.^2 );

end

c_water = sqrt(gam_w * (p1+p_w) / rhoWater);

t_wave = dist ./ c_water;

[x, y] = pol2cart(deg2rad(theta), r);

%figure
%scatter(x,y,[],t_wave)