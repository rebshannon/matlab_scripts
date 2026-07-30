% Rebecca Shannon
% Implicit Matrix FD
% 1/30/24

%% Define Domain and Constants

xl = 0;
xr = 2;

cells = 200;             % number of cells
N = cells + 1;          % number of grid points
dx = (xr - xl) / cells; %spatial interval
x = transpose([xl : dx : xr]);     

dt = 0.001;
tend = 0.5;

nu = 1;
C = dt*nu/(2*dx^2);

%% IC/BC

for i = 1:N
    if 0.5 <= x(i) && x(i) <= 1
        uIC(i,1) = 2;
    else
        uIC(i,1) = 1;
    end
end

BC1 = 1; % left side
BC2 = 1; % right side

%% Set up CN matrices

% [u](n+1) = [A]^-1 {[BC] + [B][u](n)}
% rows in u is space, columns is time

A = zeros(N,N);
B = zeros(N,N);
u = zeros(N,tend/dt);
BC = zeros(N,1);

% set up matices

A(1,1) = 1;
A(N,N) = 1;
for n = 2:N-1
    A(n,n-1) = -C;
    A(n,n) = 1+2*C;
    A(n,n+1) = -C;
    B(n,n-1) = C;
    B(n,n) = 1-2*C;
    B(n,n+1) = C;
end

BC(1) = 1;
BC(N) = 1;
    
% IC on u

u(:,1) = uIC;

%% Solve matrix equation

for n = 1:tend/dt
    u(:,n+1) = inv(A) * (BC + B*u(:,n));
end

%% Explicit Scheme

uex(:,1) = uIC;

for n = 1:tend/dt
    uex(1,n+1) = BC1;
    for i = 2:N-1
        uex(i,n+1) = uex(i,n) + nu*dt*(uex(i+1,n) - 2*uex(i,n) + uex(i-1,n)) / dx^2;
    end
    uex(i+1,n+1) = BC2;
end


%% Plot

figure
plot(x,u(:,1))
hold on
plot(x,u(:,end))
plot(x,uex(:,end))
grid on 
xlabel('x')
ylabel('u')
legend('t = 0', 't = 0.5')