% calculate rate of HO2 + O3 -> OH + 2 O2
% Updated 7/13/06 AEP
% Based on JPL Data Evaluation #15
% rate = kHO2O3(T,M)
%   uncertainties  A  1.3  E/R +500 -100
function j=kHO2O3(T,M)
  j=1.0e-14.*exp(-490../T);
