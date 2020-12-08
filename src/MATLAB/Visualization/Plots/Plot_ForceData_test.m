%% Open and import data
filename = 'medJump.csv';
data_import = readmatrix(filename);
steps = data_import(:,1)
%time
t = data_import(:, 2);
%forces
Fx = data_import(:, 3);
Fy = data_import(:, 4);
Fz = data_import(:, 5);

%moments
Mx = data_import(:, 6);
My = data_import(:, 7);
Mz = data_import(:, 8);

%CoP
CoPx = data_import(:, 9);
CoPy = data_import(:, 10);

%size
n = size(t);
%% Plot Data
% Create plots, forces and moments together
figure(1)
forces_moments_plot = tiledlayout(2,3); % Requires R2019b or later
my_title1 = strcat('Forces and Moments of ', ':', filename);
title(forces_moments_plot, my_title1 )
nexttile
plot(t,Fx)
title('Fx')
nexttile
plot(t,Fy)
title('Fy')
nexttile
plot(t,Fz)
title('Fz')
nexttile
plot(t,Mx)
title('Mx')
nexttile
plot(t,My)
title('My')
nexttile
plot(t,Mz)
title('Mz')

%CoP Position
figure(2)
my_title2 = strcat('Center of Pressure of', ':', filename);
CoP_plot = tiledlayout(1,2); % Requires R2019b or late
title(CoP_plot, my_title2 )
nexttile
plot(t,CoPx)
title('CoPx')
nexttile
plot(t,CoPy)
title('CoPy')

