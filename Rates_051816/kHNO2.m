% calculate rate of NO2 + H -> OH + NO
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHNO2(T,M)
function j=kHNO2(T,M)

j=4.0e-10.*exp(-340../T);