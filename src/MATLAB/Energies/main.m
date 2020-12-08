%% Main function of the project
% Compares the ground reactions forces measured against the computed ones.
clear
close all
clc


%% Adding all the directories
addpath(genpath('../../MATLAB'));
addpath(genpath('../../Lab_Files'));

%% Get the P values
P = plotmeasurements();

%% Computes the BSP parameters
[Body]= BSPparameters(P/100);

%% Read data from Motion capture files -> get pos and ori of each marker at each timestep and Force Data
MCfiles = ["custom.drf","custom2.drf","customL.drf","fastArm.drf","fastKick.drf","fastKickArm.drf", ...
    "jumpFeetup.drf","maxJump.drf","maxJump2.drf","mediumArm.drf","mediumArmNOSTOMP.drf", "mediumKick.drf", ...
    "mediumKickArm.drf", "medJump.drf", "quickJump.drf", "slowArm.drf", "slowKick.drf", "slowKickArm.drf"];

forcefiles = ["custom.csv","custom2.csv","customL.csv","fastArm.csv","fastKick.csv","fastKickArm.csv", ...
    "jumpFeetup.csv","maxJump.csv","maxJump2.csv","mediumArm.csv","mediumArmNOSTOMP.csv", "mediumKick.csv", ...
    "mediumKickArm.csv", "medJump.csv", "quickJump.csv", "slowArm.csv", "slowKick.csv", "slowKickArm.csv"];

i=9;

disp('Reading file');
F= readForce(forcefiles(i));
[pos,ori,time]= readDRF(MCfiles(i));

disp('Visualizating file:');
disp(MCfiles(i));
L = length(time);
% visualization(pos,MCfiles(i)); % comment this line if you get bored of my poor animation
% visualization_adapted(Body, L, pos, ori ); %% check it, to improve
disp('Type a key to continue');
pause();


%% TODO
%% Compute NE for each serial or tree structure -> get the forces on the ground

[grdf,grdm,kinEnergy,potEnergy] = computeGRFfromNE(Body, length(pos), pos, ori,time);
disp('Ground reactions computes (lie)');
disp('Type a key to continue');
steps = length(grdf);
pause();

F = -F;
% % Resampling (to fix)
% for i = 1:size(F,1)/2
%     F_reduced(i,:) = resample(F(i,:),size(grdf,2),size(F,2));
% end
% for i = size(F,1)/2+1:size(F,1)
%     F_reduced(i,:) = resample(F(i,:),size(grdm,2),size(F,2));
% end
% F = F_reduced;
%% TODO
%% Compare results
%comparing the error
ForMom_Error(MCfiles(i),steps,F, grdf, grdm);
%comparing them side by side
Force_Data_Plot(MCfiles(i), F, grdf, grdm);


% Not very similar, possible error sources:
% 1. Apparently when they did the experiment, they started recording
% the measurments from the ground plate before the measurements
% from the motion capture, so in practice, we don't know at which
% point of the recorded F data, the movement and measurments of the
% motion capture sensor started. This means that in that these
% plots are off phase!
% 2. There must be mistakes in the NE algorithm (maybe a missing force
% or moment, maybe a sign, maybe dimensions, maybe in the loops or somewhere else)
% because the plots arent in the same order!
% 3. Maybe we should apply a filter to the data to smooth the
% signals obtained (like velocities and accelerations) and also remove the outliners











