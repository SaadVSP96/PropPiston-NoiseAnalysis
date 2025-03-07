
function  [SPL_engine, SPL_prop, SPL_PP] = ...
          Prop_and_Engine_noise_models_Ref_18_Func_FINAL(altitude_ft, ...
          RPM, no_of_cyl, P_engine_hp, prop_dia_m, no_of_blades,...
          Hor_dist_m, no_of_props, V_forward)
%For this code, let us use the data from Chapter 14 examples of Gudmundson
%The model has been taken from Ref 18 - "Elements of aviation Acoustics"

%Defining the State Conditions at different altitudes
%specifying all of the altitudes 
alt_ft = altitude_ft;
alt_m = alt_ft * 0.3048;
Ver_dist_m = alt_m;
r = sqrt((Hor_dist_m^2)+(Ver_dist_m^2));%distance from propeller (m)
%Temp in K, Sound Speed in m/s, Pressure in Pa, rho(h) in kg/m3
[~,a_si,~,~] = atmoscoesa(alt_m);
%ENGINE NOISE MODEL:
n = RPM;%engine rotational speed in RPM
N = no_of_cyl;%number of cylinders
f_c = n/120;%cylinder firing frequency
f_e = (N*n)/120;%exhaust firing frequency
% According to Reference 61, the overall A-weighted level of the exhaust noise
% of an unmuffled piston engine at 150 m sideline can be estimated by:
P_br = P_engine_hp*745.7;%engine shaft power, watts
% SPL_engine = (-32 + (14*log10(P_br)))-(20*(log10(r))); %dBA 
SPL_engine = (-66.5 + (14*log10(P_br)))-(20*(log10(r/150))); %dBA 
%choosing the exhaust firing frequency as per the book:
% "The most intense noise levels, however, are found at exhaust firing 
%  frequency, ie' and its harmonics".
% f = f_e;
% del_L_A = -145.528 + (98.262*(log10(f))) - (19.509*((log10(f))^2)) + (0.975*((log10(f))^3));
% SPL_engine = L_A - del_L_A;

%Then moving on to propeller noise:
% For the prediction of far-field propeller noise, the following expres sion for the
% maximum sound pressure level can be used:
D = prop_dia_m;%propeller diameter (m)
B = no_of_blades;%number of blades per propeller
n_p = RPM;%propeller rotational speed (rpm)
c = a_si;%speed of sound(m/s)
N = no_of_props;%number of propellers
M_t = (pi*D*n_p)/(60*c);%tip mach number
V = V_forward;%forward flight airspeed,m/s
M = V/a_si;%forward flight mach number
M_hel = sqrt((M^2)+(M_t^2));%helical tip mach number
BPF = (B*n_p)/60;%Blade Passing Frequency
SPL_prop = -34 + (15.3*log10(P_br)) - (20*log10(D)) + (38.5*M_hel) + ...
          (-3*(B - 2)) + (10*log10(N)) - (20*log10(r));

%ADDITION OF PROPELLER AND ENGINE SPLs
%If we want to combine the sound pressure levels from two or more independent
%sound sources, we cannot simply add their decibel values arithmetically
%because they are logarithmic quantities

SPL_PP = 10.*log10((10.^(0.1.*SPL_prop)) + (10.^(0.1.*SPL_engine)));
end