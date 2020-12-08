%% Reads the content of the Force files
function F2 = readForce(filename)
    
    F = readtable(filename);
    F=F{:,:}';
    F=F(3:8,:);
    
    % Resample is neccesary because the force plate frequency is faster
    % than the motion capture measurments
    for i=1:6
        F2(i,:)=resample(F(i,:),60,1000);
    end
    
    
    [b,a]=butter(4,4/((1/(2*(1/60)))/2));
    
    for i=1:6
        F2(i,:)=medfilt1(F2(i,:),5);
        F2(i,:)=filtfilt(b,a,F2(i,:));
    end
    
end