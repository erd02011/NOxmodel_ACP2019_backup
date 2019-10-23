function [Vex] = VertK(tauT,nmixed,nboxes,absncanopy, LAIcum,box,hos,H,RH,T,Ptorr,Psat,u_os)
%calculation of Vex w/K-theory for above canopy:

  for z = 1:nboxes
      if z==1
          DeltaZ = (box(z+1))/2;
      elseif z<nmixed && z>0
          DeltaZ = (box(z+1)-box(z-1))/2;
      end
    if z >= absncanopy && z<nmixed    
        vonK = 0.40; %vonKarman constant
        Vex(z) = vonK*(box(z)+box(z-1))*0.5*u_os/DeltaZ;
 %calculation of Vex below canopy from CAFE
    elseif z<=absncanopy
        u_fric = u_os*exp(-LAIcum(z)/2); %friction velocity
        sigw2 = (1.25*u_fric)^2;
        Tl = 0.3*hos/u_fric;
        rcor = (1-exp(-tauT))*(tauT-1)^(3/2)/((tauT-1+exp(-tauT)^(3/2)));
        Vex(z) = rcor*sigw2*Tl/DeltaZ;
    elseif z == nmixed 
        Vex(z) = box(z)/(7*24*3600*2); % assuming ~7 days mixing timescale with free trop
    else
        Vex(z) = 0;
    end
  end 
end

