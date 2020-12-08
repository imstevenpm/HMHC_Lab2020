function [E,U] = energyComputation(m,v,w,I,mS,t,O)

R = eul2rotm(O);
T = [R,t';zeros(1,3),1];
g = [0,0,-9.8];

inertiamat = [I(1), 0, 0; 0, I(2),0; 0, 0, I(3)];
mS = (R*(mS'))';
I = R * inertiamat * R';

E = 1/2*(m*v*(v')+w*I*w'+2*mS*(cross(v',w)'));
U = -[g,0]*T*[mS';m];

end

