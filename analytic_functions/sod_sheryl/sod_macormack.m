% Parameters
gamma=1.4;
R=287.04;
cv=R/(gamma-1);
eps_e1=0.01  % diffusion constant
eps_e2=0.0
epsilon=.0000001  % hard limit buffer

% Set up space/time grids
xmin = -10;
xmax = 10;
N = 1001;
dx = (xmax-xmin)/(N-1);
x = [xmin: dx: xmax];
maxspeed=374.17;
cfl=0.4
dt=cfl*dx/maxspeed


% Pre-allocate a few variables
u=zeros(1,N);
rho=zeros(1,N);
p=zeros(1,N);
EU=zeros(3,N);
EF=zeros(3,N);

EUs=EU;
EFs=EF;


% Initial condition
p_L=10^5;
p_R=10^4;
rho_L=1.0;
rho_R=0.125;
u_L=0.0;
u_R=0.0;

i = 1;

for  i=1:N;
   if x(i)<=0 
      u(i)=u_L;
      rho(i)=rho_L;
      p(i)=p_L;
   else
      u(i)=u_R;
      rho(i)=rho_R;
      p(i)=p_R;
   end
end



% put into conservative euler form
EU(1,:)=rho;
EU(2,:)=rho.*u;
EU(3,:)=p./(gamma-1)+rho.*u.^2/2.0;
EUn = EU;
EFn = EF;
% Simulate according to diff. eq.
itime = 0
while itime <= 6.1e-3
    itime = itime + dt;
  
   EUn = EU;
   % Set up flux vector
   EFn(1,:)=EUn(2,:);
   EFn(2,:)=(3-gamma)*EUn(2,:).^2./(2.0.*EUn(1,:))...
             + (gamma-1)*EUn(3,:);
   EFn(3,:)=gamma*EUn(2,:).*EUn(3,:)./EUn(1,:) ...
             - (gamma-1)/2.0.*EUn(2,:).^3./EUn(1,:).^2 ;
         
    % predictor step      
  for i = 2: N-1
      EUs(:,i) = EUn(:,i) - dt/dx*(EFn(:,i+1)-EFn(:,i)) + eps_e1*(EUn(:,i+1) -2*EUn(:,i) + EUn(:,i-1)) ;
  end % here?
  
  % Force physical boundaries to avoid instability
      rho_check=EUs(1,i);
      if rho_check<=0.0 
         EUs(1,i)=epsilon;
      end
      u_check=EUs(2,i)/EUs(1,i);
      if u_check>= maxspeed + 290.0;
         EUs(2,i)=(maxspeed-epsilon)*EUs(1,i); 
      end
      p_check=(EUs(3,i)-EUs(2,i).^2./EUs(1,i)/2.0)*(gamma-1);
      if p_check<=0.0 
         EUs(3,i)=epsilon/(gamma-1)+EUs(2,i).^2./EUs(1,i)/2.0*(gamma-1) ;
      end

  % end % here
EUs(1,1)=rho_L;
EUs(2,1)=rho_L*u_L;
EUs(3,1)=p_L/(gamma-1)+rho_L*u_L^2/2.0;

EUs(1,end)=rho_R;
EUs(2,end)=rho_R*u_R;
EUs(3,end)=p_R/(gamma-1)+rho_R*u_R^2/2.0;
  
  EFs(1,:)=EUs(2,:);
  EFs(2,:)=(3-gamma)*EUs(2,:).^2./(2.0.*EUs(1,:))...
             + (gamma-1)*EUs(3,:);
  EFs(3,:)=gamma*EUs(2,:).*EUs(3,:)./EUs(1,:) ...
             - (gamma-1)/2.0.*EUs(2,:).^3./EUs(1,:).^2 ;
         % corrector step
         
   for i = 2:N-1
       EU(:,i)=0.5*(EUn(:,i)+EUs(:,i)) ...
                - dt/2.0/dx*(EFs(:,i)-EFs(:,i-1)) + eps_e2*(EUs(:,i+1) -2*EUs(:,i) + EUs(:,i-1)) ;
  
   
   % Force physical boundaries to avoid instability
      rho_check=EU(1,i);
      if rho_check<=0.0 
         EU(1,i)=epsilon;
      end
      u_check=EU(2,i)/EU(1,i);
      if u_check>= maxspeed + 290.0;
         EU(2,i)=(maxspeed-epsilon)*EU(1,i); 
      end
      p_check=(EU(3,i)-EU(2,i).^2./EU(1,i)/2.0)*(gamma-1);
      if p_check<=0.0 
         EU(3,i)=epsilon/(gamma-1)+EU(2,i).^2./EU(1,i)/2.0*(gamma-1);

      end
   end
      
%   figure(1)
% plot(x,EU(1,:))
% %hold on
% 
%  figure(2)
% plot(x,EU(2,:)./EU(1,:))
% %hold on


end  
rho=EU(1,:);
u=EU(2,:)./rho;
p=(EU(3,:)-rho.*u.^2/2.0)*(gamma-1)

  figure(1)
plot(x,EU(1,:))
%hold on

 figure(2)
plot(x,EU(2,:)./EU(1,:))
%hold on
