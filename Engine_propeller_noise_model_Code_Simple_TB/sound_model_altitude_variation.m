%%function [rpm, L_PP_final_2] = sound_model_altitude_variation(altitude_m, no_of_blades, prop_dia)
clc;clear;close all
%Atmospheric model
alt_m = 1000; %altitude_m;%m
%Temp in K, Sound Speed in m/s, Pressure in Pa, rho in kg/m3
[~,a_si,~,rho_si] = atmoscoesa(alt_m);

%-----------------Integral Model Code-----------------------
Delta = 112;    %radiation into a semisphere

Horizontal_dist = 0;%m

R = sqrt((alt_m.^2)+(Horizontal_dist^2));          %Distance from source of observation (m)

directivity_Factor = [-4 -3.9 -3.6 -2 -2.7 -4 1.8 4 3.5 1 -2.8 -8.2]; %1st harmonic of propeller noise

Phi = linspace(0, 165, 12);

p = polyfit(Phi,directivity_Factor,4);

directivity_factor_new = polyval(p,1:165);

variable = directivity_factor_new./10;

PHI = 10.^variable;

PHI_max = max(PHI);


%-----------------Aerodynamic Load-------------------------
%Using geom data of 27x13 APC propeller
Rho = rho_si;                %Density (kg/m^3) (INPUT)
c_1 = 0.05;               %empirical proportionality coefficient                     
c_2 = 0.05;               %empirical proportionality coefficient
z = 2;%no_of_blades;                    %No of blades (INPUT)
b_eff = 1.3317 *0.0254;      %chord of the blade in the effective cross section, m (INPUT)
d = 29*0.0254; %prop_dia *0.0254;           %propeller diameter (m) (INPUT)
t_by_c_max_airfoil = 0.12;%max t/c of the airfoil
a = (b_eff *t_by_c_max_airfoil);%maximum thickness of the blade airfoil on the effective radius, m, consider t = (t/c|max)*c
a_bar = a/b_eff;           %relative thickness of blade airfoil
c_0 = a_si;                %velocity of sound, m/s
Alpha = 0.0990;           %thrust coefficient
Beta = 0.1167;            %power factor
r_bar = 0.75*(d/2) ;     %relative radius of the propeller
M_fl = 0;                 %flight Mach number (INPUT)
V_fl = M_fl*a_si;
s_bar = 0.3;                %coefficient of the total blade area (0.3 to 0.6 for fixed pitch)
rpm = [3000, 4000, 5000, 6000, 7000]; %(INPUT)

n = rpm/60;

radius_propeller = d/2;   %in meters

Angular_velocity = 2*pi.*((n*60)/60);

V_circ = Angular_velocity.*radius_propeller;
V_total = sqrt((V_fl.^2) + (V_circ.^2));
M_circ = V_circ./344;   %Mach number of the circumferential velocity of the propeller

W_P_bar = ((c_1)*((Rho*(a^3))/(c_0^3)))*((Alpha^2) + (Beta/((2*pi*r_bar)^2))).*...
           (((M_circ.^2)/((z^3)*b_eff)).*(n.^6)*(d^8));

W_u_bar_n = ((c_2)*((Rho*(a^3))./(c_0^3)))*(1 + ((M_fl^2)./(M_circ.^2))).*...
              (1 - ((sin(2*pi*a.*M_circ*(z^-1)))/(2*pi*a.*M_circ*(z^-1)))).*...
              ((1/b_eff).*(n.^4)*(d^6)*(z)*(a_bar^2)*(s_bar^2));

W_ui_n_ubar_i = ((c_2)*((Rho*(a^3))./(c_0^3)))*(1 + ((M_fl^2)./(M_circ.^2))).*...
                 (1 + (M_fl)./(M_circ)).*...
                 (((M_circ.^2)./b_eff).*(n.^6)*(d^8)*(a_bar^2)*(s_bar^2));

W = (W_u_bar_n + W_P_bar + W_ui_n_ubar_i);

L_Phi_1 = (10.*log10(W)) + Delta - (20*log10(R)) + (10.*log10(PHI_max)); %Value taken at maximum directivity factor

First_harmonic_f = n.*z;

c3 = 1;

Sw = ((First_harmonic_f).^(-3)) .* c3;

L_Phi_2 = (10.*log10(Sw)) + Delta - (20*log10(R)) + (10.*log10(PHI_max));

L_PP_1 = 10.*log10((10.^(0.1.*L_Phi_1)) + (10.^(0.1.*L_Phi_2)));


%-----------------Broad Band------------------------------

St_max = 0.1;%0.05

K_b = 0;

l = radius_propeller;   %Length of blade element (m)

mew = 1.758e-5; %dynamic viscoscity - (Ns/m2)

Re = (Rho*V_total*l)/mew;

del = 0.37.*(l./(Re.^(1/5)));%boundary layer thickness

St = (First_harmonic_f.*del)./V_total; % Strouhall Number

SPL_broadband  = 10.*log10(((V_circ.^5).*z.*PHI_max.*((del*l)/(R.^2)).*((St/St_max).^4)).*...
                 ((((St/St_max).^1.5) + 0.5).^-4)) + K_b ;
             
L_PP_final = 10.*log10((10.^(0.1.*L_PP_1)) + (10.^(0.1.*SPL_broadband)));  

%---------------Engine-----------------

A_i = 1;              %Empirical Coefficient depending upon engine

B_j = 1;              %Empirical Coefficient depending upon engine

N_eff = 13.24;           %effective rated power (kW) (INPUT)

n_n = 7000;           %rated rpm to check code (INPUT)

n_cr = rpm;

V_H = 0.288;          %Working volume of engine in litres (INPUT)

N = 2;                 %No of cylinders (INPUT)

f_1 = (n_cr.*N)./120;  %Fundamental Frequency of Engine

f = linspace(10, 10000, length(rpm)); %Central frequency of third octace band

for  i = 1:1:length(n_cr)

   for j = 1:1:length(f)
    
        L_w_engine(i,j) = A_i + (10*log10((N_eff*n_n*(1 + (N_eff/V_H)))./((f(j)./f_1(i)) + (f_1(i)./f(j)))))...
              + (B_j.*(log10(n_cr(i)./n_n)));
          
        L_w_m(i) = max(L_w_engine(i,j));

   end

end

[L_w_max,~] = max(L_w_m);

L_w_max_w_dist = (L_w_max.*(1))-(20*(log10(R/1)));

L_PP_final_2 = 10.*log10((10.^(0.1.*L_PP_final)) + (10.^(0.1.*L_w_max_w_dist)));

% plot(rpm,L_PP_final_2)
% xlabel('RPM')
% ylabel('SPL')
% title(strcat('SPL vs RPM at "', num2str(R), '" m distance'))
%%end