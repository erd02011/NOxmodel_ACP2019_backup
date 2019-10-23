if yesno('close all ?', 'y') close all; end
if yesno('clear all ?', 'y') clear all; end
% NOxmultibox_forest model models the NOx, NOy, VOC, etc concentration
% above and belove a forest. 
% Edit this script for changing experiment parameters
% Calls PBLdynamics, NO2uptake, d_Transport, and d_Chemistry 
pathfile
eval(['cd ' pathstem])
lap = 1;
options = 1;
[num2str(hour(datetime)),':',num2str(minute(datetime))]
while lap <= length(options)
     
     NOxmodel_config
%% end of things to change, model initializing
%*****************************************************************************
eBVOC = zeros(nboxes,nsteps);

lw = zeros(1,nboxes);
lw(1:ncanopy)=[lwus.*ones(1,nus),lwos.*ones(1,absncanopy-nus),zeros(1,ncanopy-absncanopy)];

box = ones(nboxes,nsteps);
box(:,1) = box0;

for z=1:nboxes
   if z==1
       H(z) =box(z,1);
   else 
        H(z) =box(z,1)-box(z-1,1);
   end
end


LADFos = ones(1,nboxes);
LADFos = ones(1,nboxes);

%computes leaf area density;
for z=1:nboxes
if z>1 && z<=absncanopy
    LADFos(z) = -LAIos*( ( 1-exp(-  ((1-(box(z,1))./box(absncanopy,1))./0.6).^3.6) )./(1-exp((-1/0.6^3.6))) - ...
         ( 1-exp(-  ((1-(box(z-1,1))./box(absncanopy,1))./0.6).^3.6) )./(1-exp((-1/0.6^3.6)) ) );
elseif z==1
    LADFos(z) = -LAIos*( (1-exp(-(1-box(z,1)/box(absncanopy,1))/0.6)^3.6)/(1-exp(-1/0.6^3.6))...
        - 1  );
else 
    LADFos(z) = 0;
end
end

for z=1:nboxes
if z>1 && z<=nus
    LADFus(z) = -LAIus*( ( 1-exp(-  ((1-(box(z,1))./box(nus,1))./0.6).^3.6) )./(1-exp((-1/0.6^3.6))) - ...
         ( 1-exp(-  ((1-(box(z-1,1))./box(nus,1))./0.6).^3.6) )./(1-exp((-1/0.6^3.6)) ) );
elseif z==1
    LADFus(z) = -LAIus*( (1-exp(-(1-box(z,1)/box(nus,1))/0.6)^3.6)/(1-exp(-1/0.6^3.6))...
        - 1  );
else 
    LADFus(z) = 0;
end
end

LAI = (LADFus + LADFos); %vector of LAI for each box

for z = 1:nboxes
        LAIcum(z) = 0.5*LAI(z)+ sum(LAI )-sum(LAI(1:z)); %cumulative above box leaf area index
end

%computes boundary layer height at each timestep+3600*start_t
[box] = PBLdynamics(dt,dmixed,nboxes,ncanopy,nmixed,start_t,location,time,box(:,1),nsteps,tshiftT);





H = ones(nboxes,nsteps);
H(1,:) = box(1,1);
for z=2:nboxes
    H(z,:) = box(z,:) - box(z-1,:);
end



sun = sun_position(time, location);
zenith = nan(1,nsteps);
zenith(1) = sun.zenith;

load PPFD.mat 
     
light = zeros(1,nsteps);        

%extra row for storing background concentrations in the free troposphere
NO = zeros(nboxes,nsteps);
NO2 = zeros(nboxes,nsteps);
O3 = zeros(nboxes,nsteps);
OH = zeros(nboxes,nsteps);
HO2 = zeros(nboxes,nsteps);
HNO3 = zeros(nboxes,nsteps);
H2O2 = zeros(nboxes,nsteps);
N2O5 = zeros(nboxes,nsteps);
NO3 = zeros(nboxes,nsteps);
CH3 = zeros(nboxes,nsteps);
CH3O2 = zeros(nboxes,nsteps);
CH3OOH = zeros(nboxes,nsteps);
CH3O = zeros(nboxes,nsteps);
CH2O = zeros(nboxes,nsteps);
CH3CHO = zeros(nboxes,nsteps);
PAN = zeros(nboxes,nsteps);
CH3COO2 = zeros(nboxes,nsteps);
RO2 = zeros(nboxes,nsteps);
RONO2 = zeros(nboxes,nsteps);
tracer = zeros(nboxes,nsteps);
VOC = zeros(nboxes,nsteps);

