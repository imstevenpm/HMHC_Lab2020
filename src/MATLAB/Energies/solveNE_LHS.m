function [alpha,beta] = solveNE_LHS(vd,wd,w,ori,ms,inertia_mat,mass)

% Rotation matrix from euler angles
rot_mat = eulAngles2rotm(ori);

% ms in global frame (transposed)
ms_0 = rot_mat*ms;

% Inertia matrix in global frame
inertia_mat_0 = rot_mat * inertia_mat * rot_mat';

% Classical NE equations for sum of forces and moments (left hand-side)
alpha = (mass * vd) + cross(wd,ms_0) + cross(w,cross(w,ms_0)); 
beta =  (inertia_mat_0 * wd) + cross(ms_0,vd) + cross(w,(inertia_mat_0*w));
alpha=alpha';
beta=beta';