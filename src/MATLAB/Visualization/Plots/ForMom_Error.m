function [] = ForMom_Error(filename,steps,F, grdf, grdm)
filename = erase(filename,'.drf');

%The return arguments can be removed and it can only be used to plot stuff
%% Open and import data
%create a vector of time steps
n = linspace(0,steps,steps);
%forces
dataFx = F(1,:);
dataFy = F(2,:);
dataFz = F(3,:);
%moments
dataMx = F(4,:);
dataMy = F(5,:);
dataMz = F(6,:);
%% Find the errors
for i=1:steps
Fx(i) = grdf(1,i) - dataFx(i);
Fy(i) = grdf(2,i) - dataFy(i);
Fz(i) = grdf(3,i) - dataFz(i);
Mx(i) = grdm(1,i) - dataMx(i);
My(i) = grdm(2,i) - dataMy(i);
Mz(i) = grdm(3,i) - dataMz(i);
end

%% Plot Data

% Create plots, forces and moments together
figure(1)
forces_moments_plot = tiledlayout(2,3); % Requires R2019b or later
my_title1 = strcat('Forces and Moments Error of ', ': ', filename);
nexttile
plot(n,Fx)
title('Fx Error', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('N')

nexttile
plot(n,Fy)
title('Fy Error', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('N')

nexttile
plot(n,Fz)
title('Fz Error', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('N')

nexttile
plot(n,Mx)
title('Mx Error', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('Nm')

nexttile
plot(n,My)
title('My Error', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('Nm')

nexttile
plot(n,Mz)
title('Mz Error', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('steps')
ylabel('Nm')

title(forces_moments_plot, my_title1)
%Here use your repo by copy pasting the path at the top from matlab
%fname = 'C:\Users\hp\Desktop\UNI-ECN\HMHC\Lab\HMHC_Lab2020\src\MATLAB\Figures';
%saveas(gca,fullfile(fname, filename), 'jpeg');

end