FluxNOx = zeros(nboxes,nsteps);
LHNO3 = zeros(nboxes,nsteps);
LRONO2 = zeros(nboxes,nsteps);
LDepNOx  = zeros(nboxes,nsteps);
LNOx  = zeros(nboxes,nsteps);
LPAN  = zeros(nboxes,nsteps);
P_O3  = zeros(1,nsteps);
L_NOx = zeros(1,nsteps);


gst = zeros(1,nsteps);

[T,RH] = met_diurnal(0,maxRH,minRH,maxT,minT,tshiftrh,tshiftT);
mpcc = ppbconv(1,T); %ppb to 1/cm3 conversion term, ppbcov(P,T) where T in Kelvin and P in atm

EbNO_max = EbNO_max.*100.*mpcc./1000; %maximum soil emission rate, molecules/cm^2/s
EbNO_min = EbNO_min.*100.*mpcc./1000;

%initial species concentrations within PBL. species not listed set to zero
NO(:,1) = NO_0 * mpcc;
NO2(:,1) = NO2_0 * mpcc;
O3(:,1) = O3_0 * mpcc;
OH(:,1) = OH_0 * mpcc;
HO2(:,1) = HO2_0 * mpcc;
HNO3(:,1) = HNO3_0 * mpcc;
H2O2(:,1) = H2O2_0 * mpcc;
CH2O(:,1) = CH2O_0 * mpcc;
CH3CHO(:,1) = CH3CHO_0 * mpcc;
PAN(:,1) = PAN_0 * mpcc;
VOC(:,1) = VOC_0*mpcc;
tracer(:,1) = 0;

NO_adv=NO_adv *mpcc;
 NO2_adv=NO2_adv *mpcc;
OH_adv = OH_adv  *mpcc;
HO2_adv = HO2_adv  *mpcc;
O3_adv=O3_adv  *mpcc;
HNO3_adv=HNO3_adv  *mpcc;
H2O2_adv=H2O2_adv  *mpcc;
CH2O_adv = CH2O_adv  *mpcc;
CH3O_adv = CH3O_adv  *mpcc;
CH3O2_adv = CH3O2_adv  *mpcc;
CH3OOH_adv = CH3OOH_adv*mpcc;
CH3CHO_adv = CH3CHO_adv  *mpcc;
CH3COO2_adv = CH3COO2_adv*mpcc;
%PAN_adv=0.26  *mpcc;
VOC_adv = VOC_adv*mpcc;
RO2_adv = RO2_adv *mpcc;
tracer_adv = tracer_adv*mpcc;


Ptorr = 760; %Torr (760 torr=1 atm)
M = (6.022E23/(82.057*760))*Ptorr/T; %number density of air

%load photolysis fits from Jphoto

photofits = load('Jphoto');
Jphoto = photofits.Jphoto; 
load BEARPEXgst
%% differential equations, model runs, other scrips called
t_total = tic;
for t=2:nsteps
     t_sec = timesteptohr(start_t, t, dt);
         
     time.hour = mod(floor(t_sec/3600),24);
     time.min = floor((t_sec-time.hour*3600)/60);
     time.sec = round(t_sec - (time.min*60 + time.hour*3600));
         
     if time.hour == 0 && time.min ==0 && time.sec == 0
         time.day = time.day + 1;
     end
     
     if time.day > eomday(time.year,time.month)
        time.month = time.month + 1;
        time.day = 1;
     end   
     
     if time.month > 12
         time.month = 1;
         time.year = time.year + 1;
     end
        
     sun = sun_position(time, location);
     zenith(t) = sun.zenith;
     
     if sun.zenith < 100
        PAR = PPFD(sun.zenith);
     else 
        PAR = 0;
     end 
     
     f_light = 1-exp(-stlag*PAR);
     r=t;
     
      for z = 1:nboxes
         
          if sun.zenith <=90
              Er = exp(-krad*LAIcum(z)/cosd(sun.zenith));
          else 
              Er = exp(-krad*LAIcum(z));
          end 
   
