function [fpot] = gpot(SGS,EGS,time,gpot_a,gpot_b,gpot_c)
%modification between 0 and 1 of gmax by species-specific phenology
%  SGS and EGS are the start and end of growing season, respectively in day of year. 
% Yd is day of year
%gpot_a is the minimum gpot
%gpot_b and gpot_c are the number of days to reach max and min gpot,
%respectively
datest = datetime(time.year,time.month,time.day);
Yd = day(datest,'dayofyear');

if SGS <= Yd && Yd <= (SGS + gpot_b)
    fpot = (1-gpot_a)*((Yd-SGS)/gpot_b)+gpot_a;
elseif Yd >= (SGS+ gpot_b)&& Yd<=(EGS-gpot_c)
    fpot = 1;
elseif Yd<=EGS && Yd>=(EGS-gpot_c)
    fpot = (1-gpot_a)*((EGS-Yd)/gpot_c)+gpot_a;
else 
    fpot=gpot_a;
end

end

