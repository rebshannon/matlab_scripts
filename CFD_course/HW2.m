% Rebecca Shannon
% CFD HW2
% 2/1/24

%% Define Domain and Constants

xl = 0;
xr = 2;

cells = 100;             % number of cells
n = cells + 1;          % number of grid points
dx = (xr - xl) / cells; %spatial interval
x = [xl : dx : xr];     

dt = 0.001;
tend = 0.5;

c = 1;
nu = 1;


%% IC/BC

for i = 1:n
    if 0.5 <= x(i) && x(i) <= 1
        u(1,i) = 2;
    else
        u(1,i) = 1;
    end
end

BC1 = 1; % left side
BC2 = 1; % right side

% Step 3: 1D Diffusion
% rows are time and columns are space

for t = 1:tend/dt
    u(t+1,1) = BC1;
    for i = 2:n-1
        u(t+1,i) = u(t,i) + nu*dt*(u(t,i+1) - 2*u(t,i) + u(t,i-1)) / dx^2;
    end
    u(t+1,n) = BC2;
end


% %% Step 4: 1D Burgers
% 
% for t = 1:tend/dt
%     u(t+1,1) = BC1;
%     for i = 2:n-1
%         u(t+1,i) = u(t,i) + nu*dt*(u(t,i+1) - 2*u(t,i) + u(t,i-1)) / dx^2 ...
%             - u(t,i)*dt/dx * (u(t,i) - u(t,i-1));
%     end
%     u(t+1,n) = BC2;
% end
% 
% %% New BC for 1D Burgers
% 
% % cells = 100;             % number of cells
% % n = cells + 1;          % number of grid points
% dx = 2*pi / cells;      % spatial interval
% x = [0 : dx : 2*pi];  
% 
% phi = exp(-x.^2 ./ (4*nu)) + exp(- ((x-2*pi).^2) ./ (4*nu));
% dphidx = -2.*x./(4*nu) .* exp(-x.^2 ./ (4*nu)) - 2*(x-2*pi)./(4*nu) .*...
%     exp(- ((x-2*pi).^2) ./ (4*nu));
% 
% for i = 1:n
%     u(1,i) = - 2*nu/phi(i) * dphidx(i) + 4;
% end
% 
% 
% for t = 1:tend/dt
%     for i = 2:n-1
%         u(t+1,i) = u(t,i) + nu*dt*(u(t,i+1) - 2*u(t,i) + u(t,i-1)) / dx^2 ...
%             - u(t,i)*dt/dx * (u(t,i) - u(t,i-1));
%     end
%     u(t+1,1) = u(t,1) + nu*dt*(u(t,2) - 2*u(t,1) + u(t,n-1)) / dx^2 ...
%             - u(t,1)*dt/dx * (u(t,1) - u(t,n-1));
%     u(t+1,n) = u(t+1, 1);
% end
% 
% % analytical soln
% 
% t = 0.5
% for i = 1:n
%     phia = exp(- (x(i) - 4*t)^2 / (4*nu*(t+1))) + exp( - (x(i) - 4*t - 2*pi)^2 / (4*nu*(t+1)));
%     dphidxa = -2 * (x(i) - 4*t) / (4*nu*(t+1)) * exp(- (x(i) - 4*t)^2 / (4*nu*(t+1)))...
%         - 2 * (x(i) -4*t - 2*pi) / (4*nu*(t+1)) * exp( - (x(i) - 4*t - 2*pi)^2 / (4*nu*(t+1)));
%     ua(i) = -2*nu/phia * dphidxa +4;
% end

