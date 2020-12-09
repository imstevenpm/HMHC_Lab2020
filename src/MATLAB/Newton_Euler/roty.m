function rotY = roty(angles)

rotY(1,1) = cos(angles);
rotY(1,2) = 0;
rotY(1,3) = sin(angles);
rotY(2,1) = 0;
rotY(2,2) = 1;
rotY(2,3) = 0;
rotY(3,1) = -sin(angles);
rotY(3,2) = 0;
rotY(3,3) = cos(angles);

end