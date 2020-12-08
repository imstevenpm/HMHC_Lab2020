%% Computes alfa and beta for all the bodies
function [alfa,beta,COM,mass,ms,inertia]= NE_forward(pos,ori,time,body)

    [v, v_dot, w, w_dot] = central_difference(pos,ori,time);
    
    bodyparts=["lowertrunk","middletrunk","uppertrunk","head","","","upperarmL","upperarmR","forearmL",...
        "forearmR","handL","handR","","","thighL","thighR","shankL","shankR","footL","footR"];
    
    % Ignoring frame 5 6 13 and 14 since their velocities don't correspond
    % to a specific body
    for i=1:length(bodyparts)
        if (i ~= [5,6,13,14])
            COM(i,:)=body.(bodyparts(i)).COMpos;
            mass(i)=body.(bodyparts(i)).Mass;
            if i==2
                mass(i)=body.(bodyparts(i)).Mass+body.(bodyparts(i-1)).Mass;
            end
            ms(i,:)= mass(i) * COM(i,:);
            inertia(:,:,i)=body.(bodyparts(i)).Inertia;
        end
    end
    
    for i=1:length(bodyparts)
        if (i ~= [5,6,13,14])
            for j=1:length(pos)-5
                R= rotx(ori(i,1,j))*roty(ori(i,2,j))*rotz(ori(i,3,j));
                alfa(i,:,j)= mass(i)* v_dot(i,:,j) + cross(w_dot(i,:,j),R*ms(i,:)') + cross(w(i,:,j),(cross(w(i,:,j),R*ms(i,:)')));
                beta(i,:,j)= (R*inertia(:,:,i)*R'*w_dot(i,:,j)')'+ cross(R*ms(i,:)',v_dot(i,:,j))+cross(w(i,:,j),R*inertia(:,:,i)*R'*w(i,:,j)');
            end
        end
    end
end