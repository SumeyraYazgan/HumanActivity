%Matlab asil code kismi

%plot ekran ayrildi
%txt dosyasi ekliyor

%this script is able to read in the correct way the string that arrive from
%arduino and to put the right variable in the right place

clear all;
close all;
delete(instrfind);

%important setting variables
BaudRate=9600;%with thisvariable yu can set the baudrate of arduino
buffSize=100;
simulation_duration=25; %time in seconds


%creating an object arduino
arduino=serial('COM9','BaudRate',BaudRate);
%dev/tty.SOR-DevB
%/dev/tty.usbmodem1421
%/dev/tty.usbmodem1421

%opening the communication with the object arduino
fopen(arduino);
%first reading to throw away
str=fscanf(arduino);
str=fscanf(arduino);


%%
%reading and setting files by using function
str=twosensor_read_MPU6050(arduino);
dt=str(1);
angle_x=str(2);
angle_y=str(3);
angle_z=str(4);


%%%%% let's star the rotation cube%%%%%%%%%%

%%% Initialized the cube

xc=0; yc=0; zc=0;    % coordinated of the center
L=2;                 % cube size (length of an edge)
alpha=0.8;             % transparency (max=1=opaque)

X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];

C= [0.1 0.5 0.9 0.9 0.1 0.5];   % color/face

X = L*(X-0.5) + xc;
Y = L/1.5*(Y-0.5) + yc;
Z = L/3*(Z-0.5) + zc;
V=[reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)]; %rashape takesthe element of X and it fix them in only one coulomn (in this case)
data=zeros(3,1);
count=0;

tic; %to count the seconds

%%
%Real time cube drawing
while(toc<simulation_duration) %stop after "simulation duration" seconds
%Setting X,Y,Z values
    str=read_MPU6050(arduino);
    dt=str(1);
    angle_x=str(2)*pi/180;
    angle_y=str(3)*pi/180;
    angle_z=str(4)*pi/180;
    count=count+1;
    
    % Creating data matrix to store data later
   data(1,count)=(str(2));
   data(2,count)=(str(3));
   data(3,count)=(str(4));
    
    %To visualize cube
    dcm_filtered = angle2dcm( angle_z, angle_x, angle_y); %it creates the rotation matrix [angoli di eulero -> (z,y,x)]
    VR_filtered=dcm_filtered*V;
    
    XR_filtered=reshape(VR_filtered(1,:),4,6);
    YR_filtered=reshape(VR_filtered(2,:),4,6);
    ZR_filtered=reshape(VR_filtered(3,:),4,6);


%%
   PlotShape(XR_filtered,YR_filtered,ZR_filtered,C,alpha)
    
    

end
    
%Close Serial COM Port and Delete useless Variables
fclose(arduino);

clear count dat delay max min plotGraph plotGraph1 plotGraph2 plotGrid...
    plotTitle s scrollWidth serialPort xLabel yLabel;

disp('Session Terminated');
%%
%To save data
prompt = 'Export Data? [Y/N]: ';
str = input(prompt,'s');
if str == 'Y' || strcmp(str, ' Y') || str == 'y' || strcmp(str, ' y')
    export data
    csvwrite('h0_0.txt',transpose(data));
    type h0_0.txt;
    delete(instrfind);
    
    data = transpose(data); 
    save ('h0_0','data');
else
end


