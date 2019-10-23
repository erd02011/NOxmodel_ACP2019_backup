% calculate rate of NO3 + NO3 -> 2NO2 + O2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNO3self(T,M)
function j=kNO3self(T,M)
j=8.5e-13.*exp(-2450../T);
