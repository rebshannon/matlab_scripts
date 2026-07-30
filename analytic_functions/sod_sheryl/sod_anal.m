%sod analytic 

%% Initial Conditions

p_L = 1e5;
rho_L = 1;
u_L = 0;

p_R = 1.0e4;
rho_R = 0.125;
u_R = 0;

%% Constants

gamma = 1.4;
gp1 = gamma +1.0;
gm1 = gamma -1.0;
cR = sqrt(gamma * p_R/rho_R);
cL = sqrt(gamma* p_L/rho_L);

% location of discontinuity at t = 0
         xi = 5;

% time at which solution is desired
         t = 0.0061;  %6.1ms

% spatial interval over which to compute solution
% domain size
         xl = 0;
         xr = 10;

% number of points in range 
        n = 1000;
        dx = (xr-xl)/(n-1);
        x = [xl:dx:xr];

% leave out all u_R and u_L terms in all equations below here 

% solve for P/P_R    pi is initial value  - have to repeat initial cond
% inside of sod_func
P_solve = fzero('sod_func',3*pi);

p2 = P_solve*p_R;
p3 = p2;

% contact discontinuity speed 
V = 2/gm1*cL*(1-(p3/p_L)^(gm1/2/gamma));
u2 = V;
u3 = V;
% check 
rho3 = rho_L*(p3/p_L)^(1/gamma);
c3check = sqrt(gamma*p3/rho3);

% speed of sound in region 3 
c3 = cL - gm1/2*V;

% shock speed 
c = (P_solve -1)*cR^2/gamma/u2;

xshock = xi + c*t;
xdiscontinuity = xi + V*t;
xfootfan = xi + (u3-c3)*t;
xtopfan = xi - cL*t;


for i = 1:n
    
    if (x(i) < xtopfan)  
        p(i) = p_L;
        u(i) = u_L;
        rho(i) = rho_L;
    elseif (x(i) < xfootfan)  % u5 formula
            u(i) = 2/gp1 *((x(i)-xi)/t + cL + gm1/2*u_L);
            c5 = u(i) - ( (x(i) - xi)/t);
           % p(i) = p_L*(u(i)/cL)^(2*gamma/gm1);
           p(i) = p_L*(c5/cL)^(2*gamma/gm1);
            rho(i) = (p(i)/p_L)^(1/gamma)*rho_L;
    elseif (x(i) < xdiscontinuity)
            u(i) = u3;
            p(i) = p3;
            rho(i) = rho3;
    elseif (x(i) < xshock) 
         u(i) = u2;
         p(i) = p2;
         rho(i) = rho_R* gp1/2/gamma*(p(i)/p_R*gp1 +gm1) / ...
             (  gm1/2/gamma*(p(i)/p_R*gp1 + gm1) + 2 );
      else 
            u(i) = u_R;
            p(i) = p_R;
            rho(i) = rho_R;
        end
end
            
            
figure
plot(x,u);
ylabel('velocity')
xlabel('x location')
figure
plot(x,p);
ylabel('pressure')
xlabel('x location')
figure
plot(x,rho);
ylabel('density');
xlabel('x location');
