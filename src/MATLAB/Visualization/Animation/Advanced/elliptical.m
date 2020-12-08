%Made by Nicolas Testard if there is any question

function [X,Y,Z]=elliptical(a0,b0,a1,b1,L)

n=20;
dt=2*pi/n;

X=zeros(2,n+1);
Y=zeros(2,n+1);
Z=zeros(2,n+1);

for k=0:n
    X(1,k+1)=a0*cos(k*dt);
    X(2,k+1)=a1*cos(k*dt);
    Y(1,k+1)=b0*sin(k*dt);
    Y(2,k+1)=b1*sin(k*dt);
    Z(1,k+1)=0;
    Z(2,k+1)=L;

end