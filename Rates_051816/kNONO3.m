% calculate rate of NO + NO3 -> 2NO2
% rate = kNONO3(T,M)
function j=kNONO3(T,M)
  j=(1.5e-11).*exp(170./T);
