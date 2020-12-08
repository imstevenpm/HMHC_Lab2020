%% Computes the ground reactions using the NE backward algorithm
function [grdf,grdm]= NE_backward(pos,ori,time,Body,alfa,beta,COM,mass,ms,inertia)

    bodyparts=["lowertrunk","middletrunk","uppertrunk","head","-","-","upperarmL","upperarmR","forearmL",...
        "forearmR","handL","handR","-","-","thighL","thighR","shankL","shankR","footL","footR"];
    
    g=[0,0,-9.81];
    
    
    %% Solving for rigth arm serial
    fr=[0,0,0];
    mr=[0,0,0];
    for i=12:-2:6
        for j=1:length(pos)-5
            R= rotx(ori(i,1,j))*roty(ori(i,2,j))*rotz(ori(i,3,j));
            
            if i==12
                fr(i,:,j)= alfa(i,:,j) -  mass(i)*g ;
                mr(i,:,j)= beta(i,:,j) - cross(R*COM(i,:)',mass(i)*g);
            else
                fr(i,:,j)= alfa(i,:,j) -  mass(i)*g + fr(i+2,:,j);
                mr(i,:,j)= beta(i,:,j) - cross(R*COM(i,:)',mass(i)*g)...
                    + cross((pos(i+2,:,j)-pos(i,:,j)),fr(i+2,:,j)) + mr(i+2,:,j); %minus in the cross are this the right positions and direction of force?
            end
        end
    end
    
    %% Solving for left arm
    for i=11:-2:5
        for j=1:length(pos)-5
            R= rotx(ori(i,1,j))*roty(ori(i,2,j))*rotz(ori(i,3,j));
            
            if i==11
                fr(i,:,j)= alfa(i,:,j) -  mass(i)*g ;
                mr(i,:,j)= beta(i,:,j) - cross(R*COM(i,:)',mass(i)*g);
            else
                fr(i,:,j)= alfa(i,:,j) -  mass(i)*g + fr(i+2,:,j);
                mr(i,:,j)= beta(i,:,j) - cross(R*COM(i,:)',mass(i)*g)...
                    + cross((pos(i+2,:,j)-pos(i,:,j)),fr(i+2,:,j)) + mr(i+2,:,j);
            end
        end
    end
    
    %% Solving for the head
    for j=1:length(pos)-5
        fr(4,:,j)=alfa(4,:,j) -  mass(4)*g ;
        mr(4,:,j)= beta(4,:,j) - cross(R*COM(4,:)',mass(4)*g);
    end
    
    %% Solving for the trunk
    for i=3:-1:1
        for j=1:length(pos)-5
            R= rotx(ori(i,1,j))*roty(ori(i,2,j))*rotz(ori(i,3,j));
            if i==3
                fr(i,:,j)=alfa(i,:,j)-mass(i)*g + fr(4,:,j) + fr(6,:,j) +fr(5,:,j);
                mr(i,:,j)=beta(i,:,j)- cross(R*COM(i,:)',mass(i)*g) + mr(4,:,j) + mr(5,:,j) + mr(6,:,j) ...
                    + cross((pos(6,:,j)-pos(3,:,j)),fr(6,:,j)) + cross((pos(5,:,j)-pos(3,:,j)),fr(5,:,j)) ...
                    + cross((pos(4,:,j)-pos(3,:,j)),fr(4,:,j)); % CHANGE
            elseif i==2
                fr(i,:,j)=alfa(i,:,j)-(mass(i)+mass(i-1))*g + fr(i+1,:,j);
                mr(i,:,j)=beta(i,:,j)- cross(R*COM(i,:)',(mass(i)+mass(i-1))*g)...
                    + cross((pos(i+1,:,j)-pos(i,:,j)),fr(i+1,:,j)) + mr(i+1,:,j);
            else
                fr(i,:,j)=alfa(i,:,j)-(mass(i))*g + fr(i+1,:,j);
                mr(i,:,j)=beta(i,:,j)- cross(R*COM(i,:)',(mass(i))*g)...
                    + cross((pos(i+1,:,j)-pos(i,:,j)),fr(i+1,:,j)) + mr(i+1,:,j);
            end
        end
    end
    
    %% Solving for the legs
    for i=13:20
        for j=1:length(pos)-5
            R= rotx(ori(i,1,j))*roty(ori(i,2,j))*rotz(ori(i,3,j));
            if (i==13 || i==14)
                fr(i,:,j)=fr(2,:,j)/2;
                mr(i,:,j)=mr(2,:,j)/2;
            else
                fr(i,:,j)=alfa(i,:,j)-mass(i)*g + fr(i-2,:,j);
                mr(i,:,j)=beta(i,:,j)- cross(R*COM(i,:)',mass(i)*g)...
                    + cross((pos(i-2,:,j)-pos(i,:,j)),fr(i-2,:,j)) + mr(i-2,:,j);
            end
        end
    end
    
    grdf=fr(20,:,:)+fr(19,:,:);
    grdf=reshape(grdf,[3,length(pos)-5]);
    grdm=mr(20,:,:)+mr(19,:,:);
    grdm=reshape(grdm,[3,length(pos)-5]);


end