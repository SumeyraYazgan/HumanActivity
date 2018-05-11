
%by using two arduino read data taken from Arduino from serial 

function [ out ] = twosensor_read_MPU6050( arduino )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

str=fscanf(arduino);    %to read serial port
% str1=str(1:6);
stop1=NaN;

%%
%Taken format of Arduino A1: X1, Y1, Z1 A2: X2,Y2,Z2
%To Find first A1 part to group other files
for j=1:length(str)%to find the end of the first number sent
    
    if str(j)=='A' && (str(j+1)=='1')
        stop1=j;  %First stop at the beginning of A     
        
       
     
        break;
    end
end

%dt=str2double(str(5:stop1));
stop2=NaN; %to find the first ','
for j=stop1+1:length(str)
    if str(j)==','
        stop2=j-1;      %Second stop point is first ','
        break;
    end
end
angle_x1=str2double(str(stop1+3:stop2));     %between A and stop2 is X1 value
%to find the second ','
stop3=NaN; %to find the first ','
for j=stop2+2:length(str)
    if str(j)==','
        stop3=j-1;                    %Third stop point is second ','
        break;
    end
end
angle_y1=str2double(str(stop2+2:stop3));        %Setting Y1 value
%to find the 3° ','
stop4=NaN; %to find the first ','
for j=stop3+2:length(str)
    if str(j)==','
        stop4=j-1;                        %Fourth stop point
        break;
    end
end

angle_z1=str2double(str(stop3+2:stop4));        %Setting Z1 value         
%%
% Taking data after 'A2:' command

stop5=NaN; %to find the first ','
for j=stop4+5:length(str)
    if str(j)==','
        stop5=j-1;                                %Fifth stop point
        break;
    end
end
angle_x2=str2double(str(stop4+5:stop5));               %Setting X2 value
%to find the 3° ','

stop6=NaN; %to find the first ','
for j=stop5+2:length(str)
    if str(j)==','
        stop6=j-1;                        %Sixth stop point
        break;
    end
end

angle_y2=str2double(str(stop5+2:stop6));                        %Setting Y2 value



angle_z2=str2double(str(stop6+2:length(str)));                    %Setting Z2 value
%degistirdik




out=[angle_x1,angle_y1,angle_z1,angle_x2,angle_y2,angle_z2];




end
