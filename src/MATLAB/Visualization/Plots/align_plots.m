function [F,grdf,grdm,pos,ori,time] = align_plots(F,grdf,grdm,pos,ori,time)
    
    close all;
    figure (1);
    plot(grdf(3,:));
    title('Select the initial and final similar point between the two figures');
    figure (2);
    plot(F(3,:));
    title('Select the same initial and final similar point between the two figures');
    [xf,~] = ginput(2);
    xf=floor(xf);
    close(figure(2));
    [xg,~] = ginput(2);
    xg=floor(xg);
    
    offsetg=xg(2)-xg(1);
    offsetf=xf(2)-xf(1);
    
    if offsetg>=offsetf
        offset=offsetf;
    else
        offset=offsetg;
    end
    
    F=F(:,xf(1):(xf(1)+offset));
    grdf=grdf(:,xg(1):(xg(1)+offset));
    grdm=grdm(:,xg(1):(xg(1)+offset));
    pos=pos(:,:,xg(1):(xg(1)+offset));
    ori=ori(:,:,xg(1):(xg(1)+offset));
    time=time(:,xg(1):(xg(1)+offset));
    
    
    close all;
    
    
end