% calculate rate of H + HO2 --> H2 + O2
% Updated 7/13/06 AEP
% Based on JPL Data Evaluation #15
% rate = kHHO2c(T,M)
function j=kHHO2c(T,M)
j=6.9e-12.*exp(0../T);