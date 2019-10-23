% calculate rate of CH3O2 + NO2 -> CH3O2NO2 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=kNO2CH3O2(T,M)
function j=kNO2CH3O2(T,M)
k10o=1.0e-30.*(T./300).^(-4.8).*M;
k10oo=7.2e-12.*(T./300).^(-2.1);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;