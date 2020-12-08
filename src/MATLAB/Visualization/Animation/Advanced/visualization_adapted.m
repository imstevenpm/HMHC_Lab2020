function [] = visualization_adapted(Body, time, pos, ori)
 % addpath(genpath('../Functions'));

  %% Assembly body structure
  L_Hand=Body.handL;
  L_Forearm=Body.forearmL;
  L_Upperarm=Body.upperarmL;
  L_Foot=Body.footL;
  L_Shank=Body.shankL;
  L_Thigh=Body.thighL;
  R_Hand=Body.handR;
  R_Forearm=Body.forearmR;
  R_Upperarm=Body.upperarmR;
  R_Foot=Body.footR;
  R_Shank=Body.shankR;
  R_Thigh=Body.thighR;
  Head=Body.head;
  U_Trunk=Body.uppertrunk;
  M_Trunk=Body.middletrunk;
  L_Trunk=Body.lowertrunk;
  
  L=length(time);
  dt=1/60;
  
for k=1:L
    hold off;
   %head
   v4=[pos(4,:,k), ori(4,:,k)]';
   [X,Y,Z] = ellipsoid(0,0,0,Head.a,Head.b,Head.c); %Z=Z-Head.c;
   [X,Y,Z]=trans_rot(X,Y,Z,v4);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   %t=CoM_pos_orientation(Head,motion.J4(:,k));
   %plot3(t(1),t(2),t(3),'o-r','Linewidth',4)
   hold on

   
   %U trunk
   v3=[pos(3,:,k), ori(3,:,k)]';
   [X,Y,Z]=elliptical(U_Trunk.a0,U_Trunk.b0,U_Trunk.a1,U_Trunk.b1,U_Trunk.L); Z=Z-U_Trunk.L;
   [X,Y,Z]=trans_rot(X,Y,Z,v3);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);


   %M_Trunk
   v2=[pos(2,:,k), ori(2,:,k)]';
   [X,Y,Z]=elliptical(M_Trunk.a0,M_Trunk.b0,M_Trunk.a1,M_Trunk.b1,M_Trunk.L); Z=Z-M_Trunk.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,v2);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);

   %L_trunk
   [X,Y,Z]=elliptical(L_Trunk.a0,L_Trunk.b0,L_Trunk.a1,L_Trunk.b1,L_Trunk.L);  Z=Z-L_Trunk.L-M_Trunk.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,v2);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);

   
   %R upper arm
   v8=[pos(8,:,k), ori(8,:,k)]';
   [X,Y,Z]=elliptical(R_Upperarm.a0,R_Upperarm.b0,R_Upperarm.a1,R_Upperarm.b1,R_Upperarm.L);  Z=Z-R_Upperarm.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v8);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %L upper arm
   v7=[pos(7,:,k), ori(7,:,k)]';
   [X,Y,Z]=elliptical(L_Upperarm.a0,L_Upperarm.b0,L_Upperarm.a1,L_Upperarm.b1,L_Upperarm.L);  Z=Z-L_Upperarm.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v7);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);

   %R forearm
   v10=[pos(10,:,k), ori(10,:,k)]';
   [X,Y,Z]=elliptical(R_Forearm.a0,R_Forearm.b0,R_Forearm.a1,R_Forearm.b1,R_Forearm.L);  Z=Z-R_Forearm.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v10);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %L forearm
   v9=[pos(9,:,k), ori(9,:,k)]';
   [X,Y,Z]=elliptical(L_Forearm.a0,L_Forearm.b0,L_Forearm.a1,L_Forearm.b1,L_Forearm.L);  Z=Z-L_Forearm.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v9);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %R hand
   v12=[pos(12,:,k), ori(12,:,k)]';
   [X,Y,Z] = ellipsoid(0,0,0,R_Hand.a,R_Hand.b,R_Hand.c); Z=Z-R_Hand.c;
   [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v12);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %L hand
   v11=[pos(11,:,k), ori(11,:,k)]';
   [X,Y,Z] = ellipsoid(0,0,0,L_Hand.a,L_Hand.b,L_Hand.c); Z=Z-L_Hand.c;
   [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v11);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %R thigh
   v16=[pos(16,:,k), ori(16,:,k)]';
   [X,Y,Z]=elliptical(R_Thigh.a0,R_Thigh.b0,R_Thigh.a1,R_Thigh.b1,R_Thigh.L);  Z=Z-R_Thigh.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v16);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);

   
   %L thigh 
   v15=[pos(15,:,k), ori(15,:,k)]';
   [X,Y,Z]=elliptical(L_Thigh.a0,L_Thigh.b0,L_Thigh.a1,L_Thigh.b1,L_Thigh.L);  Z=Z-L_Thigh.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v15);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %R shank
   v18=[pos(18,:,k), ori(18,:,k)]';
   [X,Y,Z]=elliptical(R_Shank.a0,R_Shank.b0,R_Shank.a1,R_Shank.b1,R_Shank.L);  Z=Z-R_Shank.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v18);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %L shank 
   v17=[pos(17,:,k), ori(17,:,k)]';
   [X,Y,Z]=elliptical(L_Shank.a0,L_Shank.b0,L_Shank.a1,L_Shank.b1,L_Shank.L);  Z=Z-L_Shank.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v17);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %R foot
   v20=[pos(20,:,k), ori(20,:,k)]';
   [X,Y,Z]=elliptical(R_Foot.a0,R_Foot.b0,R_Foot.a1,R_Foot.b1,R_Foot.L);  Z=Z-R_Foot.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,-pi/2,0,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v20);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   
   %L foot
   v19=[pos(19,:,k), ori(19,:,k)]';
   [X,Y,Z]=elliptical(L_Foot.a0,L_Foot.b0,L_Foot.a1,L_Foot.b1,L_Foot.L);  Z=Z-L_Foot.L;
   [X,Y,Z]=Rotation_solid(X,Y,Z,-pi/2,0,0);
   [X,Y,Z]=trans_rot(X,Y,Z,v19);
   mesh(X,Y,Z);
   axis([-1 1 -1 1 0 2]);
   view([1, 1, 1]);
   pause(dt/100);
  
end

close all;

end
