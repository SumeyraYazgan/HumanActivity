function [ out ] = twosensor_read_MPU6050( arduino )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

str=fscanf(arduino);
% str1=str(1:6);
stop1=NaN;


for j=1:length(str)%to find the end of the first number sent
    
    if str(j)=='A' && (str(j+1)=='1')
        stop1=j;
     
        break;
    end
end

%dt=str2double(str(5:stop1));
stop2=NaN; %to find the first ','
for j=stop1+1:length(str)
    if str(j)==','
        stop2=j-1;
        break;
    end
end
angle_x1=str2double(str(stop1+3:stop2));
%to find the second ','
stop3=NaN; %to find the first ','
for j=stop2+2:length(str)
    if str(j)==','
        stop3=j-1;
        break;
    end
end
angle_y1=str2double(str(stop2+2:stop3));
%to find the 3° ','
stop4=NaN; %to find the first ','
for j=stop3+2:length(str)
    if str(j)==','
        stop4=j-1;
        break;
    end
end

angle_z1=str2double(str(stop3+2:stop4));

stop5=NaN; %to find the first ','
for j=stop4+5:length(str)
    if str(j)==','
        stop5=j-1;
        break;
    end
end
angle_x2=str2double(str(stop4+5:stop5));
%to find the 3° ','

stop6=NaN; %to find the first ','
for j=stop5+2:length(str)
    if str(j)==','
        stop6=j-1;
        break;
    end
end

angle_y2=str2double(str(stop5+2:stop6));



angle_z2=str2double(str(stop6+2:length(str)));
%degistirdik




out=[angle_x1,angle_y1,angle_z1,angle_x2,angle_y2,angle_z2];




end
