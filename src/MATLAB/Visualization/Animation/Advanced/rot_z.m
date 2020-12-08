%Establish the rotation matrix around the z-axis
function mat=rot_z(teta)
mat=[cos(teta) -sin(teta) 0
    sin(teta) cos(teta)  0
    0   0   1];
end