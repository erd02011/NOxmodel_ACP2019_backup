% calculate rate of HO2 + NO2 -> HO2NO2
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO2NO2(T,M)
function j=kHO2NO2(T,M)
k10o=2.0e-31.*(T./300).^(-3.4).*M;
k10oo=2.9e-12.*(T./300).^(-0.7);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;
