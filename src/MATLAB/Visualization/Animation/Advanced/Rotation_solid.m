%Made by Nicolas Testard if there is any question

function [X1,Y1,Z1]=Rotation_solid(X,Y,Z,rx,ry,rz)
X1=X; Y1=Y; Z1=Z;
R=rot_x(rx)*rot_y(ry)*rot_z(rz);

for i=1:size(X,1)
    for j=1:size(X,2)
        v=transpose(R*[X1(i,j);Y1(i,j);Z1(i,j)]);
        X1(i,j)=v(1);
        Y1(i,j)=v(2);
        Z1(i,j)=v(3);

    end
end

end