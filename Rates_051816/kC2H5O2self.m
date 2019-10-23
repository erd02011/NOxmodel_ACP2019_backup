% calculate rate of C2H5O2 + C2H5O2 -> 2C2H5O + O2 (60%) & CH3CHO + C2H5OH
% + O2 (40%) & C2H5O2C2H5 + O2 (<5%)
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kC2H5O2self(T,M)
function j=kC2H5O2self(T,M)
j=6.8e-14.*exp(0../T);