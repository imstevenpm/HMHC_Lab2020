%% Main function of the project
% Compares the ground reactions forces measured against the computed ones.

function []= main()
    

    %% Adding all the directories
    addpath(genpath('../MATLAB'));
    addpath(genpath('../Lab_Files'));
    
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
    
    disp('Type a key to continue')
    pause();
    
    for i=1:length(MCfiles)
        
        disp('Reading file');
        F= readForce(forcefiles(i));
        [pos,ori,time]= readDRF(MCfiles(i));
        
        %% Compute NE for each serial or tree structure -> get the forces on the ground
        [alfa,beta,COM,mass]= NE_forward(pos,ori,time,Body);
        [grdf,grdm]= NE_backward(pos,ori,alfa,beta,COM,mass);
        disp('Ground reactions computed');
        
        [F,grdf,grdm,pos,ori,time]=align_plots(F,grdf,grdm,pos,ori,time);
        
        disp('Visualizating file:');
        disp(MCfiles(i));
        %visualization(pos,MCfiles(i)); % comment this line if you get bored of my poor animation
        visualization_adapted(Body, time, pos, ori);
        
        % COMPUTE ENERGIES
        
        disp('Plotting results:');
        
        %steps = length(grdf);
        
        %% Compare results
        %comparing the error
        %ForMom_Error(MCfiles(i),steps,F, grdf, grdm);
        %comparing them side by side
        Force_Data_Plot(MCfiles(i), F, grdf, grdm);
        disp('Type a key to continue to next motion');
        pause();

        % Possible error sources:
        % 1. There must be mistakes in the NE algorithm (maybe a missing force
        % or moment, maybe a sign, maybe dimensions, maybe in the loops or somewhere else)
        % because the plots arent in the same order!
        % 2. Consider filter the final grd reactions
        
    end

end



