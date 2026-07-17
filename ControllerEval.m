function metrics = evaluate_controller(...
    t,...
    u,w,q,theta,h,...
    delta_e,delta_t,...
    h_ref)

% Tracking Errors

h_error = h - h_ref;

% Peak Values

metrics.max_u = max(abs(u));
metrics.max_w = max(abs(w));

metrics.max_q = rad2deg(max(abs(q)));
metrics.max_theta = rad2deg(max(abs(theta)));

metrics.max_h_error = max(abs(h_error));

metrics.max_deltae = max(abs(delta_e));      
metrics.max_deltat = max(abs(delta_t));

% RMS Values

metrics.rms_u = rms(u);
metrics.rms_w = rms(w);

metrics.rms_q = rad2deg(rms(q));
metrics.rms_theta = rad2deg(rms(theta));

metrics.rms_h_error = rms(h_error);

metrics.rms_deltae = rms(delta_e);          
metrics.rms_deltat = rms(delta_t);
% Settling Time

metrics.Ts_u = settling_time(t,u,0.5);

metrics.Ts_w = settling_time(t,w,0.25);

metrics.Ts_q = settling_time(t,rad2deg(q),0.05);

metrics.Ts_theta = settling_time(t,rad2deg(theta),0.2);

metrics.Ts_h = settling_time(t,h,0.5,h_ref);

%==========================================
% Overshoot
%==========================================

metrics.peak_pitch = rad2deg(max(abs(theta)));

metrics.max_overshoot = max(h) - h_ref;

metrics.percent_overshoot = ...
    100*(max(h)-h_ref)/h_ref;

end

%% ==========================================
% Controller Evaluation
%============================================

metrics = evaluate_controller(...
    t,...
    utrue,...
    w_hat,...
    q_hat,...
    theta_hat,...
    h_true,...
    delta_e,...
    delta_t,...
    href);

T = struct2table(metrics);

disp(T)