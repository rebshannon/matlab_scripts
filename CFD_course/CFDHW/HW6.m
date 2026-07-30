% Rebecca Shannon
% HW 6


%% Define Domain and Constants

xl = 0;
xr = 0.2;
yb = 0;
yt = 0.1;

xCells = 30;             % number of cells
yCells = 15;
Nx = xCells + 1;          % number of grid points
Ny = yCells +1;
dx = (xr - xl) / xCells; %spatial interval
x = [xl : dx : xr];     
dy = (yt - yb) / yCells; %spatial interval
y = [yb : dy : yt]; 

dt = 0.0002;
tend = 0.5;

c = 1;
nu = 0.01;
rho = 1;
n = 1;

maxErr = 1;
maxErrU = 1;

%% IC/BC
% u is (x, y, t)

u = zeros(Nx,Ny);
u(:,end) = 1;
v = zeros(Nx,Ny);
p = zeros(Nx,Ny,1);
pCorr = p;
BC0 = 0; % velocity boundary for x = 0, 2, y = 0
BC1 = 1; % velocity boundary for y = 1

%% Step 11: 2D Incompressible NS Lid Driven Cavity

while maxErrU > 1e-5
    
    % BC u
    u(1,:,n+1) = BC0;
    u(end,:,n+1) = BC0;
    u(:,1,n+1) = BC0;
    u(:,end,n+1) = BC1;

    % BC v
    v(1,:,n+1) = BC0;
    v(end,:,n+1) = BC0;
    v(:,1,n+1) = BC0;
    v(:,end,n+1) = BC0;
    np = 1;
    
    b = bFn(Nx,Ny,dx,dy,u(:,:,n),v(:,:,n),rho,dt);
    p(:,:,n+1) = pFn11(p(:,:,n),b,Nx,Ny,dx,dy);
    
    % velocity at time n+1
    for i = 2:Nx-1
        for j = 2:Ny-1
       
           u(i,j,n+1) = u(i,j,n) - u(i,j,n)*dt/dx * (u(i,j,n) - u(i-1,j,n)) ...
                - v(i,j,n)*dt/dy * (u(i,j,n) - u(i,j-1,n)) + nu*dt/dx^2 * ...
                (u(i+1,j,n) - 2*u(i,j,n) + u(i-1,j,n)) + nu*dt/dy^2 * ...
                (u(i,j+1,n) - 2*u(i,j,n) + u(i,j-1,n)) ...
                -dt/rho/dx/2 * (p(i+1,j,n+1) - p(i-1,j,n+1));
    
            v(i,j,n+1) = v(i,j,n) - u(i,j,n)*dt/dx * (v(i,j,n) - v(i-1,j,n)) ...
                - v(i,j,n)*dt/dy * (v(i,j,n) - v(i,j-1,n)) + nu*dt/dx^2 * ...
                (v(i+1,j,n) - 2*v(i,j,n) + v(i-1,j,n)) + nu*dt/dy^2 * ...
                (v(i,j+1,n) - 2*v(i,j,n) + v(i,j-1,n))...
                -dt/rho/dy/2 * (p(i,j+1,n+1) - p(i,j-1,n+1));
        end
    end

    maxErrU = max(abs(u(:,:,n+1) - u(:,:,n)),[],'all');
%     u(:,:,n+1)
%     v(:,:,n+1)
%     b
%     p(:,:,n+1)
%     pause
    
    n = n + 1;
       
end

Umag=sqrt(u(:,:,end).^2 + v(:,:,end).^2);

%% Plotting

time = dt*(n-2);

figure
surf(x,y,transpose(p(:,:,end)))
xlabel('x')
ylabel('y')
zlabel('p')
grid on
title(sprintf('Pressure at time t = %0.3f s',time))

figure
pcolor(x,y,transpose(Umag))
hold on
quiver(x,y,transpose(u(:,:,end)),transpose(v(:,:,end)),'y')
xlabel('x')
ylabel('y')
grid on
title(sprintf('Velcity at time t = %0.3f s',time))
