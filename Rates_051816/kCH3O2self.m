% calculate rate of CH3O2 + CH3O2 -> 2CH3O + O2 (a) & CH3OH + CH2O + O2 (b)
% relative yield a/b = 26.2*exp(-1130/T)
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kCH3O2self(T,M)
function j=kCH3O2self(T,M)
j=9.5e-14.*exp(390../T);