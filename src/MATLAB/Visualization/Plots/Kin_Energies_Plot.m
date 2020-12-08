function [] = Kin_Energies_Plot(filename,Kin_Energy)
filename = erase(filename,'.drf');
steps = length(Kin_Energy);
%% Plot  Kinetic Energy
figure(3)

kin_energy_plot= tiledlayout(4,5); % Requires R2019b or later
my_title3 = strcat('Kinetic energy of', ': ', filename);

nexttile
        plot(Kin_Energy(1,:));
title('Body1', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')


nexttile
        plot(Kin_Energy(2,:));
title('Body2', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(3,:));
title('Body3', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(4,:));
title('Body4', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(5,:));
title('Body5', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(6,:));
title('Body6', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(7,:));
title('Body7', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(8,:));
title('Body8', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(9,:));
title('Body9', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(10,:));
title('Body10', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(11,:));
title('Body11', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(12,:));
title('Body12', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(13,:));
title('Body13', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(14,:));
title('Body14', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(15,:));
title('Body15', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(16,:));
title('Body16', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(17,:));
title('Body17', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(18,:));
title('Body18', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(19,:));
title('Body19', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

nexttile
        plot(Kin_Energy(20,:));
title('Body20', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')


title(kin_energy_plot, my_title3 );

%Here use your repo by copy pasting the path at the top from matlab
%fname = 'C:\Users\hp\Desktop\UNI-ECN\HMHC\Lab\HMHC_Lab2020\src\MATLAB\Figures';
%saveas(gca,fullfile(fname, filename), 'jpeg');

end

