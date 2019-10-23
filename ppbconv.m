function [moleccm3] = ppbconv(P,T)
%converts ppb to molecules/cm^3
Av = 6.022E23;
R = 82.057;
moleccm3 =10^(-9).*Av.*P./(R.*T);
end

