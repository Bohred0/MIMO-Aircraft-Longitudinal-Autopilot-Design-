t = out.xhat.Time;

%% Estimated States
xhat = out.xhat.Data;

u_hat     = xhat(:,1);
w_hat     = xhat(:,2);
q_hat     = xhat(:,3);
theta_hat = xhat(:,4);
h_hat     = xhat(:,5);

%% True Outputs (u,h)
y_true = out.y_true.Data;

u_true = y_true(:,1);
h_true = y_true(:,2);

%% Measured Outputs (u,h)
y_meas = out.y_noisy.Data;

u_meas = y_meas(:,1);
h_meas = y_meas(:,2);

%% Control Inputs
u_control = out.ctrleff.Data;

delta_e = rad2deg(u_control(:,1));      % Elevator (deg)
delta_t = u_control(:,2);               % Throttle

%% Estimation Errors
u_error = u_true - u_hat;
h_error = h_true - h_hat;
%% Measured vs True Outputs
figure

subplot(2,1,1)

plot(t,u_true,'LineWidth',2)
hold on
plot(t,u_meas,'.','MarkerSize',4)

xlabel('Time (s)')
ylabel('u (m/s)')
title('Forward Velocity: Measured vs True')
legend('True','Measured')
grid on


subplot(2,1,2)

plot(t,h_true,'LineWidth',2)
hold on
plot(t,h_meas,'.','MarkerSize',4)

xlabel('Time (s)')
ylabel('h (m)')
title('Altitude: Measured vs True')
legend('True','Measured')
grid on


t = out.xhat.Time;

xtrue = out.x_true.Data;
xhat  = out.xhat.Data;

names = {'u','w','q','\theta','h'};
units = {'m/s','m/s','deg/s','deg','m'};

%% True vs Estimated

figure

for k = 1:5

    subplot(3,2,k)

    if k==3 || k==4
        plot(t,rad2deg(xtrue(:,k)),'LineWidth',2)
        hold on
        plot(t,rad2deg(xhat(:,k)),'--','LineWidth',2)
    else
        plot(t,xtrue(:,k),'LineWidth',2)
        hold on
        plot(t,xhat(:,k),'--','LineWidth',2)
    end

    grid on
    title([names{k} ' : True vs Estimated'])
    xlabel('Time (s)')
    ylabel(units{k})
    legend('True','Estimated','Location','best')

end

sgtitle('Kalman Filter State Estimation')


%% Estimation Errors

figure

for k = 1:5

    subplot(3,2,k)

    if k==3 || k==4
        err = rad2deg(xtrue(:,k)-xhat(:,k));
    else
        err = xtrue(:,k)-xhat(:,k);
    end

    plot(t,err,'LineWidth',2)

    grid on
    title([names{k} ' Estimation Error'])
    xlabel('Time (s)')
    ylabel(units{k})

end

sgtitle('Kalman Filter Estimation Errors')
%% Estimated Unmeasured States

figure

subplot(2,2,1)
plot(t,w_hat,'LineWidth',2)
xlabel('Time (s)')
ylabel('w (m/s)')
title('Estimated Vertical Velocity')
grid on

subplot(2,2,2)
plot(t,rad2deg(q_hat),'LineWidth',2)
xlabel('Time (s)')
ylabel('q (deg/s)')
title('Estimated Pitch Rate')
grid on

subplot(2,2,3)
plot(t,rad2deg(theta_hat),'LineWidth',2)
xlabel('Time (s)')
ylabel('\theta (deg)')
title('Estimated Pitch Angle')
grid on

%% Control Effort

figure

subplot(2,1,1)

plot(t,delta_e,'LineWidth',2)

xlabel('Time (s)')
ylabel('\delta_e (deg)')
title('Elevator Command')
grid on


subplot(2,1,2)

plot(t,delta_t,'LineWidth',2)

xlabel('Time (s)')
ylabel('\delta_t')
title('Throttle Command')
grid on

%%RMSE
rmse = zeros(5,1);

for k = 1:5
    if k==3 || k==4
        err = rad2deg(xtrue(:,k)-xhat(:,k));
    else
        err = xtrue(:,k)-xhat(:,k);
    end

    rmse(k) = sqrt(mean(err.^2));
end

disp(table( ...
    {'u';'w';'q';'theta';'h'}, ...
    rmse, ...
    'VariableNames',{'State','RMSE'}))

max(abs(delta_e))