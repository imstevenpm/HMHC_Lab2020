%% Get the 3D line between two 3D points
function v = get3dline(next,past,pos,i)
    
    v=[-pos(past,1,i),-pos(past,2,i),pos(past,3,i);-pos(next,1,i),-pos(next,2,i),pos(next,3,i)];

end