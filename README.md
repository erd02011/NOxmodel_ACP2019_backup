# NOxmodel_ACP2019
Published Discussion paper can be found here: https://doi.org/10.5194/acp-2019-538 


Notes on NOxmultibox_forestmodel:
The code is written for MATLAB. It should be run and initiated by running the script NOxmultibox_forestmodel. The following describes the script and functions included. Further documentation can be found at the beginning of each script or function. 


These below files should be modified by the user prior to running NOxmultibox_forestmodel:
  * NOxmodel_config: contains parameters to change prior to running NOxmultibox_forestmodel
  * pathfile: contains the path for where the model is kept by the user. Specifies location of model scripts.
  * figures_Noxbox: this is left blank for the user to specify which figures the model should print.


These following files can be edited if needed, but are not necessary to change. They are necessary to run the model:
  * altitudeTemp, d_Chemistry, deposition, emit_BVOC, gpot, met_diurnal, NOxadvec, PBLdynamics, ppbconv, soil_NO, timehr, tstep,    VertK, yesno, photolysis , timesteptohr, BEARPEXgst, PPFD, Jphoto


There are also two necessary folders: 
* Rates_051816: containing functions for rate constant used in the model 
* sun_azimuth_data: containing code for solar zenith angles based on time and location, Copyright (c) 2004, Khalil Sultan


The model produces a time series of the following matrices of the form nboxes x nsteps:
* box — heights of the tops each box
* eBVOC — emission of BVOCs
* LDepNOx — loss rate of NOx to deposition
* LHNO3 — loss rate of NOx to HNO3 formation
* LRONO2 — loss rate of NOx to alkyl nitrate formation
* LPAN — loss rate of NOx to PAN formation
* concentrations of the following species in molecules/cm3/s: CH2O, CH3, CH3CHO, CH3COO2, CH3O, CH3O2, CH3O2, CH3OOH, H2O2, HO2, N2O5, NO, NO2, NO3, O3, OH, PAN, RO2, VOC, tracer
