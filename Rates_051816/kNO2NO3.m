% calculate rate of NO2 + NO3 -> N2O5
% Updated 8/19/15 TLS
% Based on JPL 2011 Publication 10-6 Evaluation 17 
% rate = kNO2NO3(T,M)
% 
function j = kNO2NO3(T,M)
    ko = 2.0e-30.*(T./300).^-4.4;
    koo = 1.4e-12.*(T./300).^-0.7;
    k1 = ko.*M./koo;
    k2 = ko.*M./(1+k1);
    k3 = (log10(k1)).^2;
    

    j = k2.*0.6.^((1 + k3).^-1);