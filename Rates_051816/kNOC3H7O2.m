% calculate rate of C3H7O2 + NO -> products
% Updated 7/18/06 AEP
% Based on R. Atkinson J.P. Chem Ref Data 1992
% Rate constant is the same for both the 1- and 
% 2- peroxy radical
%  rate=kNOC3H7O2(T,M)
function j=kNOC3H7O2(T,M)
j=8.9e-12.*exp(0../T);