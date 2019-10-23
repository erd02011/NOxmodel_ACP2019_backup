function [NO2_adv] = NOxadvec(hour,NO2adv_max,NO2adv_min,tshift_adv,days, T,h1,advection)
%computes diurnal NO2 adv
 switch advection
    case 'sinusoidal'
        A = (NO2adv_max-NO2adv_min)/2;
        tau = tshift_adv;
        P = 24;
        omega = 2*pi/P;
        offset = (NO2adv_max+NO2adv_min)/2;
        NO2_adv = A*cos(omega*(hour-tau))+offset;
    case 'Gaussian'
        a =NO2adv_max-NO2adv_min;
        b =tshift_adv;
        c=4; 
        Gauss = 0;
        for d = 1:days+1
            Gauss = Gauss + a*exp(-(hour-(b+(d-1)*24))^2/(2*c^2));
        end 
 
        NO2_adv = NO2adv_min + Gauss;
 end
end
