function metrics = evaluate_controller(t,...
    u,w,q,theta,h,delta_e,delta_t)

%=========================
% Peak Values
%=========================

metrics.max_u = max(abs(u));
metrics.max_w = max(abs(w));

metrics.max_q = rad2deg(max(abs(q)));
metrics.max_theta = rad2deg(max(abs(theta)));

metrics.max_h = max(abs(h));

metrics.max_deltae = rad2deg(max(abs(delta_e)));
metrics.max_deltat = max(abs(delta_t));

%=========================
% RMS Values
%=========================

metrics.rms_u = rms(u);
metrics.rms_w = rms(w);

metrics.rms_q = rad2deg(rms(q));
metrics.rms_theta = rad2deg(rms(theta));
metrics.rms_h = rms(h);

metrics.rms_deltae = rad2deg(rms(delta_e));
metrics.rms_deltat = rms(delta_t);

%=========================
% Settling Time
%=========================
hdot=diff(h_true);
metrics.Ts_u = settling_time(t,u,0.5);

metrics.Ts_w = settling_time(t,w,0.25);

metrics.Ts_q = settling_time(t,rad2deg(q),0.05);

metrics.Ts_theta = settling_time(t,rad2deg(theta),0.2);

metrics.Ts_h = settling_time(t,hdot,0.25);
%=========================
% Overshoot
%=========================

metrics.peak_abs_deviation = rad2deg(max(abs(theta)));

end

metrics = evaluate_controller(...
    t,...
    u_true,...
    w_hat,...
    q_hat,...
    theta_hat,...
    h_true,...
    delta_e,...
    delta_t);

T = struct2table(metrics);

disp(T)

