% calculate rate of NO + O3 -> NO2 + O2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNOO3(T,M)
function j=kNOO3(T,M)
j=3.0e-12.*exp(-1500../T);
