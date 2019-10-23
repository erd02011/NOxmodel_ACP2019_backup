% calculate rate of N + NO2 -> N2O + O
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% rate=kNNO2(T,M)
function j=kNNO2(T,M)
j=5.8e-12.*exp(220../T);