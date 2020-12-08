%% Computes the central derivate of the vector
% We get the velocity and acceleration on x,y and z of each joint for each
% timestep
function [v, vd, w, wd] = central_difference(pose,ori,time)

    %velocities, differences between positions and orientations over time
    for i=2:length(pose)-1
        v(:,:,i-1) = (pose(:,:,i+1)-pose(:,:,i-1))/(time(i+1)-time(i-1));
        w(:,:,i-1)= (ori(:,:,i+1)-ori(:,:,i-1))/(time(i+1)-time(i-1));
    end

    % Apply median filter to remove spikes, then low pass filter with fc=4
    [b,a]=butter(4,4/((1/(2*(time(i+1)-time(i-1))))/2));
    for i=1:size(v,1)
        for j=1:size(v,2)
            v(i,j,:) = medfilt1(squeeze(v(i,j,:)),11);
            w(i,j,:) = medfilt1(squeeze(w(i,j,:)),11);
            v(i,j,:)=filtfilt(b,a,squeeze(v(i,j,:)));
            w(i,j,:)=filtfilt(b,a,squeeze(w(i,j,:)));

        end
    end
    
    %accelerations, differences between velocities over time
    for i=3:length(pose)-3
        vd(:,:,i-2) = (v(:,:,i+1)-v(:,:,i-1))/(time(i+1)-time(i-1));
        wd(:,:,i-2)= (w(:,:,i+1)-w(:,:,i-1))/(time(i+1)-time(i-1));
    end
    
    % Apply median filter to remove spikes, then low pass filter with fc=4
    for i=1:size(v,1)
        for j=1:size(v,2)
            vd(i,j,:) = medfilt1(squeeze(vd(i,j,:)),11);
            wd(i,j,:) = medfilt1(squeeze(wd(i,j,:)),11);
            vd(i,j,:)=filtfilt(b,a,squeeze(vd(i,j,:)));
            wd(i,j,:)=filtfilt(b,a,squeeze(wd(i,j,:)));
        end
    end
    
end