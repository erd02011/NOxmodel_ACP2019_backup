% calculate rate of CH3O2 + CH3COCH2O2 -> CH3CO + H2CO + CH3O + O2 (30%) &
% CH3C(O)CH2OH + H2CO + O2 (20%) & CH3C(O)CHO + CH3OH + O2 (50%) at 298K
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
%  rate=kCH3O2CH3COCH2O2(T,M)
function j=kCH3O2CH3COCH2O2(T,M)
j=7.5e-13.*exp(500../T);