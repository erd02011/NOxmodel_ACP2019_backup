% calculate rate of C2H5O2 + HO2 -> C2H5OOH + O2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO2C2H5O2(T,M)
function j=kHO2C2H5O2(T,M)
j=7.5e-13.*exp(700../T);