function rotZ = rotz(angles)

rotZ(1,1) = cos(angles);
rotZ(1,2) = -sin(angles);
rotZ(1,3) = 0;
rotZ(2,1) = sin(angles);
rotZ(2,2) = cos(angles);
rotZ(2,3) = 0;
rotZ(3,1) = 0;
rotZ(3,2) = 0;
rotZ(3,3) = 1;

end