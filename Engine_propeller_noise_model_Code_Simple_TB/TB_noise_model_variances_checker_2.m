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
def_no_of_cyl = 2;
def_P_engine_hp = 18;
def_prop_dia_m = 29*0.0254;%in to m
def_no_of_blades = 2;
Hor_dist_m = 1;%m
def_no_of_props = 1;
def_V_forward_ms = 0;

% altitude:
altitude_ft = 0:4000:16000;
rpm  = 500:500:7000;
for i = 1:1:length(altitude_ft)
    for j = 1:1:length(rpm)
        [SPL_engine(i,j), SPL_prop(i,j), SPL_PP(i,j)] = ...
        Prop_and_Engine_noise_models_Ref_18_Func_FINAL(altitude_ft(i), ...
        rpm(j), def_no_of_cyl, def_P_engine_hp, def_prop_dia_m,...
        def_no_of_blades, Hor_dist_m, def_no_of_props, def_V_forward_ms);
    end
    plot(rpm, SPL_PP(i,:),'LineWidth',2);hold on
end
xlabel('RPM');ylabel('SPL(db)');
title('Model variation w Altitude');grid on
legend(num2str(altitude_ft'))
