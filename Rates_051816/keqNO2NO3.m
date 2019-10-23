% calculate Keq for NO2 + NO3 -> N2O5 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=keqNO2NO3(T,M)
function j=keqNO2NO3(T,M)
j=2.7e-27.*exp(11000../T);