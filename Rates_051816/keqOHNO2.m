% calculate Keq for OH + NO2 -> HOONO 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=keqOHNO2(T,M)
function j=keqOHNO2(T,M)
j=3.9e-27.*exp(10125../T);