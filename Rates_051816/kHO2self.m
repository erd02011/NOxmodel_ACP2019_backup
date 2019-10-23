% calculate rate of HO2 + HO2 -> H2O2 + O2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% rate=kHO2self(T,M,h2o)
function j=kHO2self(T,M,h2o)
j=(3.5e-13.*exp(430../T)+1.7e-33.*(M-h2o).*exp(1000../T)).*...
   (1+1.4e-21*h2o.*exp(2200./T));