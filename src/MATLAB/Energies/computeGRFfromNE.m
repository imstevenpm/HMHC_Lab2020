function [GRF,GRM,kinEnergy,potEnergy] = computeGRFfromNE(Bodies,n, pos, ori,time)

bodyparts=["lowertrunk","middletrunk","uppertrunk","head","","","upperarmL","upperarmR","forearmL",...
        "forearmR","handL","handR","","","thighL","thighR","shankL","shankR","footL","footR"];
% Get parameters from bodies (COM, ms, inertia, mass) 
for i = 1:length(bodyparts)
    if i ~= 5 && i ~= 6 && i ~= 13 && i ~= 14
        %COM, ms and Inertia parameters
        COM(i,:) = Bodies.(bodyparts(i)).COMpos;
        ms(i,:) = Bodies.(bodyparts(i)).Mass * COM(i,:);
        inertiamat(i,:,:) = Bodies.(bodyparts(i)).Inertia;
        mass(i) = Bodies.(bodyparts(i)).Mass;
    else
        COM(i,:) = zeros(3,1);
        ms(i,:) = zeros(3,1);
        inertiamat(i,:,:) = zeros(3);
        mass(i) = 0;
    end
end
b = length(bodyparts);
% Compute linear and angular velocity and acceleration (with filtering)
[v, vd, w, wd] = central_difference(pos,ori,time);

%% Solve NE equations for the whole body
kinEnergy = zeros(1,n);
potEnergy = zeros(1,n);
%% Solve LHS of NE
% For each body j
for j = 1:b
    % For each time instant i
    for i = 1:n-5
        [alpha(j,:,i),beta(j,:,i)] = solveNE_LHS(vd(j,:,i)',wd(j,:,i)',...
            w(j,:,i)',ori(j,:,i)',ms(j,:)',squeeze(inertiamat(j,:,:)),mass(j));
        [kinEnergy(j,i),potEnergy(j,i)] = energyComputation(mass(j),v(j,:,i),w(j,:,i),squeeze(inertiamat(j,:,:)),ms(j,:),pos(j,:,i),ori(j,:,i));
    end
end
%% Solve RHS of NE: computations are carried out with a top-down approach:
%% from arms and head to the feet
% Arms and head
for part = [12,11,10,9,8,7,4]
    for i = 1:n-5
        if (part==12 || part==11)
            f_nextbody = [0,0,0];
            m_nextbody = [0,0,0];
            dist = pos(part,:,i) - pos(part-2,:,i);
        elseif (part==4)
            f_nextbody = [0,0,0];
            m_nextbody = [0,0,0];
            dist = pos(part,:,i) - pos(3,:,i);
        else
            f_nextbody = f_i(part+2,:,i);
            m_nextbody = m_i(part+2,:,i);
            dist = pos(part,:,i) - pos(part-2,:,i); 
        end
        [f_i(part,:,i),m_i(part,:,i)] = solve_NE_RHS(alpha(part,:,i),...
            beta(part,:,i),ori(part,:,i),COM(part,:),mass(part),...
            f_nextbody,m_nextbody,dist,'topbodies');
    end
end

% Upper trunk (body 3)
for i = 1:n-5
    Fhead = f_i(4,:,i);
    Fleft = f_i(7,:,i);
    Fright = f_i(8,:,i);
    F = [Fhead;Fleft;Fright];
    Mhead = m_i(4,:,i);
    Mleft = m_i(7,:,i);
    Mright = m_i(8,:,i);
    M = [Mhead;Mleft;Mright];
    distleft = pos(5,:,i) - pos(3,:,i);
    distright = pos(6,:,i) - pos(3,:,i);
    distchest = pos(3,:,i) - pos(2,:,i);
    dist = [distleft;distright;distchest];
    [f_i(3,:,i),m_i(3,:,i)] = solve_NE_RHS(alpha(3,:,i),beta(3,:,i),...
        ori(3,:,i),COM(3,:),mass(3),F,M,dist,'uppertrunk');
end

% Lower trunk (body 2)
for i = 1:n-5
    f_nextbody = f_i(3,:,i);
    m_nextbody = m_i(3,:,i);
    dist = pos(1,:,i) - pos(2,:,i); 
    [f_i(2,:,i),m_i(2,:,i)] = solve_NE_RHS(alpha(2,:,i),beta(2,:,i),...
        ori(2,:,i),COM(2,:),mass(2),f_nextbody,m_nextbody,dist,'lowertrunk');
end

% Legs and feet: forces and moments from the lower trunk are equally
% distributed to the two legs
for part = [16,15,18,17,20,19]
    for i = 1:n-5
        if(part==16 || part==15)
            f_nextbody = 0.5*f_i(2,:,i);
            m_nextbody = 0.5*m_i(2,:,i);
            dist = pos(part,:,i) - pos(part-2,:,i);
        else
            f_nextbody = f_i(part-2,:,i);
            m_nextbody = m_i(part-2,:,i);
            dist = pos(part,:,i) - pos(part-2,:,i);
        end
        [f_i(part,:,i),m_i(part,:,i)] = solve_NE_RHS(alpha(part,:,i),...
            beta(part,:,i),ori(part,:,i),COM(part,:),mass(part),...
            f_nextbody,m_nextbody,dist,'bottombodies');
    end
end

% Forces and moments are the sum of 19 and 20
GRF(1,:) = -(f_i(19,1,:) + f_i(20,1,:));
GRF(2,:) = -(f_i(19,2,:) + f_i(20,2,:));
GRF(3,:) = -(f_i(19,3,:) + f_i(20,3,:));
GRM(1,:) = -(m_i(19,1,:) + m_i(20,1,:));
GRM(2,:) = -(m_i(19,2,:) + m_i(20,2,:));
GRM(3,:) = -(m_i(19,3,:) + m_i(20,3,:));

end