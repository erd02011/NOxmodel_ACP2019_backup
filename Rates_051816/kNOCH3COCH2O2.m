% Rate of CH3C(O)CH2O2 + NO --> products 
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNOCH3COCH2O2(T,M)
function j=kNOCH3COCH2O2(T,M)
j=2.9e-12.*exp(300../T);