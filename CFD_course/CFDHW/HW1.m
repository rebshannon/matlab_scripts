% Rebecca Shannon
% CFD HW1
% 1/25/24

%% Define Domain and Constants

xl = 0;
xr = 2;

cells = 1000;             % number of cells
n = cells + 1;          % number of grid points
dx = (xr - xl) / cells; %spatial interval
x = [xl : dx : xr];     

dt = 0.0001;
tend = 0.5;

c = 1;


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

%% Step 1: 
% rows are time and columns are space

for t = 1:tend/dt
    u(t+1,1) = BC1;
    for i = 2:n-1
        u(t+1,i) = u(t,i) - c*dt*(u(t,i) - u(t,i-1))/dx;
    end
    u(t+1,n) = BC2;
end

plot(x,u(end,:))

% analytic solution

% for i = 1:n
%     location = x(i) - c*tend;
%     index = abs(location) * cells;
%     u_exact = u(1,i);
% end


%% Step 2: 
% rows are time and columns are space

% for t = 1:tend/dt
%     u(t+1,1) = BC1;
%     for i = 2:n-1
%         u(t+1,i) = u(t,i) - u(t,i)*dt*(u(t,i) - u(t,i-1))/dx;
%     end
%     u(t+1,n) = BC2;
% end