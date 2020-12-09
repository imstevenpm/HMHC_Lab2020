function rotX = rotx(angles)

rotX(1,1) = 1;
rotX(1,2) = 0;
rotX(1,3) = 0;
rotX(2,1) = 0;
rotX(2,2) = cos(angles);
rotX(2,3) = -sin(angles);
rotX(3,1) = 0;
rotX(3,2) = sin(angles);
rotX(3,3) = cos(angles);

end