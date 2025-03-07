clc;clear;close all
%The function must be called in a loop and the comparison inputs are Shaft
%power, Prop Diamter, Forward Speed, and RPMs

%RPMs = 2600 if not being varied for comparison
%V_f_ms = 50 m/s if not being varied for comparison
%D_m = 1.9 m if not being varied for comparison
%P_shp = 250 hp if not being varied for comparison
%Comparison wrt Shaft Power
figure(1)
P_shp_set = 150:10:350;%hp
for i = 1:1:length(P_shp_set)
    [SPL_max_power(i), Y_10_power(i)] = Comparison_of_models_in_ref_18_and_ref_18_rr_65...
                           (P_shp_set(i), 1.9, 2600, 50);
end
plot(P_shp_set,SPL_max_power,'r','LineWidth',2);grid on;hold on
plot(P_shp_set,Y_10_power,'g','LineWidth',2)
xlabel('shaft power (hp)'),ylabel('SPL (dBA)'),title('model comparison with varying shaft power')

%Comparison wrt RPMs
figure(2)
RPMs_set = 1000:100:3000;
for i = 1:1:length(RPMs_set)
    [SPL_max_RPMs(i), Y_10_RPMs(i)] = Comparison_of_models_in_ref_18_and_ref_18_rr_65...
                           (250, 1.9, RPMs_set(i), 50);
end
plot(RPMs_set,SPL_max_RPMs,'b','LineWidth',2);grid on;hold on
plot(RPMs_set,Y_10_RPMs,'k','LineWidth',2)
xlabel('Propeller RPMs'),ylabel('SPL (dBA)'),title('model comparison with varying RPMs')

%Comparison wrt Diameter
figure(3)
Diameter_set = 0.7:0.1:2.0;
for i = 1:1:length(Diameter_set)
    [SPL_max_Dia(i), Y_10_Dia(i)] = Comparison_of_models_in_ref_18_and_ref_18_rr_65...
                           (250, Diameter_set(i), 2600, 50);
end
plot(Diameter_set,SPL_max_Dia,'c','LineWidth',2);grid on;hold on
plot(Diameter_set,Y_10_Dia,'m','LineWidth',2)
xlabel('Propeller RPMs'),ylabel('SPL (dBA)'),title('model comparison with varying Prop Diameters')

%Comparison wrt Diameter
figure(4)
V_f_set = 30:10:100;
for i = 1:1:length(V_f_set)
    [SPL_max_V_f(i), Y_10_V_f(i)] = Comparison_of_models_in_ref_18_and_ref_18_rr_65...
                           (250, 1.9, 2600, V_f_set(i));
end
plot(V_f_set,SPL_max_V_f,'r','LineWidth',2);grid on;hold on
plot(V_f_set,Y_10_V_f,'g','LineWidth',2)
xlabel('Forward Speed (m/s)'),ylabel('SPL (dBA)'),title('model comparison with varying forward speed')
