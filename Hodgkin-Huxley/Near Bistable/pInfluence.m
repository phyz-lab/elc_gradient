function dp = pInfluence(t, p, xt, X)
ix = interp1(xt, X, t);

V = ix(1); m = ix(2); n = ix(3); h = ix(4);

C = 1;
psi = 1;

dVdV = -(120*h*m^3 + 36*n^4 + 3/10)/C;
dVdm = -(360*h*m^2*(V - 115))/C;
dVdn = -(144*n^3*(V + 12))/C;
dVdh = -(120*m^3*(V - 115))/C;

dmdV = m*(psi/(10*(exp(5/2 - V/10) - 1)) + (2*psi)/(9*exp(V/18)) + (psi*exp(5/2 - V/10)*(V/10 - 5/2))/(10*(exp(5/2 - V/10) - 1)^2)) - psi/(10*(exp(5/2 - V/10) - 1)) - (psi*exp(5/2 - V/10)*(V/10 - 5/2))/(10*(exp(5/2 - V/10) - 1)^2);
dmdm = (psi*(V/10 - 5/2))/(exp(5/2 - V/10) - 1) - (4*psi)/exp(V/18);
dmdn = 0;
dmdh = 0;

dndV = n*(psi/(100*(exp(1 - V/10) - 1)) + psi/(640*exp(V/80)) + (psi*exp(1 - V/10)*(V/100 - 1/10))/(10*(exp(1 - V/10) - 1)^2)) - psi/(100*(exp(1 - V/10) - 1)) - (psi*exp(1 - V/10)*(V/100 - 1/10))/(10*(exp(1 - V/10) - 1)^2);
dndm = 0;
dndn = (psi*(V/100 - 1/10))/(exp(1 - V/10) - 1) - psi/(8*exp(V/80));
dndh = 0;

dhdV = h*((7*psi)/(2000*exp(V/20)) - (psi*exp(3 - V/10))/(10*(exp(3 - V/10) + 1)^2)) - (7*psi)/(2000*exp(V/20));
dhdm = 0;
dhdn = 0;
dhdh = - psi/(exp(3 - V/10) + 1) - (7*psi)/(100*exp(V/20));

fx = [dVdV dVdm dVdn dVdh; dmdV dmdm dmdn dmdh; dndV dndm dndn dndh; dhdV dhdm dhdn dhdh];
Lx = [0 0 0 0];

dp = -fx' * p - Lx';