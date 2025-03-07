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
n = [3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000];
%engine rotational speed in RPM
P_br = [2.90823403081237,4.71289370208643,6.66892245030727,...
        8.63075913748990,10.5780729649128,12.4790119495642,...
        14.1534056166202,15.4693770819221,16.5786295976708,...
        17.4833862672995,18.1898096603516,18.6415869577105,...
        18.7728614104903].*1000;%engine shaft power, watts
N = 4;%number of cylinders - since wankels are comparable tot 4 strokes
f_c = n/120;%cylinder firing frequency
f_e = (N*n)/120;%exhaust firing frequency
% According to Reference 61, the overall A-weighted level of the exhaust noise
% of an unmuffled piston engine at 150 m sideline can be estimated by:
L_A = 8 + (14.*log10(P_br)) %dBA
%Using data in Gudmundson - An airplane is powered by a two-bladed propeller
%whose diameter is 76 inches is driven by a 310 BHP engine
%choosing the exhaust firing frequency as per the book:
% "The most intense noise levels, however, are found at exhaust firing 
%  frequency, ie' and its harmonics".
f = f_e
del_L_A = -145.528 + (98.262.*(log10(f))) - (19.509.*((log10(f)).^2)) + (0.975.*((log10(f)).^3))
SPL_engine = L_A - del_L_A
figure(1)
plot(n,SPL_engine,'r','LineWidth',2);grid on;xlabel('RPMs');ylabel('SPL_engine');
figure(2)
plot(P_br,SPL_engine,'g','LineWidth',2);grid on;xlabel('Power(Watts)');ylabel('SPL_engine');