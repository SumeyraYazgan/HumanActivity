%Matlab asil code kismi

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
simulation_duration=20; %time in seconds


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
str=fscanf(arduino);
str=fscanf(arduino);
str=fscanf(arduino);
str=fscanf(arduino);
str=fscanf(arduino)

%%
%reading and setting files by using function
str=twosensor_read_MPU6050(arduino);
angle_x_A=str(1)*pi/180;
angle_y_A=str(2)*pi/180;
angle_z_A=str(3)*pi/180;
angle_x_B=str(4)*pi/180;
angle_y_B=str(5)*pi/180;
angle_z_B=str(6)*pi/180;


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
h5_17=zeros(1,6);
count=0;

tic; %to count the seconds

%%
%Real time cube drawing
display('ready')
while(toc<simulation_duration) %stop after "simulation duration" seconds
%Setting X,Y,Z values
    str=twosensor_read_MPU6050(arduino);
     if isequal(str(1), str(2), str(3), str(4), str(5), str(6))
   
     else
    angle_x_A=str(1)*pi/180;
    angle_y_A=str(2)*pi/180;
    angle_z_A=str(3)*pi/180;
    angle_x_B=str(4)*pi/180;
    angle_y_B=str(5)*pi/180;
    angle_z_B=str(6)*pi/180;
    count=count+1;
    h5_17(count,:)=[angle_x_A angle_y_A angle_z_A angle_x_B angle_y_B angle_z_B];
  
   
 
     end

    %To visualize cube
    dcm_filteredB = angle2dcm( angle_z_B, angle_x_B, angle_y_B);
    dcm_filteredA = angle2dcm( angle_z_A, angle_x_A, angle_y_A);
   %it creates the rotation matrix [angoli di eulero -> (z,y,x)]
    VR_filteredA=dcm_filteredA*V;
    XR_filteredA=reshape(VR_filteredA(1,:),4,6);
    YR_filteredA=reshape(VR_filteredA(2,:),4,6);
    ZR_filteredA=reshape(VR_filteredA(3,:),4,6);

    %it creates the rotation matrix [angoli di eulero -> (z,y,x)]
    VR_filteredB=dcm_filteredB*V;
    XR_filteredB=reshape(VR_filteredB(1,:),4,6);
    YR_filteredB=reshape(VR_filteredB(2,:),4,6);
    ZR_filteredB=reshape(VR_filteredB(3,:),4,6);
   
%%

 figure(1)
    subplot(2,1,1);

  PlotShape(XR_filteredA,YR_filteredA,ZR_filteredA,C,alpha,'Slave Module')
    
 % hold on
    subplot(2,1,2);
   
   PlotShape(XR_filteredB,YR_filteredB,ZR_filteredB,C,alpha,'Master Module')
 
  
  

    
     

end
    
%Close Serial COM Port and Delete useless Variables
fclose(arduino);

clear count dat delay max min plotGraph plotGraph1 plotGraph2 plotGrid...
    plotTitle s scrollWidth serialPort xLabel yLabel;

disp('Session Terminated');
%%
%To save data
prompt = 'Export Data? [Y/N]:';
str = input(prompt,'s');
if str == 'Y' || strcmp(str, ' Y') || str == 'y' || strcmp(str, ' y')
   % export data
    csvwrite('h5_17.txt',h5_17);
    type h5_17.txt;
    delete(instrfind);
    

    save ('h5_17','h5_17');
else
end


