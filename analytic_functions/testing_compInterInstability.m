rho_old = 1;
rho_new = 1;

alpha_old = 1;
tStep = 1e-8 /2;

% choosing index right before alpha begins to decrease
tStepInd = 737;

% dgdt is negative at this time so we get fully implicit(?)
Su = divU*alpha_old;
Sp = highPrecision_probeData(1).dgdt(tStepInd)/alpha_old;



psi_new = ( (rho_old * alpha_old)/(tStep) + Su - divUa ) * (1 / ( rho_new/tStep) - Sp);



% at t = 7.34e-6
alpha = 1;
divU = 4878.45947265625;
divAU = 4878.437357664127375755925;

dt = linspace(1e-10,1e-7,100);

newAlpha = (alpha./dt + alpha*divU - divAU) .* dt;