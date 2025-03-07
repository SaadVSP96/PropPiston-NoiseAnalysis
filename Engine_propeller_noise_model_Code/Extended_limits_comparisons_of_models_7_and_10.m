%Extended Limits test for models 7 and 10 to test impact of squared helical
%mach number term.
clc;clear variables;close all
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

%%COMPARISONS BETWEEN MODELS 7 & 10

%Helical Tip Mmach Variance Comparison:
%Single engine (250 hp), 2 blade, non turbo
figure(1)
M_hel_Set = 0.01:0.05:1.3;
Y_7_Mach_1 = 31.3920 + (0.0067.*250) + (46.1576.*M_hel_Set) + (4.2376.*(M_hel_Set.^2)) + ...
      (2.5981.*0) + (0.2577.*0) + (2.6106.*0);
Y_10_Mach_1 = 28.8194 + (0.00678*250) + (52.6543*M_hel_Set) + (2.8333*0)...
       + (0.2603*0) + (2.5742*0);   
%Twin Engine, 3 blade, turbo
Y_7_Mach_2 = 31.3920 + (0.0067.*250) + (46.1576.*M_hel_Set) + (4.2376.*(M_hel_Set.^2)) + ...
      (2.5981.*1) + (0.2577.*1) + (2.6106.*1);
Y_10_Mach_2 = 28.8194 + (0.00678*250) + (52.6543*M_hel_Set) + (2.8333*1)...
       + (0.2603*1) + (2.5742*1); 
plot(M_hel_Set,Y_7_Mach_1,'r','LineWidth',2);grid on;hold on
plot(M_hel_Set,Y_10_Mach_1,'g','LineWidth',2)
plot(M_hel_Set,Y_7_Mach_2,'b','LineWidth',2);
plot(M_hel_Set,Y_10_Mach_2,'k','LineWidth',2)
xlabel('Helical Tip Mach');ylabel('SPL_{max} (dBA)');title('comparison for varying mach numbers')
legend('Model 7 (Single engine, 2 blade, non turbo)', 'Model 10 (Single engine, 2 blade, non turbo)',...
       'Model 7 (Twin Engine, 3 blade, turbo)', 'Model 10 (Twin Engine, 3 blade, turbo)','Location','NorthWest')
   
%Shaft Horse Power Variance Comparison:
%Mach 0.78, 2 blade, non turbo
figure(2)
M_hel_Set = 0.78;
Power_Set = 10:10:1000;%hp
Y_7_Power_1 = 31.3920 + (0.0067.*Power_Set) + (46.1576.*M_hel_Set) + (4.2376.*(M_hel_Set.^2)) + ...
      (2.5981.*0) + (0.2577.*0) + (2.6106.*0);
Y_10_Power_1 = 28.8194 + (0.00678.*Power_Set) + (52.6543.*M_hel_Set) + (2.8333.*0)...
       + (0.2603.*0) + (2.5742.*0);   
%Twin Engine, 3 blade, turbo
Y_7_Power_2 = 31.3920 + (0.0067.*Power_Set) + (46.1576.*M_hel_Set) + (4.2376.*(M_hel_Set.^2)) + ...
      (2.5981.*1) + (0.2577.*1) + (2.6106.*1);
Y_10_Power_2 = 28.8194 + (0.00678*Power_Set) + (52.6543*M_hel_Set) + (2.8333*1)...
       + (0.2603*1) + (2.5742*1); 
plot(Power_Set,Y_7_Power_1,'r','LineWidth',2);grid on;hold on
plot(Power_Set,Y_10_Power_1,'g','LineWidth',2)
plot(Power_Set,Y_7_Power_2,'b','LineWidth',2);
plot(Power_Set,Y_10_Power_2,'k','LineWidth',2)
xlabel('Shaft Power (hp)');ylabel('SPL_{max} (dBA)');title('comparison for varying shaft powers')
legend('Model 7 (Single engine, 2 blade, non turbo)', 'Model 10 (Single engine, 2 blade, non turbo)',...
       'Model 7 (Twin Engine, 3 blade, turbo)', 'Model 10 (Twin Engine, 3 blade, turbo)','Location','NorthWest')