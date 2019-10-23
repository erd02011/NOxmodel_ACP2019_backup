% calculate rate of H + O2 + M -> HO2 + M
% Updated 7/18/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kHO2(T,M)
function j=kHO2(T,M)
k9o=4.4e-32.*(T./300).^(-1.3).*M;
k9oo=4.7e-11.*(T./300).^(-0.2).*M;
k9=(k9o./(1+(k9o./k9oo))).*0.6.^((1+(log10(k9o./k9oo)).^2).^(-1.0));
j=k9;
