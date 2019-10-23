% calculate rate of HO2 +NO -> OH + NO2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% rate=kNOHO2(T,M)
%   uncertainties   A  1.2  E/R  +-80
function j=kNOHO2(T,M)
j=3.5e-12.*exp(250../T);
