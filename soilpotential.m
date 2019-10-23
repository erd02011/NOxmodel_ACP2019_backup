function [SWP] = soilpotential(hour,maxSWP,minSWP,tshiftswp)
%computes diurnal NO2 adv
A = (maxSWP-minSWP)/2;
tau = tshiftswp;
P = 24;
omega = 2*pi/P;
offset = (maxSWP+minSWP)/2;
SWP = A*cos(omega*(hour-tau))+offset;
 

end
