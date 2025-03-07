%Following are the regression based models from the paper:
%   "The Development of a Flyover Noise Prediction Technique Using Multiple
%   Linear Regression Analysis"
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

%MODEL # 1 - (Single Engine Aircraft)
X_1 = 0.79;%Helical Mach 
Y_1 = 12.7506 + (75.6219*X_1);%dBA

%MODEL # 2 - (Twin Engine Aircraft)
X_2 = 0.78;%Helical Mach
Y_2 = 25.99 + (65.0586*X_2);%dBA

%MODEL # 3 - (Single and Twin Engine)
X_3_1 = 0.78;%Helical Mach
X_3_2 = 0;% 0 for single and 1 for double prop
Y_3 = 13.2314 + (75.0445*X_3_1) + (4.3295*X_3_2);%dBA

%MODEL # 4 - (Single Engine Aircraft)
X_4 = 0.78;%Helical Mach
Y_4 = 86.7697 + (137.8972*X_4);%dBA

%MODEL # 5 - (Single Engine Aircraft)
X_5 = 0.78;%Helical Mach
Y_5 = 60.8837 + (0.00481*X_5);%dBA

%MODEL # 6 - ILLEGIBLE
  
%MODEL # 8 - (Single Engine Aircraft)
X_8_1 = 250;%BHP
X_8_2 = 0.78;%Helical Mach
X_8_3 = 0;%0 for 2 blade, 1 for 3 blade
X_8_4 = 0;%0 for non-turbo, 1 for turbo
Y_8 = 30.5646 + (0.00942*X_8_1) + (49.9636*X_8_2) + (2.4494*X_8_3) + (0.4552*X_8_4);

%MODEL # 9 - (Twin Engine Aircraft)
X_9_1 = 250;%BHP
X_9_2 = 0.78;%Helical Mach
Y_9 = 5.2566 + (0.01428*X_9_1) + (84.2969*X_9_2);

%MODEL # 10 - 
X_10_1 = 250;%BHP
X_10_2 = 0.78;%Helical Mach
X_10_3 = 0;%0 for 2 blade, 1 for 3 blade
X_10_4 = 0;%0 for non-turbo, 1 for turbo
X_10_5 = 0;%0 for single engine, 1 for twin engine
Y_10 = 28.8194 + (0.00678*X_10_1) + (52.6543*X_10_2) + (2.8333*X_10_3)...
       + (0.2603*X_10_4) + (2.5742*X_10_5); 
   
%MODEL # 7 - (Sing and Twin Engine Aircraft)
X_7_1 = 250;%BHP
X_7_2 = 0.78;%Helical Mach
X_7_3 = X_7_2^2;%Helical Mach Squared
X_7_4 = 0;%0 for 2 blade, 1 for 3 blade
X_7_5 = 0;%0 for non-turbo, 1 for turbo
X_7_6 = 0;%0 for single engine, 1 for twin engine
Y_7 = 31.3920 + (0.0067*X_7_1) + (46.1576*X_7_2) + (4.2376*X_7_3) + ...
      (2.5981*X_7_4) + (0.2577*X_7_5) + (2.6106*X_7_6);
  
%COMPARISONS BETWEEN MODELS 7 & 10

%Helical Tip Mmach Variance Comparison:
%Single engine (250 hp), 2 blade, non turbo
figure(1)
M_hel_Set = 0.2:0.05:0.8;
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
xlim([0.2 0.8])
   
%Shaft Horse Power Variance Comparison:
%Mach 0.78, 2 blade, non turbo
figure(2)
M_hel_Set = 0.78;
Power_Set = 100:10:500;%hp
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
   
%Setting up comparisons via models 7 and 10 w.r.t Diameter, RPM, and Speed
%Assuming configuration through all comparisons to be -> 250 hp, 2 blade, non turbo
%forward velocity of 50 ft/s if unvaried, Diameter of 6.33333 ft if unvaried
%Forward Speed:
figure(3)
alt = 1;
R = 6.3333/2; %ft
RPM = 2600;%rpm
RPM_rads = RPM*0.1047198;%rad/s
V_forward = 50:10:250;%ft/s
V_hel_2 = sqrt((V_forward.^2) + ((RPM_rads.*R).^2));
M_hel_Set_2 = V_hel_2./a(alt)
Y_7_Forward = 31.3920 + (0.0067.*250) + (46.1576.*M_hel_Set_2) + (4.2376.*(M_hel_Set_2.^2)) + ...
      (2.5981.*0) + (0.2577.*0) + (2.6106.*0);
Y_10_Forward = 28.8194 + (0.00678*250) + (52.6543*M_hel_Set_2) + (2.8333*0)...
       + (0.2603*0) + (2.5742*0);   
plot(V_forward,Y_7_Forward,'c','LineWidth',2);grid on;hold on
plot(V_forward,Y_10_Forward,'m','LineWidth',2)
legend('Model 7 (Single engine, 2 blade, non turbo)',...
       'Model 10 (Single engine, 2 blade, non turbo)')
xlabel('Shaft Power (hp)');ylabel('SPL_{max} (dBA)');title('comparison for varying Forward Speeds')

%Prop Diameter
figure(4)
R_set = (2:1:7)./2; %ft
RPM = 2600;%rpm
RPM_rads = RPM*0.1047198;%rad/s
V_forward = 50;%ft/s
V_hel_3 = sqrt((V_forward.^2) + ((RPM_rads.*R_set).^2));
M_hel_Set_3 = V_hel_3./a(alt)
Y_7_Rad = 31.3920 + (0.0067.*250) + (46.1576.*M_hel_Set_3) + (4.2376.*(M_hel_Set_3.^2)) + ...
      (2.5981.*0) + (0.2577.*0) + (2.6106.*0);
Y_10_Rad = 28.8194 + (0.00678*250) + (52.6543*M_hel_Set_3) + (2.8333*0)...
       + (0.2603*0) + (2.5742*0);   
plot(R_set,Y_7_Rad,'r','LineWidth',2);grid on;hold on
plot(R_set,Y_10_Rad,'g','LineWidth',2)
legend('Model 7 (Single engine, 2 blade, non turbo)',...
       'Model 10 (Single engine, 2 blade, non turbo)')
xlabel('Prop Radii');ylabel('SPL_{max} (dBA)');title('comparison for varying Prop Radii')

%Propeller RPM
figure(5)
R_set = 6.33333/2; %ft
RPM_set = 1000:100:2700;%rpm
RPM_rads = RPM_set.*0.1047198;%rad/s
V_forward = 50;%ft/s
V_hel_4 = sqrt((V_forward.^2) + ((RPM_rads.*R_set).^2));
M_hel_Set_4 = V_hel_4./a(alt)
Y_7_RPM = 31.3920 + (0.0067.*250) + (46.1576.*M_hel_Set_4) + (4.2376.*(M_hel_Set_4.^2)) + ...
      (2.5981.*0) + (0.2577.*0) + (2.6106.*0);
Y_10_RPM = 28.8194 + (0.00678*250) + (52.6543*M_hel_Set_4) + (2.8333*0)...
       + (0.2603*0) + (2.5742*0);   
plot(RPM_set,Y_7_RPM,'b','LineWidth',2);grid on;hold on
plot(RPM_set,Y_10_RPM,'k','LineWidth',2)
legend('Model 7 (Single engine, 2 blade, non turbo)',...
       'Model 10 (Single engine, 2 blade, non turbo)')
xlabel('RPM');ylabel('SPL_{max} (dBA)');title('comparison for varying RPMs')
   