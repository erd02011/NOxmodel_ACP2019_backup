% calculate rate of HO2 + CH2O -> adduct
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO2CH2O(T,M)
function j=kHO2CH2O(T,M)
j=6.7e-15.*exp(600../T);