function [M_t,M_hel,SPL_max_M_tip,SPL_max_M_hel] = ...
          Ref_18_Noise_Model_w_M_hel_corr(V_f_ms)
%Defining the State Conditions at different altitudes
%specifying all of the altitudes 
alt_ft = 1000:1000:35000;
alt_m = alt_ft * 0.3048;
%Temp in K, Sound Speed in m/s, Pressure in Pa, rho(h) in kg/m3
[T_si,a_si,P_si,rho_si] = atmoscoesa(alt_m);
%converting atmospheric values to english uni`ts
T_eng = 1.8*T_si;%rankine
a = 3.28084*a_si;%ft/s
P = 0.02088547*P_si;%lb/ft^2
rho = 0.00194032*rho_si;%slugs/ft^3

%Then moving on to propeller noise:
% For the prediction of far-field propeller noise, the following expres sion for the
% maximum sound pressure level can be used:
alt = 1;%altitude of flight, 1 = 1000 ft
D = 1.9304;%propeller diameter (m)
B = 3;%number of blades per propeller
n_p = 2600;%propeller rotational speed (rpm)
P_br = 310*745.7;%engine shaft power, watts
r = 50;%distance from propeller (m)
c = 340;%speed of sound(m/s)
N = 3;%number of propellers

%Quantities of Interest
V = V_f_ms;%forward flight airspeed,m/s
M = V/a_si(alt);%forward flight mach number
M_t = (pi*D*n_p)/(60*c); %tip mach number
M_hel = sqrt((M^2)+(M_t^2)); %helical tip mach number
%First we check the SPL with only Tip Mach Number
SPL_max_M_tip = 83.4 + (15.3*log10(P_br)) - (20*log10(D)) + (38.5*M_t) + ...
          (-3*(B - 2)) + (10*log10(N)) - (20*log10(r)); 
%Then we check the SPL with Helical Mach Number
SPL_max_M_hel = 83.4 + (15.3*log10(P_br)) - (20*log10(D)) + (38.5*M_hel) + ...
          (-3*(B - 2)) + (10*log10(N)) - (20*log10(r));
end