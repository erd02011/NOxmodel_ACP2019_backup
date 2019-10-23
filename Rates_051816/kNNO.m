% calculate rate of N + NO -> N2 + O
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% rate=kNNO(T,M)
function j=kNNO(T,M)
j=2.1e-11.*exp(100../T);