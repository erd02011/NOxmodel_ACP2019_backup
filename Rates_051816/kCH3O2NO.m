% calculate rate of CH3O2+NO -> CH3O + NO2
%												-> CH3ONO2 (BR=0.25%)???
%rate=kCH3O2NO(T,M)
function j=kCH3O2NO(T,M)
% j=3e-12.*exp(280../T);
j=2.8e-12.*exp(300./T);   % Tyndall, et. al, JGR 106, 12157-82, 2001