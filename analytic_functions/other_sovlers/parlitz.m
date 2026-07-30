function xd=parlitz(t,x)
%global  Ro w vis Pv Po Ps Pg c gamma sigma dens  

global c1 c2 Ro w vis Pv Po Ps Pg c gamma sigma dens f ii P_R t_R tf xo_old told
% Parlitz Model of the Bubble Equation
% 
% Calculate New Variables
%__________________________________________________________
a1=(1-3*gamma)/c; 
a2=(Po-Pv)/dens+2*sigma/(dens*Ro);
a3=2*sigma/dens; 
a4=4*vis/(dens*c);
Pg= Po-Pv+2*sigma/Ro;	% Equilibrium Gas Pressure
% P(R,R',t)
P_R= Pg*(Ro/x(1))^(3*gamma)-Pg-4*vis*x(2)/x(1)-Ps*sin(w*t);%sinusoidal
%Pinside=Pg*(Ro/x(1))^(3*gamma)
% State Equations
%__________________________________________________________


xd(1)=x(2);
xd(2)=(-0.5*(x(2)^2)*(3-x(2)/c)+(1+a1*x(2))...
   *a2*(Ro/x(1))^(3*gamma)...
   -a3/x(1)-4*vis*x(2)/(dens*x(1))-(1+x(2)/c)...
   *(Po-Pv+Ps*sin(w*t))/dens-x(1)*w*Ps*cos(w*t)/(dens*c))...
   /((1-x(2)/c)*x(1)+a4);
xd=xd';
%plot(t/1e6,Pinside,'r*',t,x(1)*1e5,'b+');
%hold on;
