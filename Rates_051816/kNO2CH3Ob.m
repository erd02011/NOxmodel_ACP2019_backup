% calculate rate of CH3O + NO2 -> CH3ONO2 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=kNO2CH3Ob(T,M)
function j=kNO2CH3Ob(T,M)
k10o=5.3e-29.*(T./300).^(-4.4).*M;
k10oo=1.9e-11.*(T./300).^(-1.8);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;