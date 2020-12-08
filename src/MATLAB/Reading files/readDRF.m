%% Reads the content of the DRF files and returns the position and orientation of the joints frames
function [pos,ori,time] = readDRF(filename)

    fd=fopen(filename);
    line=fgetl(fd);
    i=1;
    %% Saves each line that starts with '6dj'
    while (ischar(line))
        if (isempty(line))
            line=fgetl(fd);
            continue;
        elseif (line(1:3)=='6dj')
           Aux(i,:)=convertCharsToStrings(line);
           line=fgetl(fd);
           i=i+1;
        elseif (line(1:2)=='ts')
            Aux3(i,:)=convertCharsToStrings(line);
            line=fgetl(fd);
            
        else
            line=fgetl(fd);
        end
    end
    
    %% Split each saved line in each '][' and saves only the one that we are interested in
    for i=1:length(Aux)
        temp=strsplit(Aux(i),'][');
        for j=1:20
            Aux2(j,:,i)=temp(3*j);
        end
    end
    
    %% Convert to a number
    for i=1:length(Aux2)
       for j=1:size(Aux2,1)
           drfdata(j,:,i)=str2num(Aux2(j,:,i));
       end
    end
    
    pos = drfdata(:,1:3,:)/1000;
    ori = deg2rad(drfdata(:,4:6,:));
    
    %% Split the ts lines in each ' ' and convert to a number
    for i=1:length(Aux3)
       temp=strsplit(Aux3(i),' ');
       time(i)=str2num(temp(2));
    end
    
end