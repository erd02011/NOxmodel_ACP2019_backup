% calculate rate of HO2 +NO3 -> OH + NO2 + O2 (probably)
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% No temperature dependence - rate at 298K
% rate=kHO2NO3(T,M)
function j=kHO2NO3(T,M)
j=3.5e-12.*exp(0../T);