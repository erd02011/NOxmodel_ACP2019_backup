% calculate rate of Cl + NO2 -> ClNO2
%  rate=kclno2(T,M)
function j=kClNO2(T,M)
k0=1.3e-30.*(T./300).^(-2);
koo=1e-10.*(T./300).^(-1);
k1=k0.*M./(1+(k0.*M./koo));                       
k2=(.6.^( (1+( log10(k0.*M./koo) ).^2).^(-1)) );
l=real(k2);
j=(k1.*l);
