function [T] = altitudeTemp(T0,z,absncanopy,hos,box)
%calculates temperature from input above canopy BEARPEX airT measurements
%at each box height in Kelvin
if z<=absncanopy
            a = 6.8;
            b = 3.5;
            %c = (T0-273.15)-(a*hos^b);
            T = a*exp(-b*box/hos)+T0;
        else 
            gamma = 1.4;
            H = 29.26; %isothermal scale height
            T = T0*(1-((gamma-1)/gamma)*box/(100*H*T0));
        end
end

