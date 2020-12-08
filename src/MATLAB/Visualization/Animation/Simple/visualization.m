%% Avery simple way of visualizating the movement
% Could be improved
function [] = visualization(pos, MCfile)
    
    for i=1:length(pos)
        
        v = get3dline(2,1,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        str = '#f9a800';
        color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
        title(MCfile, 'FontSize',12,'FontWeight','bold','Color',color);
        axis([-1 1 -1 1 0 2]);
        hold on;
        v = get3dline(3,2,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(4,3,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(13,1,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(14,1,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(16,14,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(15,13,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(18,16,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(17,15,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(19,17,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(20,18,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(5,3,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(7,5,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(9,7,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(11,9,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(6,3,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(8,6,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(10,8,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        v = get3dline(12,10,pos,i);
        plot3(v(:,1),v(:,2),v(:,3));
        
        pause(0.00001);
        hold off;
        
    end
    
end