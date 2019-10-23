function [airT, RH] = met_diurnal(hour,maxRH,minRH,maxT,minT,tshiftrh,tshiftT)
% calculates RH, using met data from region of interest

A = (maxRH-minRH)/2;
tau = tshiftrh;
P = 24;
omega = 2*pi/P;
offset = (maxRH+minRH)/2;
x = mod(hour, 24);

 RH = A*cos(omega*(hour-tau))+offset;
 

A = (maxT-minT)/2;

tau = tshiftT;
P = 24;
omega = 2*pi/P;
offset = (maxT+minT)/2;
    
airT = A*cos(omega*(hour-tau))+offset;

end

