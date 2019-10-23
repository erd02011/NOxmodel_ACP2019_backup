% calculate rate of OH + CO -> HOCO 
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15 
% HOCO + O2 will give HO2 and CO2 pretty quickly - use kO2HOCO
%  rate=kCOOHa(T,M)
function j=kCOOHa(T,M)
k10o=5.9e-33.*(T./300).^(-1.4).*M;
k10oo=1.1e-12.*(T./300).^(1.3);
k10=(k10o./(1+(k10o./k10oo))).*0.6.^((1+(log10(k10o./k10oo)).^2).^(-1.0));
j=k10;
