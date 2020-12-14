clear all
close all
clc

% 1-second motion
n = 100;
dt = 1/n;

% Number of bodies
b = 2;

% Lengths
l = [1,1];

% masses of the bodies
masses = [2,2];

% Gravity along -y axis (global frame)
gravity = [0;-9.8;0];

% COM and ms expressed in i-th frame of the two bodies
COM(:,1) = [1;0;0];
COM(:,2) = [1;0;0];
ms = [masses(1)*COM(:,1), masses(2)*COM(:,2)];
inertia_mom = masses .* (l.^2);

% Define q1 and q2
q1 = linspace(0,pi,n);
q2 = linspace(-pi/2,pi/2,n);

% Positions and orientations in the global frame
pos(1,:,1) = zeros(1,n);
pos(2,:,1) = zeros(1,n);
pos(3,:,1) = zeros(1,n);
ori(1,:,1) = zeros(1,n);
ori(2,:,1) = zeros(1,n);
ori(3,:,1) = q1;

pos(1,:,2) = l(1)*cos(q1);
pos(2,:,2) = l(1)*sin(q1);
pos(3,:,2) = zeros(1,n);
ori(1,:,2) = zeros(1,n);
ori(2,:,2) = zeros(1,n);
ori(3,:,2) = q1+q2;

% Obtain velocity and orientation
v = diff(pos,1,2) / dt;
w = diff(ori,1,2) / dt;
vd = diff(v,1,2) / dt;
wd = diff(w,1,2) / dt;

% Conform all the dimensions
n = size(vd,2);
pos = pos(:,1:n,:);
ori = ori(:,1:n,:);
v = v(:,1:n,:);
w = w(:,1:n,:);


% Inertia matrix (in i-th frame)
inertia_mat(:,:,1) = zeros(3);
inertia_mat(3,3,1) = inertia_mom(1);
inertia_mat(:,:,2) = zeros(3);
inertia_mat(3,3,2) = inertia_mom(2);
alpha = zeros(3,n,b);
beta = zeros(3,n,b);

% Compute LeftHandSide of the NE equations
for bi = 1:b
    for i = 1:n
        [alpha(:,i,bi),beta(:,i,bi)] = solveNE_LHS(vd(:,i,bi),...
            wd(:,i,bi),w(:,i,bi),ori(:,i,bi),ms(:,bi),inertia_mat(:,:,bi),masses(:,bi));
    end
end

% Compute RightHandSide of the NE equations
f_i = zeros(3,n,bi);
m_i = zeros(3,n,bi);

% Terminal body
f_nextbody = [0;0;0];
m_nextbody = [0;0;0];
dist = [0;0;0];
for i = 1:n
    [f_i(:,i,2),m_i(:,i,2)] = solveNE_balance(alpha(:,i,2),beta(:,i,2),...
        ori(:,i,2),COM(:,2),masses(:,2),f_nextbody,m_nextbody,dist);
end

% Loop through the other body
for bi=b-1:-1:1
    for i=1:n
        f_nextbody = -f_i(:,i,bi+1);
        m_nextbody = -m_i(:,i,bi+1);
        dist = pos(:,i,bi+1) - pos(:,i,bi);
        [f_i(:,i,bi),m_i(:,i,bi)] = solveNE_balance(alpha(:,i,bi),...
            beta(:,i,bi),ori(:,i,bi),COM(:,bi),masses(:,bi),f_nextbody,...
            m_nextbody,dist);
    end
end

% Obtain ground reaction forces and moments
GRF(1,:) = f_i(1,:,1);
GRF(2,:) = f_i(2,:,1);
GRF(3,:) = f_i(3,:,1);
GRM(1,:) = m_i(1,:,1);
GRM(2,:) = m_i(2,:,1);
GRM(3,:) = m_i(3,:,1);

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
