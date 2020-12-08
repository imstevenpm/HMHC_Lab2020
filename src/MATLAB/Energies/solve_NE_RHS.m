function [f_i,m_i] = solve_NE_RHS(alpha,beta,ori,COM,mass,F,M,dist,body)

g = [0,0,-9.8];
rotMat = eulAngles2rotm(ori);

if strcmp(body,'topbodies') || strcmp(body,'bottombodies')
    f_i = alpha - (mass*g) + F;
    m_i = beta - cross((rotMat*(COM'))',mass*g) - cross(dist,F) + M;
end
if strcmp(body,'uppertrunk')
    f_i = alpha - (mass*g) + sum(F,1);
    m_i = beta - cross((rotMat*(COM'))',mass*g) + sum(M,1) + ...
        cross(dist(1,:),F(1,:)) + cross(dist(2,:),F(2,:))...
        + cross(dist(3,:),f_i);
end
if strcmp(body,'lowertrunk')
    f_i = alpha - (mass*g) + F;
    m_i = beta - cross((rotMat*(COM'))',mass*g) + cross(dist,f_i) + M;
end

end