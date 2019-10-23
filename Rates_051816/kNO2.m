% calculate rate of N + O2 -> NO + O 
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% rate=kNO2(T,M)
function j=kNO2(T,M)
j=1.5e-11.*exp(-3600../T);