function [SPL_max, Y_10] = Comparison_of_models_in_ref_18_and_ref_18_rr_65...
                           (P_shp, D_m, RPMs, V_f_ms)
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
D = D_m;%propeller diameter (m)
B = 3;%number of blades per propeller
n_p = RPMs;%propeller rotational speed (rpm)
P_br = P_shp*745.7;%engine shaft power, watts
r = 50;%distance from propeller (m)
c = a_si(1);%speed of sound(m/s)
N = 1;%number of propellers
M_t = (pi*D*n_p)/(60*c);%tip mach number
V = V_f_ms;%forward flight airspeed,m/s
M = V/a_si(alt);%forward flight mach number
M_hel = sqrt((M^2)+(M_t^2));%helical tip mach number 
SPL_max = 83.4 + (15.3*log10(P_br)) - (20*log10(D)) + (38.5*M_hel) + ...
          (-3*(B - 2)) + (10*log10(N)) - (20*log10(r));     
%Setting up comparisons via models 7 and 10 w.r.t Diameter, RPM, and Speed
%Assuming configuration through all comparisons to be -> 250 hp, 2 blade, non turbo
%forward velocity of 50 ft/s if unvaried, Diameter of 6.33333 ft if unvaried
%Last three input sequence
%0 for 2 blade, 1 for 3 blade
%0 for non-turbo, 1 for turbo
%0 for single engine, 1 for twin engine
R = (D*3.28084)/2; %ft
RPM = n_p;%rpm
RPM_rads = RPM*0.1047198;%rad/s
V_forward = V*3.28084;%ft/s
V_hel = sqrt((V_forward.^2) + ((RPM_rads.*R).^2));%ft/s
M_hel_Set = V_hel./a(alt);
Y_10 = 28.8194 + (0.00678*P_shp) + (52.6543*M_hel_Set) + (2.8333*0)...
       + (0.2603*0) + (2.5742*0);
end