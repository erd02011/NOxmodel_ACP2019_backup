% calculate rate of OH + HONO -> H2O + NO2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% rate=kHONOOH(T,M)
% uncertainties   A  1.2  E/R  +-80
function j=kHONOOH(T,M)
j=1.8e-11.*exp(-390../T);
