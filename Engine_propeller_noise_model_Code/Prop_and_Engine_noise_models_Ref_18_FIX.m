clc;clear;close all
%For this code, let us use the data from Chapter 14 examples of Gudmundson
%The model has been taken from Ref 18 - "Elements of aviation Acoustics"

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

%ENGINE NOISE MODEL:
n = 5000;%engine rotational speed in RPM
N = 4;%number of cylinders
f_c = n/120;%cylinder firing frequency
f_e = (N*n)/120;%exhaust firing frequency
% According to Reference 61, the overall A-weighted level of the exhaust noise
% of an unmuffled piston engine at 150 m sideline can be estimated by:
P_br = 25*745.7;%engine shaft power, watts
L_A = 8 + (14*log10(P_br)); %dBA
%Using data in Gudmundson - An airplane is powered by a two-bladed propeller
%whose diameter is 76 inches is driven by a 310 BHP engine
%choosing the exhaust firing frequency as per the book:
% "The most intense noise levels, however, are found at exhaust firing 
%  frequency, ie' and its harmonics".
f = f_e;
del_L_A = -145.528 + (98.262*(log10(f))) - (19.509*((log10(f))^2)) + (0.975*((log10(f))^3));
SPL_engine = L_A - del_L_A

%Then moving on to propeller noise:
% For the prediction of far-field propeller noise, the following expres sion for the
% maximum sound pressure level can be used:
alt = 1;%altitude of flight, 1 = 1000 ft
D = 0.7112;%propeller diameter (m)
B = 2;%number of blades per propeller
n_p = 5000;%propeller rotational speed (rpm)
P_br = 25*745.7;%engine shaft power, watts
r = 50;%distance from propeller (m)
c = 340;%speed of sound(m/s)
N = 1;%number of propellers
M_t = (pi*D*n_p)/(60*c);%tip mach number
V = 50;%forward flight airspeed,m/s
M = V/a_si(alt);%forward flight mach number
M_hel = sqrt((M^2)+(M_t^2));%helical tip mach number
BPF = (B*n_p)/60;%Blade Passing Frequency
SPL_prop = 83.4 + (15.3*log10(P_br)) - (20*log10(D)) + (38.5*M_hel) + ...
          (-3*(B - 2)) + (10*log10(N)) - (20*log10(r)) 

%ADDITION OF PROPELLER AND ENGINE SPLs
%If we want to combine the sound pressure levels from two or more independent
%sound sources, we cannot simply add their decibel values arithmetically
%because they are logarithmic quantities
SPL_net = 10*log10((10^(SPL_engine/10)) + (10^SPL_prop/10));
