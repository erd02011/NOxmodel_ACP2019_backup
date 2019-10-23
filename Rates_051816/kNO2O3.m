% calculate rate of NO2 + O3 -> NO3 + O2
%  rate=kNO2O3(T,M)
function j=kNO2O3(T,M)
j=1.2e-13.*exp(-2450../T);
