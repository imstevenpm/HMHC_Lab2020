clear all
close all
clc

% 1-second motion
n = 100;
dt = 1/n;

% Length
l = 1;

% Mass of the body
mass = 2;

% Gravity along -y axis (global frame)
gravity = [0;-9.8;0];

% COM and ms expressed in the link frame
COM = [l;0;0];
ms = mass*COM;
inertia_mom = mass*(l^2);

% Define q
q = linspace(0,2*pi,n);

% Positions and orientations in the global frame
pos(1,:) = zeros(1,n);
pos(2,:) = zeros(1,n);
pos(3,:) = zeros(1,n);
ori(1,:) = zeros(1,n);
ori(2,:) = zeros(1,n);
ori(3,:) = q;

% Obtain velocity and orientation

v = diff(pos,1,2) / dt;
w = diff(ori,1,2) / dt;
vd = diff(v,1,2) / dt;
wd = diff(w,1,2) / dt;


% Conform all the dimensions
n = size(vd,2);
pos = pos(:,1:n);
ori = ori(:,1:n);
v = v(:,1:n);
w = w(:,1:n);


% Inertia matrix (in i-th frame)
inertia_mat = zeros(3);
inertia_mat(3,3) = inertia_mom;
alpha = zeros(3,n);
beta = zeros(3,n);

% Compute LeftHandSide of the NE equations
for i = 1:n
    [alpha(:,i),beta(:,i)] = solveNE_LHS(vd(:,i),wd(:,i),w(:,i),ori(:,i),ms,inertia_mat,mass);
end

% Compute RightHandSide of the NE equations
f_i = zeros(3,n);
m_i = zeros(3,n);
for i = 1:n
    F = [0;0;0];
    M = [0;0;0];
    dist = pos(:,i) - pos(:,i);
    [f_i(:,i),m_i(:,i)] = solveNE_balance(alpha(:,i),beta(:,i),ori(:,i),COM,mass,F,M,dist);
end

% Obtain ground reaction forces and moments
GRF(1,:) = f_i(1,:);
GRF(2,:) = f_i(2,:);
GRF(3,:) = f_i(3,:);
GRM(1,:) = m_i(1,:);
GRM(2,:) = m_i(2,:);
GRM(3,:) = m_i(3,:);

% Plot ground reaction forces and moments
figure;
subplot(2,3,1)
plot(GRF(1,:))
title('GRF - X axis', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('time')
ylabel('N')
subplot(2,3,2)
plot(GRF(2,:))
title('GRF - Y axis', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('time')
ylabel('N')
subplot(2,3,3)
plot(GRF(3,:))
title('GRF - Z axis', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('time')
ylabel('N')
subplot(2,3,4)
plot(GRM(1,:))
title('GRM - X axis', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('time')
ylabel('Nm')
subplot(2,3,5)
plot(GRM(2,:))
title('GRM - Y axis', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('time')
ylabel('Nm')
subplot(2,3,6)
plot(GRM(3,:))
title('GRM - Z axis', 'FontSize',12,'FontWeight','bold','Color','#f9a800')
xlabel('time')
ylabel('Nm')