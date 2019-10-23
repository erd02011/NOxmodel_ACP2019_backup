function [eNO] = soil_NO(hour,EbNO_max,EbNO_min,tshift_no,days, T,h1)
%computes diurnal basal NO emissions
A = (EbNO_max-EbNO_min)/2;
tau = tshift_no;
P = 24;
omega = 2*pi/P;
offset = (EbNO_max+EbNO_min)/2;
Eb_NO = A*cos(omega*(hour-tau))+offset;

a =EbNO_max-EbNO_min;
b =tshift_no;
c=4; 
h = mod(hour, 24);

Gauss =  (a)*exp(-(h-b)^2/(2*c^2));
%Gauss = Gauss + (a)*exp(-(h-(b+(d-1)*24))^2/(2*c^2)) ;
%      m = (b+(d-1)*24);
%      mu = log(m)+ c^2;
%      th = (4+(d-1)*24);
%      if (hour-th)>=0
%          Gauss = Gauss + a*exp(-(log(hour-th)-mu)^2/(2*c^2));
%      end

%Eb_NO = EbNO_min + Gauss;

%computes temperature corrected emission of NO. 
T1 = T-273.15;
Tsoil = 0.84*T1 + 3.6;

if Tsoil <30
    eNO = Eb_NO*Tsoil/(30*h1);
    
else 
    eNO = Eb_NO/h1;

end

