clc;clear;close all

% sound file reading code:
%-------------Sound read - write and Plot Code-----------------------
[x, Fs] = audioread('10 steps R.m4a.mp3');
audiowrite('Engine_propeller_powerplant_noise_converted.wav', x, Fs);
z = audioread('Engine_propeller_powerplant_noise_converted.wav');

n = length(x);            % number of samples
t = (0:(n-1))./Fs;        % Total sound

y = fft(x);
y_shift = fftshift(y);

f_sound = (0:(n-1)/2)*(Fs/n);          % frequency range
power = abs(y(n/2+1:n)).^2/n;  

% power of the DFT

ref =  1*exp(-12);           %Reference Power in Watts
spl = 10*log10(power/ref);   %Sound power level


y11=abs(spl);
y22=lowpass(y11,1e-3);

spl_max = max(spl)

s = downsample(t,2);


figure(1)
plot(s,y22)
xlabel('Time (s)')
ylabel('SPL (dB)')
title('SPL(dB) vs Time')
% ylim([0 100])

hold on

% the noise model is called by the following function:
% [SPL_engine, SPL_prop, SPL_PP] = ...
% Prop_and_Engine_noise_models_Ref_18_Func(altitude_ft, ...
% RPM, no_of_cyl, P_engine_hp, prop_dia_m, no_of_blades,...
% dist_m, no_of_props, V_forward);

% in the above functions, other than the engine and propeller RPM which
% tend to be equal a lot of the time, we see several parameters which can
% be varied, the best way to test the model with some consistency would be
% to vary a singular quantity at a time along the X axis while having the
% SPL at the Y axis and draw multiple curves on the same 2-D plot which
% will represent different RPMs.

% Default Parameters Whilst not being waried:
% lets wary the parameters in the order they fall in the function
% definition:
def_altitude_ft = 1;
def_RPM = 3000;
def_no_of_cyl = 2;
def_P_engine_hp = 23;
def_prop_dia_m = 0.7116;
def_no_of_blades = 3;
Hor_dist_m = 7.5;
def_no_of_props = 1;
def_V_forward_ms = 0;

% % RPM and horse power original models:
% vector_new = [0    0.6667    1.3333    2.0000    2.6667    3.3333    4.0000    4.6667    5.3333    6.0000];
% rpm = [5600   5600   2400   4400   4000   4160   3600   5360   5360   5360];
% Power_hp = (23/4200)*rpm;
% 
% for i = 1:1:length(rpm)
%     [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
%     Prop_and_Engine_noise_models_Ref_18_Func(def_altitude_ft, ...
%     rpm(i), def_no_of_cyl, Power_hp(i), def_prop_dia_m,...
%     def_no_of_blades, def_dist_m, def_no_of_props, def_V_forward_ms);
% end
% plot(vector_new, SPL_engine,'LineWidth',2);hold on
% plot(vector_new, SPL_prop,'LineWidth',2);hold on
% plot(vector_new, SPL_PP,'LineWidth',2);hold on



% RPM and horse power altered models:
vector_new = [0    0.72    1.117    1.903    3.03    3.979    4.5   5.016    6.582    7.0000];
rpm = [4500   4500   2400   4400   4000   4160   3600   5360   5360   5360];
Power_hp = 0.00548*rpm;

for i = 1:1:length(rpm)
    [SPL_engine(i), SPL_prop(i), SPL_PP(i)] = ...
    Prop_and_Engine_noise_models_Ref_18_Func_FINAL(def_altitude_ft, ...
    rpm(i), def_no_of_cyl, Power_hp(i), def_prop_dia_m,...
    def_no_of_blades, Hor_dist_m, def_no_of_props, def_V_forward_ms);
end
plot(vector_new, SPL_engine,'LineWidth',2);hold on
plot(vector_new, SPL_prop,'LineWidth',2);hold on
plot(vector_new, SPL_PP,'LineWidth',2);hold off
xlabel('Time (s)');ylabel('SPL(db)');
title('Model variation w Altitde');grid on
legend('Signal File','engine noise (altered)', 'propeller noise (altered)', 'power-plant noise (altered)')

