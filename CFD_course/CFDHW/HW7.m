% Rebecca Shannon
% HW 7


%% Define Domain and Constants

xl = 0;
xr = 10;
yb = 0;
yt = 2;

xCells = 20;             % number of cells
yCells = 10;
Nx = xCells + 1;          % number of grid points
Ny = yCells +1;
dx = (xr - xl) / xCells; %spatial interval
x = [xl : dx : xr];     
dy = (yt - yb) / yCells; %spatial interval
y = [yb : dy : yt]; 

dt = 0.2;
tend = 1;

c = 1;
nu = 0.01;
rho = 1;
n = 1;
F = 0.02;

maxErr = 1;
maxErrU = 1;

%% IC/BC
% u is (x, y, t)

u = zeros(Nx,Ny);
v = zeros(Nx,Ny);
p = zeros(Nx,Ny,1);
pCorr = p;
BC0 = 0; % BC is 0 at all walls, inlet and outlet are periodic

%% Step 12: 2D Incompressible NS Horizontal Flow

while maxErrU > 1e-5
    
    % BC u
    u(:,1,n+1) = BC0;
    u(:,end,n+1) = BC0;

    % BC v
    v(:,1,n+1) = BC0;
    v(:,end,n+1) = BC0;
    np = 1;
    
    % pressure at time n+1
    b = bFn(Nx,Ny,dx,dy,u(:,:,n),v(:,:,n),rho,dt);
    p(:,:,n+1) = pFn(p(:,:,n),b,Nx,Ny,dx,dy);
    
    % velocity at time n+1
    for i = 2:Nx-1
         

            for j = 2:Ny-1
           
               u(i,j,n+1) = u(i,j,n) - u(i,j,n)*dt/dx * (u(i,j,n) - u(i-1,j,n)) ...
                    - v(i,j,n)*dt/dy * (u(i,j,n) - u(i,j-1,n)) ...
                    + nu*dt/dx^2 * (u(i+1,j,n) - 2*u(i,j,n) + u(i-1,j,n)) ...
                    + nu*dt/dy^2 * (u(i,j+1,n) - 2*u(i,j,n) + u(i,j-1,n)) ...
                    - dt/(rho*2*dx) * (p(i+1,j,n+1) - p(i-1,j,n+1)) + F*dt;
        
                v(i,j,n+1) = v(i,j,n) - u(i,j,n)*dt/dx * (v(i,j,n) - v(i-1,j,n)) ...
                    - v(i,j,n)*dt/dy * (v(i,j,n) - v(i,j-1,n)) ...
                    + nu*dt/dx^2 *(v(i+1,j,n) - 2*v(i,j,n) + v(i-1,j,n)) ...
                    + nu*dt/dy^2 *(v(i,j+1,n) - 2*v(i,j,n) + v(i,j-1,n))...
                    - dt/(rho*2*dy) * (p(i,j+1,n+1) - p(i,j-1,n+1));
            end
        
    end

    % periodi BC
    i = 1;
    
   for j = 2:Ny-1 % periodic BC left and right

       u(i,j,n+1) = u(i,j,n) - u(i,j,n)*dt/dx * (u(i,j,n) - u(end-1,j,n)) ...
            - v(i,j,n)*dt/dy * (u(i,j,n) - u(i,j-1,n)) ...
            + nu*dt/dx^2 * (u(i+1,j,n) - 2*u(i,j,n) + u(end-1,j,n)) ...
            + nu*dt/dy^2 * (u(i,j+1,n) - 2*u(i,j,n) + u(i,j-1,n)) ...
            - dt/(rho*2*dx) * (p(i+1,j,n+1) - p(end-1,j,n+1)) + F*dt;

        v(i,j,n+1) = v(i,j,n) - u(i,j,n)*dt/dx * (v(i,j,n) - v(end-1,j,n)) ...
            - v(i,j,n)*dt/dy * (v(i,j,n) - v(i,j-1,n)) ...
            + nu*dt/dx^2 *(v(i+1,j,n) - 2*v(i,j,n) + v(end-1,j,n)) ...
            + nu*dt/dy^2 *(v(i,j+1,n) - 2*v(i,j,n) + v(i,j-1,n))...
            - dt/(rho*2*dy) * (p(i,j+1,n+1) - p(i,j-1,n+1));
        
        u(end,j,n+1) = u(i,j,n+1);
        v(end,j,n+1) = v(i,j,n+1);
   
   end


    % check error
    maxErrU = max(abs(u(:,:,n+1) - u(:,:,n)),[],'all');
    n = n + 1;

%     b
%     p(:,:,end)
%     u(:,:,end)
%     v(:,:,end)
%     pause
       
end

%% Analytic

for j = 1:Ny
    uan(j) = -F*y(j) / (2*nu) * (y(j)-yt);
end

%% U mag

Umag = sqrt(u(:,:,:).^2 + v(:,:,:).^2);


%% Plotting

time = dt*(n-2);

xcut = (length(y)-1)/2;

% analytic v numeric
figure
plot(y,u(xcut,:,end),y,uan)
xlabel('y')
ylabel('u')
grid on
title(sprintf('Velocity (u) at x = %.0f',x(xcut+1)))
legend('Numeric','Analytic')

% Pressure Field
figure
surf(x,y,transpose(p(:,:,end)))
xlabel('x')
ylabel('y')
zlabel('p')
grid on
title(sprintf('Pressure at time t = %0.3f s',time))

% pcolor and quiver plot of velocity u
figure
pcolor(x,y,transpose(u(:,:,end)))
hold on
quiver(x,y,transpose(u(:,:,end)),transpose(v(:,:,end)),'r')
xlabel('x')
ylabel('y')
grid on
title(sprintf('Velcity at time t = %0.3f s',time))
% 

% pcolor and quiver plot of velocity mag
figure
pcolor(x,y,transpose(Umag(:,:,end)))
hold on
quiver(x,y,transpose(u(:,:,end)),transpose(v(:,:,end)),'r')
xlabel('x')
ylabel('y')
grid on
title(sprintf('Velcity at time t = %0.3f s',time))


