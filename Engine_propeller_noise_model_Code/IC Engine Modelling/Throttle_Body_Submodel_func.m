function [m_dot_ai] = Throttle_Body_Submodel_func(P_man)
%NOMENCLATURE
% TDC - top dead center
% IVC - Intake valve closing
% mep - mean effective pressure
% alpha - throttle angle (degrees)
% A_E - effective throttle area (m2)
% A_f - effective area of fuel jet at exit (m2)
% C_1 - speed-density constant, velocity
% C_2 - velocity of fluid
% C_f - velocity of fuel at exit to the jet
% C_D - throttle discharge coefficient
% C_Df - fuel jet discharge coefficient
% D - diameter of throttle pipe (m)
% w_e -  engine speed (rad / sec)
% e -  fuel split parameter
% gamma - ratio of specific heat capacities
% gamma_bar - fraction of fuel injected before IVC
% J_e - inertia of engine
% K - constant
% m_dot_a - time rate of change of air mass flow
% m_dot_ai - flow rate into intake (Kg/sec)
% m_dot_ao - air flow rate into cylinder (Kg/sec)
% m_dot_fi - fuel flow rate at injector (Kg/sec)
% m_dot_fo -  fuel flow rate into cylinder (Kg/sec)
% m_dot_ff2 - fuel flow injected after IVC (Kg/sec)
% m_dot_ff3 - fuel flow injected before IVC (Kg/sec)
% m_dot_fsl - fuel flow lagged by wall wetting (Kg/sec)
% N - engine speed (revolutions per minute)
% P_f - pressure of fuel pump at fuel jet (kPa)
% P_a - ambient air pressure (kPa)
% P_man - intake manifold pressure (kPa)
% R - universal gas constant (KJ kgK )
% rho, rho_1, rho_2 - density of air(kg/m3)
% rho_a - density of air
% rho_f - density of fuel (kg/m3)
% T - torque (N.m)
% T_i - indicated torque (N.m)
% T_b - brake torque (N.m)
% T_p - Pumping torque (N.m)
% T_f - friction torque(N.m)
% tau_f - slow fuel time constant (sec)
% T_man - intake manifold temperature ( k )
% T_a - ambient air temperature ( k )
% eeta_vol - volumetric efficiency of engine
% V_d - engine displacement (m3)
% V_man - intake manifold volume ( m3 )
% P_2, P_3 - Engine cycle pressures at end of compression & combustion(kPa)
% T_2, T_3 - Engine cycle temperatures at end of compression & combustion(K)
% r - compression ratio
% C_p - specific heat capacity at constant pressure ( KJ k g.K )
% Q_in - heat input by fuel combustion

%AMBIENT / ATMOSPHERIC PROPERTIES
alt_m = 1000;
[T_a, a_a, P_a, rho_a] = atmosisa(alt_m);%K - m/s - Pa - kg/m3
P_a = P_a/1000;%ambient pressure, kPa

%THROTTLE BODY SUBMODEL
%Taking input values from the end of provided thesis
D_t = 0.03; %Diameter of throttle, m
A_i = (pi/4)*(D_t^2); %Cross sectional area of throttle plate, m^2
C_D = 0.98; %Coefficient of discharge of throttle unit less
gamma = 1.4; %Index of isentropic expansion, unit less
R = 0.2871; %Gas constant for air, KJ/kgK
alpha = 20;%Throttle angle, degrees 
% The air flow through throttle is estimated by ‘Throttle Flow’ block
% using the following equation
m_dot_ai = sqrt((2*gamma)/((gamma - 1)*R*T_a))*P_a*C_D*(1 - cosd(alpha))*A_i*...
       sqrt(((P_man/P_a)^(2/gamma)) - ((P_man/P_a)^((gamma - 1)/gamma)));

%The total flow into the manifold, mdot_ai, is the sum of the throttle flow
%idle air control flow and the flow due to any intake manifold leak.
end
