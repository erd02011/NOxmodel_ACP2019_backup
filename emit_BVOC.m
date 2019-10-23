function [eBVOC] = emit_BVOC(z,LAI, LAIcum, Eb, T, PAR, Er,nus,absncanopy)
% calculates emission rate of BVOCs, according to CAFE model
a0 = 0.001; cl0 = 1.41; ct1 = 95; ct2 = 230; Topt = 314; Tm = 303; 
R = 8.3145; 

CT = exp(ct1*(1/Topt-1/T)/R)/(1+exp(ct2*(1/Topt-Tm/(Topt*T))/R));
a = a0 + 0.00085*LAIcum;
cl = cl0*exp(-0.3*LAIcum);
CL = a*cl*PAR*Er/(sqrt(1+a^2*(PAR*Er)^2));
if z>nus && z<=absncanopy 
    Eb=Eb(2);
else 
    Eb=Eb(1);
end

eBVOC = Eb*CT*CL*LAI;
end

