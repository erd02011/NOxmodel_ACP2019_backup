% calculate Keq for HO2 + NO2 -> HO2NO2 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=keqHO2NO2(T,M)
function j=keqHO2NO2(T,M)
j=2.1e-27.*exp(10900../T);