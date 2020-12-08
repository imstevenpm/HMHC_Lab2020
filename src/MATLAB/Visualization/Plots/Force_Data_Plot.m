function [] = Force_Data_Plot(filename, F, grdf, grdm)

%% Plot Data
% Create plots, forces and moments together
figure(2)

filename = erase(filename,'.drf');
forces_moments_plot = tiledlayout(2,3); % Requires R2019b or later
my_title1 = strcat('Forces and Moments side by side of', ': ', filename);

nexttile
        % Only comparing fx
        plot(F(1,:));
        hold on;
        plot(grdf(1,:));
title('Fx', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('N')

nexttile
        plot(F(2,:));
        hold on;
        plot(grdf(2,:));
title('Fy', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('N')

nexttile
        plot(F(3,:));
        hold on;
        plot(grdf(3,:));
title('Fz', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('N')

nexttile
        plot(F(4,:));
        hold on;
        plot(grdm(1,:));
title('Mx', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('Nm')

nexttile
        plot(F(5,:));
        hold on;
        plot(grdm(2,:));
title('My', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('Nm')

nexttile
        plot(F(6,:));
        hold on;
        plot(grdm(3,:));
title('Mz', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('Nm')
title(forces_moments_plot, my_title1 );
legend('ForcePlates','GroundReactions');
%Here use your repo by copy pasting the path at the top from matlab
%fname = 'C:\Users\hp\Desktop\UNI-ECN\HMHC\Lab\HMHC_Lab2020\src\MATLAB\Figures';
%saveas(gca,fullfile(fname, filename), 'jpeg');

end

