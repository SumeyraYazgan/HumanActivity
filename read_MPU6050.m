%Eski kod tek sensorle okumak icin yapildi

function [ out ] = read_MPU6050( arduino )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

str=fscanf(arduino);
str1=str(1:4);
stop1=NaN;

for j=5:length(str)%to find the end of the first number sent
    if str(j)=='A'
        stop1=j-2;
        break;
    end
end

dt=str2double(str(5:stop1));
stop2=NaN; %to find the first ','
for j=stop1+4:length(str)
    if str(j)==','
        stop2=j-1;
        break;
    end
end
angle_x=str2double(str(stop1+6:stop2));
%to find the second ','
stop3=NaN; %to find the first ','
for j=stop2+2:length(str)
    if str(j)==','
        stop3=j-1;
        break;
    end
end
angle_y=str2double(str(stop2+2:stop3));
%to find the 3° ','

angle_z=str2double(str(stop3+2:length(str)));
%degistirdik




out=[dt,angle_x,angle_y,angle_z];



end