%following computes meteorology
        P_0 = 760; %Torr (760 torr=1 atm)
        z0 = 29.26; %isothermal scale height
        [T0,RH] = met_diurnal(timehr( start_t, t, dt), maxRH,minRH,maxT,minT,tshiftrh,tshiftT) ;%calculates T in Kelvin at canopy top and RH 
        T = altitudeTemp(T0,z,absncanopy,box(absncanopy,1),box(z,r)); %Kelvin
        Ptorr = P_0*exp(-(box(z,r)/(100*z0*T0)));
        M = (6.022E23/(82.057*760))*Ptorr/T; %number density of air

        Psat = 0.61365*exp(17.502.*(T-273.15)./(240.97+(T-273.15)));
        H2O = Psat.*(RH/100)*10*10^(6)*ppbconv(1,T);
        SWP = soilpotential(timehr( start_t, t, dt),maxSWP,minSWP,tshiftswp);
        
        xxx = mod(timehr( start_t, t, dt)/24,24)-floor(mod(timehr( start_t, t, dt)/24,24));
        
        switch case_ustar
            case 'constant'
                u_os = u_os;
            case 'BPX'
                u_os = (0.48*exp(-( (xxx-0.52)/0.2)^2) + 0.1385)*100;
        end 
        
    %cmputer Vst if using data BEARPEX    
        switch depscheme 
            case 'data BEARPEX'
                x = mod(timehr( start_t, t, dt),24);
                Vst = BEARPEXgst(x);
                
        end
        
        d_Transport  %two scripts compute new time step concentrations in each box 
        d_Chemistry

  
       %returns error if species concentrations are negative
        test = [NO(z,t) , NO2(z,t) ,O3(z,t),OH(z,t) ,HO2(z,t),HNO3(z,t) ,...
        H2O2(z,t),NO3(z,t),N2O5(z,t),CH3O2(z,t),CH3OOH(z,t),...
        CH3COO2(z,t),RO2(z,t)];
       
        if any(find(test<0))
        toc(t_total)
        find(test<0)
        error('script returned negative value at timestep %d',t)
        end
                       
             
      end
      light(t) = PAR; 
     end
clearvars HNO3 RONO2
toc(t_total);
%%computes NOx lifetimes
NO2_T = sum(NO2.*H,1);
    NO_T =  sum(NO.*H,1);
    NOx_T = NO_T + NO2_T;
    NO3_T = sum(NO3.*H,1);
    PAN_T = sum(PAN.*H,1);
    N2O5_T = sum(N2O5.*H,1);
    
    NOxeff_night = (NOx_T + 2.*N2O5_T + NO3_T);
    NOxeff_day = (NOx_T + 2.*N2O5_T + NO3_T + PAN_T);
    
    tauDepNOx_day = NOxeff_day./(3600.*sum(H.*LDepNOx,1));
    tauHNO3_day = (NOxeff_day)./(3600.*sum(H.*LHNO3,1));
    tauRONO2_day = (NOxeff_day)./(3600.*sum(H.*LRONO2,1));
    tauPAN_day = (NOxeff_day)./(3600.*sum(H.*LPAN,1));
    tautot_day = 1./(1./tauDepNOx_day + 1./tauHNO3_day + 1./tauRONO2_day);
    
    tauDepNOx_night = NOxeff_night./(3600.*sum(H.*LDepNOx,1));
    tauHNO3_night = (NOxeff_night)./(3600.*sum(H.*LHNO3,1));
    tauRONO2_night = (NOxeff_night)./(3600.*sum(H.*LRONO2,1));
    tauPAN_night = (NOxeff_night)./(3600.*sum(H.*LPAN,1));
    tautot_night = 1./(1./tauDepNOx_night + 1./tauHNO3_night + 1./tauRONO2_night + 1./tauPAN_night);

    NO_can =  sum(NO(1:3,:).*H(1:3,:),1);
    NO2_can = sum(NO2(1:3,:).*H(1:3,:),1);
    NOx_can = NO_can + NO2_can;
    NO3_can = sum(NO3(1:3,:).*H(1:3,:),1);
    PAN_can = sum(PAN(1:3,:).*H(1:3,:),1);
    N2O5_can = sum(N2O5(1:3,:).*H(1:3,:),1);
    
    NOxeff_can  = (NOx_can + 2.*N2O5_can + NO3_can + PAN_can);
    
    tauDepNOx_can = NOxeff_can./(3600.*sum(H(1:3,:).*LDepNOx(1:3,:),1));

    
if strcmp(experiment,'test')
    if yesno('plot select figures? ','y'), figures_NOxbox; end
else
    figures_NOxbox
end




end 

[num2str(hour(datetime)),':',num2str(minute(datetime))]


