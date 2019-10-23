% calculate rate of OH + H2 -> H2O + H
% Updated 7/13/06 AEP
% Based on JPL Data Evaluation #15
% rate = kH2OH(T,M)
function j=kH2OH(T,M)
j=2.8e-12.*exp(-1800../T);
