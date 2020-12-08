%Establish the rotation matrix around the x-axis
function mat=rot_x(teta)
mat=[1 0 0
    0  cos(teta) -sin(teta)
    0  sin(teta) cos(teta)];
end