% Rebecca Shannon
% Steps 9 and 10
% 2/13/24

%% Define Domain and Constants

xl = 0;
xr = 2;
yl = 0;
yr = 1;

xCells = 100;             % number of cells
yCells = 50;
Nx = xCells + 1;          % number of grid points
Ny = yCells +1;
dx = (xr - xl) / xCells; %spatial interval
x = [xl : dx : xr];     
dy = (yr - yl) / yCells; %spatial interval
y = [yl : dy : yr];%0.0001;
tend = 0.5;

%% Define forcing function

% b = zeros(Nx,Ny);
% b(3*Nx/4,3*Ny/4) = -100;
% b(Nx/4,Ny/4) = 100;

%% IC/BC
% p is p(x, y, t)
% rows are x, columns are y
% when surf plotting, x and y are switched

p = zeros([Nx,Ny]);
p(end,:) = y;

x0BC = 0;       % xMin
xEndBC = y;     % xMax

pCorr = p;

% plot IC
figure
surf(x,y,transpose(p))
xlabel('x')
ylabel('y')
zlabel('p(x,y)')
title({'Step 9: 2D Laplace Equation','Initial Conditions'})
%title({'Step 10: Poisson Equation','Initial Conditions'})

% Initialize max error value and loop counter
maxErr = 1;
np = 0;

%% Step 9: 2D Laplace Equation
while maxErr > 1e-5 
    % pCorr = current pressure correction
    % pCorrPrv = last iteration pressure correction
    % loop while the max difference is greater than 1e-5
    pCorrPrev = pCorr;

    pCorr(1,:) = x0BC;
    pCorr(end,:) = xEndBC;

    for i = 2:Nx-1
        for j = 2:Ny-1

            pCorr(i,j) = (dy^2*(pCorr(i+1,j) + pCorr(i-1,j)) + ...
                dx^2*(pCorr(i,j+1) + pCorr(i,j-1))) / (2 * (dx^2 +dy^2));%...
                %+ b(i,j); % focing function for step 10, comment out for laplace
                
        end
        pCorr(i,1) = pCorr(i,2);
        pCorr(i,end) = pCorr(i,end-1);
    end

    % error function to determine the stop condition
    % convergence when there's less than 1e-5 difference
        % between timesteps
    maxErr = max(abs(pCorr - pCorrPrev),[],'all');
    np = np + 1;
       
end

p(:,:,2) = pCorr;

% plot pressure
figure
surf(x,y,transpose(p(:,:,end)))
xlabel('x')
ylabel('y')
zlabel('p(x,y)')
title({'Step 9: 2D Laplace Equation','Numerical Converged Pressure'})
%title({'Step 10: Poisson Equation','Numerical Converged Pressure'})

%% Analytic

sum1 = zeros(Nx,Ny);
pa = zeros(Nx,Ny);


for i = 1:Nx
    for j = 1:Ny
        for n = 1:2:7
            sum1(i,j) = sum1(i,j) + 1 / ((n*pi)^2*sinh(2*n*pi)) * ...
                sinh(n*pi*x(i)) * cos(n*pi*y(j));
        end
        pa(i,j) = x(i)/4 - 4*sum1(i,j);
    end
end



% plot analytic pressure
figure
surf(x,y,transpose(pa))
xlabel('x')
ylabel('y')
zlabel('p(x,y)')
title({'Step 9: 2D Laplace Equation','Analytic Pressure'})

% plot a line
figure
plot(x,p(:,26,end),x,pa(:,26))
xlabel('y')
ylabel('p')
legend('Numerical','Analytic','location','northwest')
grid on
title({'Step 9: 2D Laplace Equation','Pressure at x = 1'})





