%Now we check the impact of increasing forward speed on Helical Tip Mach
%number as well as SPL
clc;clear;close all
%establishing the forward velocity set:
V_f_ms = 50:1:70;
for i = 1:1:length(V_f_ms)
    [M_t(i),M_hel(i),SPL_max_M_tip(i),SPL_max_M_hel(i)] = ...
          Ref_18_Noise_Model_w_M_hel_corr(V_f_ms(i));    
end
%Now first we plot the mach numbers:
figure(1)
plot(V_f_ms,M_t,'r','LineWidth',2);grid on,hold on
plot(V_f_ms,M_hel,'g','LineWidth',2);
xlabel('forward velocity (m/s)');ylabel('Mach Number');
legend('Rotational Tip Mach','Helical Tip Mach');
title('Changes in Mach')

figure(2)
plot(V_f_ms,SPL_max_M_tip,'r','LineWidth',2);grid on;hold on
plot(V_f_ms,SPL_max_M_hel,'g','LineWidth',2);
xlabel('forward velocity (m/s)');ylabel('SPL (dB)');
legend('With Rotational Tip Mach','With Helical Tip Mach');
title('Changes in Propeller SPL')