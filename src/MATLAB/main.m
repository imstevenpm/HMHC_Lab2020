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
    
    for i=4:length(MCfiles)
        
        %% Reading the files
        disp('Reading file');
        F= readForce(forcefiles(i));
        [pos,ori,time]= readDRF(MCfiles(i));
        
        %% Compute NE for each serial or tree structure -> get the forces on the ground
        [alfa,beta,COM,mass]= NE_forward(pos,ori,time,Body);
        [grdf,grdm]= NE_backward(pos,ori,alfa,beta,COM,mass);
        disp('Ground reactions computed');
        
        %% Aligning plots -> For better visualization
        [F,grdf,grdm,pos,ori,time]=align_plots(F,grdf,grdm,pos,ori,time);
        
        %% Compute energies
        [kinEnergies,potEnergies] = energyAllBodies(Body, pos, ori,time);
        
        %% Visualization
        disp('Visualizating file:');
        disp(MCfiles(i));
        %visualization(pos,MCfiles(i)); % A simpler but faster animation
        visualization_adapted(Body, time, pos, ori); % A complex but
        %slower animation
        
        %% Compare results
        %comparing the error
        %ForMom_Error(MCfiles(i),steps,F, grdf, grdm);
        
        %comparing them side by side
        disp('Plotting results:');
        Force_Data_Plot(MCfiles(i), F, grdf, grdm);
        
        %Plot energies
        Tot_Energy_Plot(MCfiles(i), kinEnergies, potEnergies);
        disp('Type a key to continue to next motion');
        pause();
        
    end

end



