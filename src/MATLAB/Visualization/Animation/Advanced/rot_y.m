%Establish the rotation matrix around the y-axis
function mat=rot_y(teta)
mat=[cos(teta) 0 sin(teta)
    0  1  0
    -sin(teta) 0 cos(teta)];
end