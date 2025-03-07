clc;clear;close all
% the noise model is called by the following function:
% [SPL_engine, SPL_prop, SPL_PP] = ...
% Prop_and_Engine_noise_models_Ref_18_Func(altitude_ft, ...
% engine_rpm, no_of_cyl, P_engine_hp, prop_dia_m, no_of_blades,...
% prop_rpm, dist_m, no_of_props, V_forward);

% in the above functions, other than the engine and propeller RPM which
% tend to be equal a lot of the time, we see several parameters which can
% be varied, the best way to test the model with some consistency would be
% to vary a singular quantity at a time along the X axis while having the
% SPL at the Y axis and draw multiple curves on the same 2-D plot which
% will represent different RPMs.

% Default Parameters Whilst not being waried:
% lets wary the parameters in the order they fall in the function
% definition:
def_altitude_ft = 1000;
def_engine_rpm = 3000;
def_no_of_cyl = 2;
def_P_engine_hp = 25;
def_prop_dia_m = 0.7366;
def_no_of_blades = 2;
def_prop_rpm = def_engine_rpm;
def_dist_m = def_altitude_ft*0.3048;
def_no_of_props = 1;
def_V_forward_ms = 0;

figure(1)
% altitude:
altitude_ft = 0:1000:5000;
for i = 1:1:length(altitude_ft)
    [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
    Prop_and_Engine_noise_models_Ref_18_Func_FINAL(altitude_ft(i), ...
    def_engine_rpm, def_no_of_cyl, def_P_engine_hp, def_prop_dia_m,...
    def_no_of_blades, def_dist_m, def_no_of_props, def_V_forward_ms);
end
plot(altitude_ft, SPL_engine,'LineWidth',2);hold on
plot(altitude_ft, SPL_prop,'LineWidth',2);hold on
plot(altitude_ft, SPL_PP,'LineWidth',2);hold off
xlabel('altitude(ft)');ylabel('SPL(db)');
title('Model variation w Altitde');grid on
legend('engine noise', 'propeller noise', 'power-plant noise')

clear SPL_engine SPL_prop SPL_PP

figure(2)
% RPM:
% we are assuming that Prop and engine
% rpms are the same, i.e., there is no redrive in between.
engine_rpm  = 500:500:7000;
prop_rpm = engine_rpm;
for i = 1:1:length(engine_rpm)
    [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
    Prop_and_Engine_noise_models_Ref_18_Func_FINAL(def_altitude_ft, ...
    engine_rpm(i), def_no_of_cyl, def_P_engine_hp, def_prop_dia_m,...
    def_no_of_blades, def_dist_m, def_no_of_props, def_V_forward_ms);
end
plot(engine_rpm, SPL_engine,'LineWidth',2);hold on
plot(engine_rpm, SPL_prop,'LineWidth',2);hold on
plot(engine_rpm, SPL_PP,'LineWidth',2);hold off
xlabel('RPM');ylabel('SPL(db)');
title('Model variation w RPM');grid on
legend('engine noise', 'propeller noise', 'power-plant noise', 'Location', 'NorthWest')

clear SPL_engine SPL_prop SPL_PP

figure(3)
% Propeller Diameter
prop_dia_m  = 0.5:0.1:1.2;%m
for i = 1:1:length(prop_dia_m)
    [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
    Prop_and_Engine_noise_models_Ref_18_Func_FINAL(def_altitude_ft, ...
    def_engine_rpm, def_no_of_cyl, def_P_engine_hp, prop_dia_m(i),...
    def_no_of_blades, def_dist_m, def_no_of_props, def_V_forward_ms);
end
plot(prop_dia_m, SPL_engine,'LineWidth',2);hold on
plot(prop_dia_m, SPL_prop,'LineWidth',2);hold on
plot(prop_dia_m, SPL_PP,'LineWidth',2);hold off
xlabel('RPM');ylabel('SPL(db)');
title('Model variation w propeller diameter');grid on
legend('engine noise', 'propeller noise', 'power-plant noise', 'Location', 'East')

clear SPL_engine SPL_prop SPL_PP

figure(4)
% No of  Blades
no_of_blades  = 2:1:5;
for i = 1:1:length(no_of_blades)
    [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
    Prop_and_Engine_noise_models_Ref_18_Func_FINAL(def_altitude_ft, ...
    def_engine_rpm, def_no_of_cyl, def_P_engine_hp, def_prop_dia_m,...
    no_of_blades(i), def_dist_m, def_no_of_props, def_V_forward_ms);
end
plot(no_of_blades, SPL_engine,'LineWidth',2);hold on
plot(no_of_blades, SPL_prop,'LineWidth',2);hold on
plot(no_of_blades, SPL_PP,'LineWidth',2);hold off
xlabel('RPM');ylabel('SPL(db)');
title('Model variation w no of blades');grid on
legend('engine noise', 'propeller noise', 'power-plant noise')

clear SPL_engine SPL_prop SPL_PP

figure(5)
% Forward Velocity
V_fwd = 0:20:200;%m/s
for i = 1:1:length(V_fwd)
    [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
    Prop_and_Engine_noise_models_Ref_18_Func_FINAL(def_altitude_ft, ...
    def_engine_rpm, def_no_of_cyl, def_P_engine_hp, def_prop_dia_m,...
    def_no_of_blades, def_dist_m, def_no_of_props, V_fwd(i));
end
plot(V_fwd, SPL_engine,'LineWidth',2);hold on
plot(V_fwd, SPL_prop,'LineWidth',2);hold on
plot(V_fwd, SPL_PP,'LineWidth',2);hold off
xlabel('speed (m/s)');ylabel('SPL(db)');
title('Model variation w forward velocity');grid on
legend('engine noise', 'propeller noise', 'power-plant noise', 'Location', 'NorthWest')
