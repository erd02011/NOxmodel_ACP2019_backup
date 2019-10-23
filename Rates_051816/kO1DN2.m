% calculate rate of O1D + N2 + M -> O3P + N2 + M
% Updated 7/13/06 AEP
% Based on JPL Data Evaluation #15
% rate = kO1DN2(T,M)
function j=kO1DN2(T,M)
j=2.15e-11.*exp(110../T);
