%handels changes in concentration due to vertical transport
        
if z ==1 
    down = 1;
    up = z+1;
elseif z == nboxes
    up = z;
    down = z-1;
else
    down = z-1;    
    up = z+1;    
end

switch advection 
    case 'constant'
        NO2_adv = NO2_adv;
    case 'diurnal'
        NO2_adv = NOxadvec(timehr( start_t, t, dt),NO2adv_max,NO2adv_min,tshift_adv, T,H(z,r),advection)*mpcc;
end
kmix=8.3E-5; %first order rate constant in s-1, calculated from 0.3h-1 from CAFE 

[Vex] = VertK(tauT,nmixed,nboxes,absncanopy,LAIcum,box(:,r),box(absncanopy,1),H(:,r),RH,T,Ptorr,Psat,u_os);

dtracer_T = ((Vex(z)/H(z,r))*(tracer(up,t-1)-tracer(z,t-1)) + (Vex(down)/H(z,r))*(tracer(down,t-1)-tracer(z,t-1)))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            tracer(z,t) = (tracer(z,t-1) + dtracer_T).*H(z,r-1)./H(z,r) + tracer(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
               - tracer(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            tracer(z,t) = (tracer(z,t-1) + dtracer_T).*H(z,r-1)./H(z,r) - tracer(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
               + tracer(z,t-1).*(box(z,r)-box(z,r-1))./H(z,r) ;  
        else 
            tracer(z,t) = tracer(z,t-1) + dtracer_T;
        end

        Fluxtracer(z+1,t) = -Vex(z)*(tracer(up,t-1)-tracer(z,t-1));
        

dO3_T = ((Vex(z)/H(z,r))*(O3(up,t-1)-O3(z,t-1)) + (Vex(down)/H(z,r))*(O3(down,t-1)-O3(z,t-1))...
         - kmix*(O3(z,t-1)-O3_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            O3(z,t) = (O3(z,t-1) + dO3_T).*H(z,r-1)./H(z,r) + O3(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
               - O3(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            O3(z,t) = (O3(z,t-1) + dO3_T).*H(z,r-1)./H(z,r) - O3(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
               + O3(z,t-1).*(box(z,r)-box(z,r-1))./H(z,r) ;  
        else 
            O3(z,t) = O3(z,t-1) + dO3_T;
        end
        FluxO3(z+1,t) = -Vex(z)*(O3(up,t-1)-O3(z,t-1));
       
 if NO_adv==0 %|| z<absncanopy
     dNO_T = ((Vex(z)/H(z,r))*(NO(up,t-1)-NO(z,t-1)) + (Vex(down)/H(z,r))*(NO(down,t-1)-NO(z,t-1)))*dt;
 else
        dNO_T = ((Vex(z)/H(z,r))*(NO(up,t-1)-NO(z,t-1)) + (Vex(down)/H(z,r))*(NO(down,t-1)-NO(z,t-1))...
     - kmix*(NO(z,t-1)-NO_adv))*dt;
 end
        if z<=nmixed && z>ncanopy  && (box(z,r)-box(z,r-1))>0
            NO(z,t) = (NO(z,t-1) + dNO_T).*H(z,r-1)./H(z,r)  + NO(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                -NO(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            NO(z,t) = (NO(z,t-1) + dNO_T).*H(z,r-1)./H(z,r) - NO(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                +NO(z,t-1).*(box(z,r)-box(z,r-1))./H(z,r);
        else 
            NO(z,t) = NO(z,t-1) + dNO_T;
        end
        FluxNO(z+1,t) = -Vex(z)*(NO(up,t-1)-NO(z,t-1));
 if NO2_adv==0 %|| z<absncanopy
     dNO2_T = ((Vex(z)/H(z,r))*(NO2(up,t-1)-NO2(z,t-1)) + (Vex(down)/H(z,r))*(NO2(down,t-1)-NO2(z,t-1)))*dt;
 else
 dNO2_T = ((Vex(z)/H(z,r))*(NO2(up,t-1)-NO2(z,t-1)) + (Vex(down)/H(z,r))*(NO2(down,t-1)-NO2(z,t-1))...
     - kmix*(NO2(z,t-1)-NO2_adv))*dt;
 end
        if z<=nmixed && z>ncanopy  && (box(z,r)-box(z,r-1))>0
            NO2(z,t) = (NO2(z,t-1) + dNO2_T).*H(z,r-1)./H(z,r)  + NO2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                -NO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            NO2(z,t) = (NO2(z,t-1) + dNO2_T).*H(z,r-1)./H(z,r) - NO2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                +NO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            NO2(z,t) = NO2(z,t-1) + dNO2_T;
        end
        FluxNOx(z+1,t) = -Vex(z)*(NO(up,t-1)+NO2(up,t-1)-NO(z,t-1)-NO2(z,t-1));
            
       FluxNO2(z+1,t) = -Vex(z)*(NO2(up,t-1)-NO2(z,t-1));
        
dOH_T = ((Vex(z)/H(z,r))*(OH(up,t-1)-OH(z,t-1)) + (Vex(down)/H(z,r))*(OH(down,t-1)-OH(z,t-1))...
     - kmix*(OH(z,t-1)-OH_adv))*dt;
        if z<=nmixed && z>ncanopy  && (box(z,r)-box(z,r-1))>0
            OH(z,t) = (OH(z,r-1)+dOH_T).*H(z,r-1)./H(z,r)  + OH(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                -OH(z,r-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            OH(z,t) = (OH(z,t-1)+dOH_T).*H(z,r-1)./H(z,r) - OH(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                +OH(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            OH(z,t) = OH(z,t-1)+dOH_T;
        end
        
        
dHO2_T = ((Vex(z)/H(z,r))*(HO2(up,t-1)-HO2(z,t-1)) + (Vex(down)/H(z,r))*(HO2(down,t-1)-HO2(z,t-1))...
     - kmix*(HO2(z,t-1)-HO2_adv))*dt;
        if z<=nmixed && z>ncanopy  && (box(z,r)-box(z,r-1))>0
            HO2(z,t) = (HO2(z,t-1) + dHO2_T).*H(z,r-1)./H(z,r)  + HO2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                -HO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            HO2(z,t) = (HO2(z,t-1) + dHO2_T).*H(z,r-1)./H(z,r) - HO2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                +HO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            HO2(z,t) = HO2(z,t-1) + dHO2_T;
        end
        
dHNO3_T = ((Vex(z)/H(z,r))*(HNO3(up,t-1)-HNO3(z,t-1)) + (Vex(down)/H(z,r))*(HNO3(down,t-1)-HNO3(z,t-1))...
     - kmix*(HNO3(z,t-1)-HNO3_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            HNO3(z,t) = (HNO3(z,t-1) + dHNO3_T).*H(z,r-1)./H(z,r)  + HNO3(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - HNO3(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            HNO3(z,t) = (HNO3(z,t-1) + dHNO3_T).*H(z,r-1)./H(z,r) - HNO3(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + HNO3(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            HNO3(z,t) = HNO3(z,t-1) + dHNO3_T;
        end
    
dH2O2_T = ((Vex(z)/H(z,r))*(H2O2(up,t-1)-H2O2(z,t-1)) + (Vex(down)/H(z,r))*(H2O2(down,t-1)-H2O2(z,t-1))...
     - kmix*(H2O2(z,t-1)-H2O2_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            H2O2(z,t) = (H2O2(z,t-1) + dH2O2_T).*H(z,r-1)./H(z,r)  + H2O2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                -H2O2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            H2O2(z,t) = (H2O2(z,t-1) + dH2O2_T).*H(z,r-1)./H(z,r) - H2O2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + H2O2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            H2O2(z,t) = H2O2(z,t-1) + dH2O2_T;
        end
        
dN2O5_T = ((Vex(z)/H(z,r))*(N2O5(up,t-1)-N2O5(z,t-1)) + (Vex(down)/H(z,r))*(N2O5(down,t-1)-N2O5(z,t-1)))*dt;
        if z<=nmixed && z>ncanopy  && (box(z,r)-box(z,r-1))>0
            N2O5(z,t) = (N2O5(z,t-1) + dN2O5_T).*H(z,r-1)./H(z,r)  + N2O5(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - N2O5(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            N2O5(z,t) = (N2O5(z,t-1) + dN2O5_T).*H(z,r-1)./H(z,r) - N2O5(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + N2O5(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            N2O5(z,t) = N2O5(z,t-1) + dN2O5_T;
        end
        FluxN2O5(z+1,t) = -Vex(z)*(N2O5(up,t-1)-N2O5(z,t-1));
        
dNO3_T = ((Vex(z)/H(z,r))*(NO3(up,t-1)-NO3(z,t-1)) + (Vex(down)/H(z,r))*(NO3(down,t-1)-NO3(z,t-1)))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            NO3(z,t) = (NO3(z,t-1) + dNO3_T).*H(z,r-1)./H(z,r)  + NO3(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - NO3(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            NO3(z,t) = (NO3(z,t-1) + dNO3_T).*H(z,r-1)./H(z,r) - NO3(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + NO3(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            NO3(z,t) = NO3(z,t-1) + dNO3_T;
        end
        FluxNO3(z+1,t) = -Vex(z)*(NO3(up,t-1)-NO3(z,t-1));
        
dCH3O2_T = ((Vex(z)/H(z,r))*(CH3O2(up,t-1)-CH3O2(z,t-1)) + (Vex(down)/H(z,r))*(CH3O2(down,t-1)-CH3O2(z,t-1))...
     - kmix*(CH3O2(z,t-1)-CH3O2_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            CH3O2(z,t) = (CH3O2(z,t-1) + dCH3O2_T).*H(z,r-1)./H(z,r)  + CH3O2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - CH3O2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            CH3O2(z,t) = (CH3O2(z,t-1) + dCH3O2_T).*H(z,r-1)./H(z,r) - CH3O2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + CH3O2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            CH3O2(z,t) = CH3O2(z,t-1) + dCH3O2_T;
        end
       
dCH3OOH_T = ((Vex(z)/H(z,r))*(CH3OOH(up,t-1)-CH3OOH(z,t-1)) + (Vex(down)/H(z,r))*(CH3OOH(down,t-1)-CH3OOH(z,t-1))...
    - kmix*(CH3OOH(z,t-1)-CH3OOH_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            CH3OOH(z,t) = (CH3OOH(z,t-1) + dCH3OOH_T).*H(z,r-1)./H(z,r)  + CH3OOH(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - CH3OOH(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            CH3OOH(z,t) = (CH3OOH(z,t-1) + dCH3OOH_T).*H(z,r-1)./H(z,r) - CH3OOH(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + CH3OOH(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            CH3OOH(z,t) = CH3OOH(z,t-1) + dCH3OOH_T;
        end
         
dCH2O_T = ((Vex(z)/H(z,r))*(CH2O(up,t-1)-CH2O(z,t-1)) + (Vex(down)/H(z,r))*(CH2O(down,t-1)-CH2O(z,t-1))...
     - kmix*(CH2O(z,t-1)-CH2O_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            CH2O(z,t) = (CH2O(z,t-1) + dCH2O_T).*H(z,r-1)./H(z,r)  + CH2O(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - CH2O(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            CH2O(z,t) = (CH2O(z,t-1) + dCH2O_T).*H(z,r-1)./H(z,r) - CH2O(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + CH2O(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            CH2O(z,t) = CH2O(z,t-1) + dCH2O_T;
        end
        
dCH3CHO_T = ((Vex(z)/H(z,r))*(CH3CHO(up,t-1)-CH3CHO(z,t-1)) + (Vex(down)/H(z,r))*(CH3CHO(down,t-1)-CH3CHO(z,t-1))...
     - kmix*(CH3CHO(z,t-1)-CH3CHO_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            CH3CHO(z,t) = (CH3CHO(z,t-1) + dCH3CHO_T).*H(z,r-1)./H(z,r)  + CH3CHO(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - CH3CHO(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            CH3CHO(z,t) = (CH3CHO(z,t-1) + dCH3CHO_T).*H(z,r-1)./H(z,r) - CH3CHO(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + CH3CHO(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            CH3CHO(z,t) = CH3CHO(z,t-1) + dCH3CHO_T;
        end
        
dPAN_T = ((Vex(z)/H(z,r))*(PAN(up,t-1)-PAN(z,t-1)) + (Vex(down)/H(z,r))*(PAN(down,t-1)-PAN(z,t-1)))*dt;...
   
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            PAN(z,t) = (PAN(z,t-1) + dPAN_T).*H(z,r-1)./H(z,r)  + PAN(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - PAN(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            PAN(z,t) = (PAN(z,t-1) + dPAN_T).*H(z,r-1)./H(z,r) - PAN(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + PAN(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            PAN(z,t) = PAN(z,t-1) + dPAN_T;
        end
        FluxPAN(z+1,t) = -Vex(z)*(PAN(up,t-1)-PAN(z,t-1));
        
dCH3COO2_T = ((Vex(z)/H(z,r))*(CH3COO2(up,t-1)-CH3COO2(z,t-1)) + (Vex(down)/H(z,r))*(CH3COO2(down,t-1)-CH3COO2(z,t-1))...
    - kmix*(CH3COO2(z,t-1)-CH3COO2_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            CH3COO2(z,t) = (CH3COO2(z,t-1) + dCH3COO2_T).*H(z,r-1)./H(z,r)  + CH3COO2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - CH3COO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            CH3COO2(z,t) = (CH3COO2(z,t-1) + dCH3COO2_T).*H(z,r-1)./H(z,r) - CH3COO2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + CH3COO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            CH3COO2(z,t) = CH3COO2(z,t-1) + dCH3COO2_T;
        end
        

dVOC_T = ((Vex(z)/H(z,r))*(VOC(up,t-1)-VOC(z,t-1)) + (Vex(down)/H(z,r))*(VOC(down,t-1)-VOC(z,t-1))...
     - kmix*(VOC(z,t-1)-VOC_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            VOC(z,t) = (VOC(z,t-1) + dVOC_T).*H(z,r-1)./H(z,r)  + VOC(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - VOC(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            VOC(z,t) = (VOC(z,t-1) + dVOC_T).*H(z,r-1)./H(z,r) - VOC(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + VOC(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            VOC(z,t) = VOC(z,t-1) + dVOC_T;
        end
        
dRO2_T = ((Vex(z)/H(z,r))*(RO2(up,t-1)-RO2(z,t-1)) + (Vex(down)/H(z,r))*(RO2(down,t-1)-RO2(z,t-1))...
    - kmix*(RO2(z,t-1)-RO2_adv))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            RO2(z,t) = (RO2(z,t-1) + dRO2_T).*H(z,r-1)./H(z,r) + RO2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - RO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            RO2(z,t) = (RO2(z,t-1) + dRO2_T).*H(z,r-1)./H(z,r) - RO2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + RO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            RO2(z,t) = RO2(z,t-1) + dRO2_T;
        end
        
dRONO2_T = ((Vex(z)/H(z,r))*(RONO2(up,t-1)-RONO2(z,t-1)) + (Vex(down)/H(z,r))*(RONO2(down,t-1)-RONO2(z,t-1)))*dt;
        if z<=nmixed && z>ncanopy && (box(z,r)-box(z,r-1))>0
            RONO2(z,t) = (RONO2(z,t-1) + dRONO2_T).*H(z,r-1)./H(z,r)  + RONO2(up,t-1).*(box(z,r)-box(z,r-1))./H(z,r)...
                - RONO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        elseif z>ncanopy+1 && (box(z,r)-box(z,r-1))<0 
            RONO2(z,t) = (RONO2(z,t-1) + dRONO2_T).*H(z,r-1)./H(z,r) - RONO2(down,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r)...
                + RONO2(z,t-1).*(box(z-1,t)-box(z-1,r-1))./H(z,r);
        else 
            RONO2(z,t) = RONO2(z,t-1) + dRONO2_T;
        end

LNOx(z,t) = FluxNOx(z+1,t)./H(z,r) + 2*FluxN2O5(z+1,t)./H(z,r)+FluxNO3(z+1,t)./H(z,r)+FluxPAN(z+1,t)./H(z,r);
