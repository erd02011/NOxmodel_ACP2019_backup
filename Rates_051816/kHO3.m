% calculate rate of H+O3 --> OH + O2
% Updated 7/13/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO3(T,M)
function j=kHO3(T,M)
j=1.4e-10.*exp(-470../T);
