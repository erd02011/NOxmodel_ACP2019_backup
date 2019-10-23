% calculate rate of CH3C(O)O2 + HO2 -> products
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO2CH3COO2(T,M)
function j=kHO2CH3COO2(T,M)
j=4.3e-13.*exp(1040../T);