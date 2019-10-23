function j = kN2O5_decomp(T,M)
%calculate decomposition of N2O5 from JPL evaluation of NO2 + NO3 and Keq

Keq = 2.7e-27.*exp(11000../T);
j = kNO2NO3(T,M)/Keq;

end

