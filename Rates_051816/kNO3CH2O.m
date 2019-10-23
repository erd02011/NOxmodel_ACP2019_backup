% calculate rate of NO3 + CH2O -> HNO3 + HCO
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNO3CH2O(T,M)
function j=kNO3CH2O(T,M)
j=5.8e-16.*exp(0../T);