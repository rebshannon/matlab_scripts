% Rebecca Shannon
% CFD HW3
% 2/6/24
% Q1 is in CN_diffusionTopHat.m

%% Define Domain and Constants

xl = 0;
xr = 2;
yl = 0;
yr = 2;

cells = 80;             % number of cells
N = cells + 1;          % number of grid points
dx = (xr - xl) / cells; %spatial interval
x = [xl : dx : xr];     
dy = (yr - yl) / cells; %spatial interval
y = [yl : dy : yr]; 

dt = 0.0001;
tend = 0.5;

c = 1;
nu = 1;


%% IC/BC
% u is (x, y, t)

for i = 1:N
    for j = 1:N
        if 0.5 <= x(i) && x(i) <= 1 && 0.5 <= y(j) && y(j) <= 1
            u(i,j,1) = 2;
            v(i,j,1) = 2;
        else
            u(i,j,1) = 1;
            v(i,j,1) = 1;
        end
    end
end

BC = 1; % all boundaries are the same

%% Step 8: 2D Burgers
% u(x,y,t)

for n = 1:tend/dt

    % BC u
    u(1,:,n+1) = BC;
    u(N,:,n+1) = BC;
    u(:,1,n+1) = BC;
    u(:,N,n+1) = BC;

    % BC v
    v(1,:,n+1) = BC;
    v(N,:,n+1) = BC;
    v(:,1,n+1) = BC;
    v(:,N,n+1) = BC;

    % Field values, u and v
    for i = 2:N-1
        for j = 2:N-1

            u(i,j,n+1) = u(i,j,n) - u(i,j,n)*dt/dx * (u(i,j,n) - u(i-1,j,n)) ...
                - v(i,j,n)*dt/dy * (u(i,j,n) - u(i-1,j,n)) + nu*dt/dx^2 * ...
                (u(i+1,j,n) - 2*u(i,j,n) + u(i-1,j,n)) + nu*dt/dy^2 * ...
                (u(i,j+1,n) - 2*u(i,j,n) + u(i,j-1,n));
  
            v(i,j,n+1) = v(i,j,n) - u(i,j,n)*dt/dx * (v(i,j,n) - v(i,j-1,n)) ...
                - v(i,j,n)*dt/dy * (v(i,j,n) - v(i,j-1,n)) + nu*dt/dx^2 * ...
                (v(i+1,j,n) - 2*v(i,j,n) + v(i-1,j,n)) + nu*dt/dy^2 * ...
                (v(i,j+1,n) - 2*v(i,j,n) + v(i,j-1,n));       
        end
    end
end

%% Plot

figure
surf(x,y,u(:,:,end))
xlabel('x')
ylabel('y')
zlabel('u')
grid on
title('u at time t = 0.5')

figure
surf(x,y,v(:,:,end))
xlabel('x')
ylabel('y')
zlabel('v')
grid on
title('v at time t = 0.5')

figure
surf(x,y,u(:,:,1))
xlabel('x')
ylabel('y')
zlabel('u')
grid on
title('u at time t = 0')

figure
surf(x,y,v(:,:,1))
xlabel('x')
ylabel('y')
zlabel('v')
grid on
title('v at time t = 0')

figure
surf(x,y,sqrt(u(:,:,1).^2 + v(:,:,1).^2))
xlabel('x')
ylabel('y')
zlabel('u')
grid on
title('U magnitude at time t = 0')

figure
surf(x,y,sqrt(u(:,:,end).^2 + v(:,:,end).^2))
xlabel('x')
ylabel('y')
zlabel('v')
grid on
title('U magnitude at time t = 0.5')
