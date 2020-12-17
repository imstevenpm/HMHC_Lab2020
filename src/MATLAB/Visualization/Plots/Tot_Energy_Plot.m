function Tot_Energy_Plot(filename,kinEnergies, potEnergies)

%% Plot total kinetic energy, total potential energy, total energy

kinEnergy = sum(kinEnergies,1);
potEnergy = sum(potEnergies,1);
totEnergy = kinEnergy + potEnergy;

figure

filename = erase(filename,'.drf');
forces_moments_plot = tiledlayout(2,1); % Requires R2019b or later
my_title1 = strcat('Kinetic, potential, and total energy of', ': ', filename);

nexttile
% Kin and Pot energies
plot(kinEnergy);
hold on;
plot(potEnergy);
title('Overall kinetic and potential Energies', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
legend('Kinetic Energy','Potential Energy');
xlabel('steps')
ylabel('J')

nexttile
% Total energy
plot(totEnergy);
title('Overall total energy', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('J')

%fname = 'C:\Users\Steven\Desktop\EMARO 2ND YEAR\HMHC\lab\repo2final\src\Report\Figures';
%filename=strcat(filename,'_energy');
%saveas(gca,fullfile(fname, filename), 'jpeg');

end