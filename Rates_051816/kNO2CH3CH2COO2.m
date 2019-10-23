% calculate rate of CH3CH2COO2 + NO2 -> C2H5O2NO2 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=kNO2CH3CH2COO2(T,M)
function j=kNO2CH3CH2COO2(T,M)
k10o=9.0e-28.*(T./300).^(-8.9).*M;
k10oo=7.7e-12.*(T./300).^(-0.2);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;