% calculate rate of ClO + NO2 -> ClONO2
%  rate=kClONO2(T,M)
function j=kClONO2(T,M)
k0=1.8e-31.*(T./300).^(-3.4);
koo=1.5e-11.*(T./300).^(-1.9);
k1=k0.*M./(1+(k0.*M./koo));                       
k2=(.6.^( (1+( log10(k0.*M./koo) ).^2).^(-1)) );
l=real(k2);
j=(k1.*l);
