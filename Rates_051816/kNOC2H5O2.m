% calculate rate of C2H5O2 + NO -> products
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNOC2H5O2(T,M)
function j=kNOC2H5O2(T,M)
j=2.6e-12.*exp(365../T);