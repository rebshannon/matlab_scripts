% Rebecca Shannon
% Leap Frog LInear Convection
% 1/25/24

%% Define Domain and Constants

xl = 0;
xr = 2;

cells = 200;             % number of cells
N = cells + 1;          % number of grid points
dx = (xr - xl) / cells; %spatial interval
x = [xl : dx : xr];     

dt = 0.008;
%tend = 0.5;
steps = 80; % define # of timesteps instead of an endtime

c = 1;


%% IC/BC
% 
% for i = 1:N
%     if 0.5 <= x(i) && x(i) <= 1
%         u(i,1) = 2;
%     else
%         u(i,1) = 1;
%     end
% end
% 
% BC1 = 0; % left side
% BC2 = 0; % right side

%% New IC

for i = 1:N
    if 0 <= x(i) && x(i) <= 1
         u(i,1) = sin(16*pi*x(i));
     else
         u(i,1) = 0;
     end
end

BC1 = 0; % left side
BC2 = 0; % right side

%% Linear Convection

for n = 1:steps
    u(1,n+1) = BC1;
    for i = 2:N-1
        u(i,n+1) = u(i,n) - c*dt/dx * (u(i,n) - u(i-1,n));
    end
    u(N,n+1) = BC2;
end

%% Leap Frog

ulf(:,1) = u(:,1);

for n = 1:steps %tend/dt
    ulf(1,n+1) = BC1;
    ulf(N,n+1) = BC2;
    if n == 1
        for i = 2:N-1
            ulf(i,n+1) = ulf(i,n) - ulf(i,n)*dt/dx * (ulf(i,n) - ulf(i-1,n));
        end
    else
        for i = 2:N-1
            ulf(i,n+1) = ulf(i,n-1) - c*dt/dx * (ulf(i+1,n) - ulf(i-1,n));
        end 
    end    
end

%% analytic solution
% 
% for i = 1:N
%     location = x(i) - c*tend;
%     index = abs(location) * cells;
%     u_exact = u(1,index);
% end

for i = 1:N
    if 0 <= (x(i) - c*steps*dt) && (x(i) - c*steps*dt) <= 1 
        uex(i) = sin(16*pi*(x(i) - c*steps*dt));
    else
        uex(i) = 0;
    end
end

%% Plot

figure
plot(x,uex)
hold on
plot(x,ulf(:,end))
%plot(x,u(:,end))
grid on
legend('Analytical','Leapfrog')
xlabel('x')
ylabel('y')
title({'Wave Packet at time t = 0.64','Wave Number = 16\pi'})
