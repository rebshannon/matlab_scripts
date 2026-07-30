
% number of nodes 
N = 7;

% Diffusion with Cirichlet boundary conditions  (leavning out the
% alpha/dx^2)
amat = zeros(N-1,N-1);
amat(1,1) = -2;
amat(1,2) = 1;
for i = 2: N-2
    amat(i,i) = -2;
    amat(i,i-1) = 1;
    amat(i,i+1) = 1;
end
amat(N-1,N-1) = -2;
amat(N-1, N-2) = 1; 

amat
eigers = eig(amat)

for i = 1:N-1
    analeig(i) = -4*(sin(pi*i/2/(N)))^2;
end
analeig


%Diffusion wiht Neuman 

amat = zeros(N-1,N-1);
amat(1,1) = -1;
amat(1,2) = 1;
for i = 2: N-2
    amat(i,i) = -2;
    amat(i,i-1) = 1;
    amat(i,i+1) = 1;
end
amat(N-1,N-1) = -2;
amat(N-1, N-2) = 1; 

amat
eigers = eig(amat)

for i = 1:N-1
    analeig(i) = -4*(sin(pi*(2*i-1)/(2*N-1)/2))^2;
end
analeig


%% Diffusion with periodic 

amat = zeros(N,N);
amat(1,1) = -2;
amat(1,2) = 1;
amat(1,N) = 1;
for i = 2: N-1
    amat(i,i) = -2;
    amat(i,i-1) = 1;
    amat(i,i+1) = 1;
end
amat(N,N) = -2;
amat(N, N-1) = 1;
amat(N,1) = 1;

amat
eigers = eig(amat)

for i = 1:N
    analeig(i) = -4*(sin(pi*i/N))^2;
end
analeig


%%% convection - upwind left bdy cndition
amat = zeros(N,N);
amat(1,1) = 1;
for i = 2: N-1
    amat(i,i) = 1;
    amat(i,i-1) = -1;
end
amat(N,N) = 1;
amat(N, N-1) = -1;


amat
eigers = eig(amat)


analeig = 1

%  convection central with left bdy condition
N = 15;
amat = zeros(N,N);
amat(1,1) = 0;
amat(1,2) = 1;
for i = 2: N-1
    amat(i,i) = 0;
    amat(i,i-1) = -1;
    amat(i,i+1) = 1;
end
amat(N,N) = 2;
amat(N, N-1) = -2;

% take into accuont the negative in front of matrix but leave out a/2/dx
eigers = eig(-amat)
figure(1)
plot(real(eigers), imag(eigers),'o');
axis equal
