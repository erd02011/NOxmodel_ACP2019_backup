function [J] =photolysis(Jphoto,zenith)
%takes spline fits of sza photolysis data from Jphoto and calculates photolysis rates

if zenith<=100
    J.CH2O = Jphoto.jCH2Osza(zenith);
    J.H2O2 = Jphoto.jH2O2sza(zenith);
    J.HNO3 = Jphoto.jHNO3sza(zenith);
    J.NO2  = Jphoto.jNO2sza(zenith);
    J.NO3a = Jphoto.jNO3asza(zenith);
    J.NO3b = Jphoto.jNO3bsza(zenith);
    J.O3   = Jphoto.jO3sza(zenith);
else
    J.CH2O = 0;
    J.H2O2 = 0;
    J.HNO3 = 0;
    J.NO2  = 0;
    J.NO3a = 0;
    J.NO3b = 0;
    J.O3   = 0;

end

