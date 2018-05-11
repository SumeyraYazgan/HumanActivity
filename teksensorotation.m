%plot ekran ayrildi
%txt dosyasi ekliyor

%this script is able to read in the correct way the string that arrive from
%arduino and to put the right variable in the right place

clear all;
close all;
delete(instrfind);

%important setting variables
BaudRate=19200;%with thisvariable yu can set the baudrate of arduino
buffSize=100;
simulation_duration=50; %time in seconds

%creating an object arduino
arduino=serial('COM4','BaudRate',BaudRate);
%dev/tty.SOR-DevB
%/dev/tty.usbmodem1421
%/dev/tty.usbmodem1421

%opening the communication with the object arduino
fopen(arduino);
%first reading to throw away
str=fscanf(arduino);

str=read_MPU6050(arduino);
dt=str(1); %
angle_x=str(2);
angle_y=str(3);
angle_z=str(4);


%%%%% let's start the rotation cube%%%%%%%%%%

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
data=zeros(1,3);
count=0;

tic; %to count the seconds

while(toc<simulation_duration) %stop after "simulation duration" seconds
    str=read_MPU6050(arduino);
    dt=str(1);
    angle_x=str(2)*pi/180;
    angle_y=str(3)*pi/180;
    angle_z=str(4)*pi/180;
    count=count+1;
   
    data(count,:)=[str(2) str(3) str(4)];
    
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

prompt = 'Export Data? [Y/N]: ';
str = input(prompt,'s');
if str == 'Y' || strcmp(str, ' Y') || str == 'y' || strcmp(str, ' y')
    export data
    csvwrite('h0_0.txt',data);
    type h0_0.txt;
    delete(instrfind);
    save ('h0_0','data');
else
end
