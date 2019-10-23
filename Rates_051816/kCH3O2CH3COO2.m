% calculate rate of CH3O2 + CH3COO2 -> CH3 + CO2 + CH3O + O2 (90%) & CH3COOH
% + H2CO + O2 (10%) at 298K
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kCH3O2CH3COO2(T,M)
function j=kCH3O2CH3COO2(T,M)
j=1.3e-12.*exp(640../T);