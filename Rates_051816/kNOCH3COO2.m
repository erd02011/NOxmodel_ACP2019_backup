% Rate of CH3C(O)O2 + NO --> products 
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNOCH3COO2(T,M)
function j=kNOCH3COO2(T,M)
j=8.1e-12.*exp(270../T);