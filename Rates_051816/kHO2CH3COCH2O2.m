% calculate rate of CH3C(O)CH2O2 + HO2 -> products
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO2CH3COCH2O2(T,M)
function j=kHO2CH3COCH2O2(T,M)
j=8.6e-13.*exp(700../T);