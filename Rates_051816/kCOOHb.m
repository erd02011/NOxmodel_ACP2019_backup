% calculate rate of OH + CO + O2 -> HO2 + CO2 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
%  rate=kCOOHb(T,M)
function j=kCOOHb(T,M)
k10o=1.5e-13.*(T./300).^(0).*M;
k10oo=2.1e9.*(T./300).^(6.1);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;