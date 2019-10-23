% calculate rate of C2H5O + NO2 -> C2H5ONO2 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=kNO2C2H5O(T,M)
function j=kNO2C2H5O(T,M)
k10o=2.0e-27.*(T./300).^(-4.0).*M;
k10oo=2.8e-11.*(T./300).^(-1.0);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;