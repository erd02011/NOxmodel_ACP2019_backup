% calculate rate of O1D + H2O -> 2OH
% Updated 7/13/06 AEP
% Based on JPL Data Evaluation #15
% rate = kO1DH2O(T,M)
function j=kO1DH2O(T,M)
j=1.63e-10.*exp(60./T); 