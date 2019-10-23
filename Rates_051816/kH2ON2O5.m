% calculate rate of N2O5 + H2O -> 2HNO3 in the GAS PHASE
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% upper limit to rate
%  rate=kH2ON2O5(T,M)
function j=kH2ON2O5(T,M)
j=2.0e-21.*exp(0../T);