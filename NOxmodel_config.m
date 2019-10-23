%% model parameters



 Vst= 0.4; %maximum stomatal conductance cm/s
Vcut=0.0;  %cuticular deposition velocity cm/s
 Rm = 0;  %mesophyllic resistance s/cm

 options = [3:3];  
  %model will run through as many laps as number of factors. Here is where you can ``set the code to loop through different vaiables. 
         if options(lap) ==1
             %move variable want to change here
           lap = lap+1;   
         elseif options(lap) ==2
              lap = lap+1;
        elseif options(lap) ==3
           
              lap = lap+1;
         elseif options(lap) ==4
          
              lap = lap+1;
        end
    
       
  experiment = 'data BEARPEX' %for user to change, does not affect model

%% what variables are changing? 
dt = 2; % timestep in seconds
days = 3; %days to run over. (1 day takes ~ 10 min to run at dt = 2)
hours = 24*days;
minutes = hours*60;
nsteps = minutes*60*(1/dt)+1;
nboxes=8;
ncanopy = 5; %number of boxes below the canopy
nus = 1; % number of boxes in the understory
absncanopy = 3; %different than ncanopy if want non moving mixed layer box above canopy
nmixed = 7; %number of boxes in mixed layer
start_t = 0; %hours after midnight;
dmixed = 3; %m/s change in mixed layer height, determines boundary layer dynamics
box0 = [2;6;10;15;18;40;60;1000].*100; % heights of each box in cm (in m for part in brackets; 


%**MUST ALWAYS SPECIFY THESE WHEN CHANGING THE NUMBER OF BOXES IN MODEL!!!**
%******if want an active mixed layer box that doesn't move add another
%ncanopy>absncanopy

a=0.075; %alpha value for alkylnitrate formation
kOH = 8.7e-11; %rate constant of VOC + OH
kNO3 = .17e-13; %rate constant of VOC + NO3
krad = 0.4; % radiation extinction coefficient
tauT = 2; %variable parameter, adjusts residence time in canopy (larger = shorter residence time)
LAIus = 1.9; %total understory leaf area index
LAIos=3.2; %total overstory leaf area index
lwos = 2; %overstory leaf width
lwus = 1; %understory leaf width
u_os = 61; %cm/s friction velocity above canopy, should be same as in deposition.m 
case_ustar = 'BPX'; %'constant' or 'BPX'. If 'BPX' u_os is computed as Gaussian function fit to BEARPEX-2009 data.  


%***** VOC emission parameters from CAFE part 1;
Eb = [2e9,1.3e11];%basal emissions of BVOCs molecules/cm2/s [us, os];
EbNO_max =3; %maximum soil emission rate, ppt m/s
EbNO_min = 1; %minimum soil emission rate, ppt m/s
tshift_no = 10; % time of maximum daily NO emissions
depscheme = 'data BEARPEX';%assmax'(assume maximum gmax reach, only depends on SR),'Wesley', 'Emberson', or 'data BEARPEX'
vegtype = 'BLE'; % 'BLE' (broad leaf), 'NLE' (needle leaf), 'BLD', or 'c4'
Rsoil = 2; %soil resistance to deposition cm/s
%% Vegetation parameters for gst calculation in Emberson scheme

    
SGS = 59;EGS = 212; gpot_a = 0.1; gpot_b = 30; gpot_c = 30;  %growing season start end, min gpot, days to reach max and min
 VPD_min = 4; VPD_max = 1.5; % thresholds of vapor pressure deficit for minimum and maximum stomatal opening
 hhti=313; hlti=278; % high and low temperature stress
SWP_min = -1.9; SWP_max = -1.0;%thresholds of soil water potential for minimum and maximum stomatal opening
g_min = 0.05; %minimum stomatal opening fraction
stlag = 0.001; %changes f_light and response of stomata to light
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 

acet_f = 0.02; % fraction of BVOC emissions that are acetaldehyde

Ba = 0.3;%fraction in NO3 + VOC reaction that retains nitrate functionality 

location.longitude=-120.662816;
location.latitude =38.910415;
location.altitude = 115;
time.year = 2012;
time.month = 7;
time.day = 5;
time.UTC = -8;
time.hour = start_t;
time.min = 0;
time.sec = 0;

maxT = 296; %maximum daily T in Kelvin, changes with altitude
minT = 288;
tshiftT = 14; %time start T rise
  maxRH = 85;  %maximum daily RH, constant w/ altitude 
   minRH = 65;
  tshiftrh = 1; %time of maximum daily RH
  
   maxSWP = -0.5;%-1.0;
  minSWP =-0.8; %-1.8;
  tshiftswp = 9; %time of maximum soil water potential

%% model species concentrations 

%consant concentrations
O2 = 5e18;
CO = 2.8e12;
CH4 = 3.9e13;


%advection concentrations. Treated as simple mixing process: dC/dt =
%-kmix*(C-Ca). 
%concentrations in ppb.

advection = 'sinusoidal'; %'constant' advection, 'Gaussian' or 'sinusoidal'

NO2adv_max = 0; %maximum advection concentration if changing
NO2adv_min = 0; %minimum advection concentration
tshift_adv = 17; % time of maximum advection of NO2

 NO_adv=0.;
 NO2_adv=0 ;
OH_adv = 0  ;
HO2_adv = 0  ;
O3_adv=50  ;
HNO3_adv=0.25  ;
H2O2_adv=0.8  ;
CH2O_adv = 1  ;
CH3O_adv = 0  ;
CH3O2_adv = 0  ;
CH3OOH_adv = 0;
CH3CHO_adv = 0.5  ;
CH3COO2_adv = 0;
%PAN_adv=0.26  ;
VOC_adv = 0.5;
RO2_adv = 0 ;
tracer_adv = 0.9;

%species not listed set to zero
%initial species concentrations in ppb within PBL. species not listed set to zero
NO_0= 0.02;
NO2_0 =0.2;
O3_0 = 40;
OH_0 = 1E-4;
HO2_0 = 0.02;
HNO3_0 = 0.25;
H2O2_0 = 0.8 ;
CH2O_0 = 0.2;
CH3CHO_0 = 0.5;
PAN_0 = 0;%0.26 ;
VOC_0 = 0.1;

