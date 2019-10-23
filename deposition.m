function [DepNO2,DepH2O2,DepO3,DepHCHO,DepHNO3,DepNO,Gst] = deposition(gst,t,hour,T,lw,z,RH,PAR,f_light,LAIcum,Rsoil, Vcut, Vst,H,u_os,g_min,VPD_min, VPD_max,SWP_min, SWP_max, SWP,SGS ,EGS, gpot_a , gpot_b, gpot_c,hhti,hlti,vegtype,depscheme, Ptorr)
%depositions in units of s^-1
%parameterization of leaf boundary resistance from CAFE part 1
    u_fric = u_os*exp(-LAIcum/2); %friction velocity
    c = 1; %tunable constant
    v = 0.146; % cm2/s
    D = 106/Ptorr; %cm2/s diffusivity of NO2 in air, from Tang et al 2014
    DNO = 176/Ptorr;
    DO3 = 106/Ptorr;
    DH2O2 = 116/Ptorr;
    DHNO3 = 87/Ptorr;
    DHCHO = 137/Ptorr;
    
    
    Rb = (c*v/(D*u_fric))*sqrt(lw*u_fric/v);
    RbNO = (c*v/(DNO*u_fric))*sqrt(lw*u_fric/v);
    RbHNO3 = (c*v/(DHNO3*u_fric))*sqrt(lw*u_fric/v);
    RbH2O2 = (c*v/(DH2O2*u_fric))*sqrt(lw*u_fric/v);
    RbO3 = (c*v/(DO3*u_fric))*sqrt(lw*u_fric/v);
    RbHCHO = (c*v/(DHCHO*u_fric))*sqrt(lw*u_fric/v);
 
%****soil resistance 
    if z ==1
        Rsoil = Rsoil; %tunable parameter, from Jacob 1993
    else
        Rsoil = 0;
    end

%****cuticular resistance, from CAFE
    RcutO3 = 40;
    RcutNO2 = 1/Vcut;
    VcutNO = 0;
    RcutNO = 1/VcutNO;
    RcutH2O2 = RcutO3/(1e-5*1e14+1);
    RcutHNO3 = RcutO3/(1e-5*1e14);
    RcutHCHO = RcutO3/(1e-5*6000+1);


%parameterization of stomatal resistance 
    
    switch depscheme
        case 'assmax'
            
            Gst = (f_light*Vst);
            %gstNO = f_light*VstNO;
        case 'Wesley'
            gmax =Vst;
            %gmaxNO =VstNO;
            Temp = T-273.15;
            Gst = max(gmax *(Temp*(40-Temp)/400)/(1+(200*(PAR./4.57 + 0.1)^(-1))^2),0);
            %gstNO = gmaxNO *(Temp*(40-Temp)/400)/(1+(200*(PAR./4.57 + 0.1)^(-1))^2);
        case 'Emberson'
            gmax = Vst;
            %gmaxNO =VstNO;
            if vegtype == 'BLD'
                f_pot = gpot(SGS,EGS,time,gpot_a,gpot_b,gpot_c);
            else 
                f_pot = 1;
            end
            
            
            T_opt = (hhti+hlti)/2 -273.15; 
            T_min = hlti-273.15; Temp = T-273.15;
            f_temp = 1-(Temp -T_opt)^2/(T_opt -T_min)^2;
            
            Psat = 0.61365*exp(17.502*Temp./(240.97+Temp));
            VPD = Psat - RH*Psat./100;
            f_VPD = min(1,((1-g_min).*(VPD_min-VPD)./(VPD_min-VPD_max)+g_min));
            if f_VPD < g_min
                f_VPD = g_min;
            end 
            f_SWP = min(1,((1-g_min).*(SWP_min-SWP)./(SWP_min-SWP_max)+g_min));
            if f_SWP < g_min
                f_SWP = g_min;
            end 
            
            Gst = gmax*f_pot*max(g_min,f_temp*f_VPD*f_SWP*f_light);
            
            
            %gstNO = gmaxNO*f_pot*max(g_min,f_temp*f_VPD*f_SWP*f_light);
        case 'data BEARPEX'
            Gst = Vst;
            gmaxNO =0;%VstNO;     
            %gstNO = gmaxNO.*Gst;
    end        
    Rst = (Gst.*0.156/0.25)^(-1);
    Rm = 0;
    Rleaf = (1/(Rst+Rm) + 1/RcutNO2)^(-1);
    %RstNO = (gstNO)^(-1);
    %RleafNO = (1/RstNO + 1/RcutNO)^(-1);
    
DepNO2 = (1/(Rb + Rleaf + Rsoil))/H;
DepHNO3 = (1/(RcutHNO3+RbHNO3))/H;
DepHCHO = (1/(RcutHCHO+RbHCHO))/H;
DepO3 = (1/(RbO3 + 1/( 1/RcutO3) ))/H;
DepH2O2 = (1/(RcutH2O2+RbH2O2))/H;
DepNO = 0;%(1/(RbNO + RleafNO))/H;

    

