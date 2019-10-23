% calculate Keq for NO2 + CH3O2 -> CH3O2NO2 (PAN) 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #18 
%  rate=keqNO2CH3COO2(T,M)
function j=keqNO2CH3O2(T,M)
j=9.5e-29.*exp(11234../T);