function [tBar, y] = TAB(tSpanBar, y0, Oh, We, C2,opts)

% Function solves for the Tyalor Analogy Breakup for given initial
% conditons
% Inputs:
    % t: time interval (s, real time)
    % Oh: 
    % We:
    % C2: constant
    % y0: initial y location
    % Dy0: initial velocity
% Initial conditions: time series, initial size, acoustic excitation,
        % equilibrium radius

% Constants

m = 1;
c = 20*Oh;
u = 2*C2*We + 64;
k = 64;

dydtbar = @(tBarSpan,z)[z(2); (-c/m)*z(2) - (k/m)*z(1) + u/m]; % diff eq

[tBar, y] = ode45(dydtbar,tSpanBar,y0,opts);

dy = y(:,2);
y = y(:,1);

end