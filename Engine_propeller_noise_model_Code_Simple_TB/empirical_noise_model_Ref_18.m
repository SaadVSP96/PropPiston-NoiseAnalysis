clc;clear;close all
%For this code, let us use the data from Chapter 14 examples of Gudmundson
%The model has been taken from Ref 18 - "Elements of aviation Acoustics"
%Starting with the piston engine noise:
n = 2600;%engine rotational speed in RPM
N = 4;%number of cylinders
f_c = n/120;%cylinder firing frequency
f_e = (N*n)/120;%exhaust firing frequency
% According to Reference 61, the overall A-weighted level of the exhaust noise
% of an unmuffled piston engine at 150 m sideline can be estimated by:
P_br = 310*745.7;%engine shaft power, watts
L_A = 8 + (14*log10(P_br)) %dBA
%Using data in Gudmundson - An airplane is powered by a two-bladed propeller
%whose diameter is 76 inches is driven by a 310 BHP engine

%Then moving on to propeller noise:
% For the prediction of far-field propeller noise, the following expres sion for the
% maximum sound pressure level can be used:
B = 3;%number of blades per propeller
n_p = 2600;%propeller rotational speed (rpm)
D = 1.9304;%propeller diameter (m)
r = 50;%distance from propeller (m)
c = 340;%speed of sound(m/s)
M_t = (pi*D*n_p)/(60*c);%tip mach number
SPL_max = 83.4 + (15.3*log10(P_br)) - (20*log10(D)) + (38.5*M_t) + ...
          (-3*(B - 2)) + (10*log10(N)) - (20*log10(r)) 

%Sensitivity Analysis for the propeller model
%First we will vary each input parameter indvidually to check its impact on
%the sound level while keeping the other inputs constant.

%Sensitivity to Number of Blades
figure(1)
B_set = [2, 3, 4, 5, 6];
SPL_max_B = 83.4 + (15.3.*log10(P_br)) - (20.*log10(D)) + (38.5.*M_t) + ...
          (-3.*(B_set - 2)) + (10.*log10(N)) - (20.*log10(r)) 
plot(B_set,SPL_max_B,'r','LineWidth',2);grid on
xlabel('Number of blades');ylabel('SPL_{max} (dBA)');title('SPL variation with No. of Blades')

%Sensitivity to Engine Horse Power
figure(2)
P_br_set = [200:10:400].*745.7;%watts
SPL_max_P_br = 83.4 + (15.3.*log10(P_br_set)) - (20.*log10(D)) + (38.5.*M_t) + ...
          (-3.*(B - 2)) + (10.*log10(N)) - (20.*log10(r))
plot(P_br_set,SPL_max_P_br,'g','LineWidth',2);grid on
xlabel('engine shaft power (watts)');ylabel('SPL_{max} (dBA)');title('SPL variation with engine shaft power')
      
%Sensitivity to Propeller RPM i.e. tip mach
figure(3)
n_p_set = 1000:100:3000
M_t_set = (pi.*D.*n_p_set)./(60.*c);%tip mach number
SPL_max_n_p = 83.4 + (15.3.*log10(P_br)) - (20.*log10(D)) + (38.5.*M_t_set) + ...
          (-3.*(B - 2)) + (10.*log10(N)) - (20.*log10(r))
plot(n_p_set,SPL_max_n_p,'b','LineWidth',2);grid on
xlabel('Propeller RPM');ylabel('SPL_{max} (dBA)');title('SPL variation with propeller RPM')

%Sensitivity to Propeller Diameter i.e. also affects tip mach
figure(4)
D_set = 0.5:0.1:2;%propeller diameter (m)
M_t_set_2 = (pi.*D_set.*n_p)./(60.*c);%tip mach number
SPL_max_D = 83.4 + (15.3.*log10(P_br)) - (20.*log10(D_set)) + (38.5.*M_t_set_2) + ...
          (-3.*(B - 2)) + (10.*log10(N)) - (20.*log10(r))
plot(D_set,SPL_max_D,'c','LineWidth',2);grid on
xlabel('Propeller Diameter (m)');ylabel('SPL_{max} (dBA)');title('SPL variation with propeller diameter')

%Sensitivity to distance From Propeller
figure(5)
r_set = 0:10:2000;%distance from propeller (m)
SPL_max_r = 83.4 + (15.3.*log10(P_br)) - (20.*log10(D)) + (38.5.*M_t) + ...
          (-3.*(B - 2)) + (10.*log10(N)) - (20.*log10(r_set))
plot(r_set,SPL_max_r,'k','LineWidth',2);grid on
xlabel('distance from propeller (m)');ylabel('SPL_{max} (dBA)');title('SPL variation with distance from propeller')

