% Rate of CH3C(O)O2 + CH3C(O)O2 --> CH3C(O)O + O2  
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kCH3COO2self(T,M)
function j=kCH3COO2self(T,M)
j=2.9e-12.*exp(500../T);