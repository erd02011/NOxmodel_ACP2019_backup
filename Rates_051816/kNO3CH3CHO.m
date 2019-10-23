% calculate rate of NO3 + CH3CHO -> HNO3 + CH3CO
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kNO3CH3CHO(T,M)
function j=kNO3CH3CHO(T,M)
j=1.4e-12.*exp(-1900../T);