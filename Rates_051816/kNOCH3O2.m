% calculate rate of CH3O2 + NO -> CH3O + NO2
% Updated 7/14/06 AEP
% Based on JPL Data Evaluation #15
% Tyndall, et. al, JGR 106, 12157-82, 2001
%  rate=kNOCH3O2(T,M)
function j=kNOCH3O2(T,M)
j=2.8e-12.*exp(300../T);