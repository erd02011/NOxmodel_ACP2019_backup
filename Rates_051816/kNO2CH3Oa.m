% calculate rate of CH3O + NO2 -> CH2O + HONO
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNO2CH3Oa(T,M)
function j=kNO2CH3Oa(T,M)
j=1.1e-11.*exp(-1200../T);