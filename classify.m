%This function classifies the test data. 
%Plots graph of test data and in the below shows in which class the objec
%is blong with some different colored symbols. 
function[x] = classify (mov1, mov2, mov3,  testData)
%Gives numbers to each activity. these numbers will be used for label
indexMov1 = 0; 
indexMov2 = 1; 
indexMov3 = 2; 
%indexMov4 = 3; 
%indexMov5 = 4; 
%indexMov6 = 5;

%Creates labels for each activity
Movement1 = indexMov1 * ones(length(mov1),1);
Movement2 = indexMov2 * ones(length(mov2),1);
Movement3 = indexMov3 * ones(length(mov3),1);
%Movement4 = indexMov4 * ones(length(mov4),1);
%Movement5 = indexMov5 * ones(length(mov5),1);
%Movement6 = indexMov6 * ones(length(mov6),1);

%By combaining data of different activities creates training set. 
train(1:length(mov1),:) = mov1; 
train((length(mov1)+1):(length(mov1)+length(mov2)),:) = mov2; 
train((length(mov1)+length(mov2)+1):(length(mov1)+length(mov2)+length(mov3)),:) = mov3;
%train((length(mov1)+length(mov2)+length(mov3)+1):(length(mov1)+length(mov2)+length(mov3)+length(mov4)),:) = mov4;
%train((length(mov1)+length(mov2)+length(mov3)+length(mov4)+1):(length(mov1)+length(mov2)+length(mov3)+length(mov4)+length(mov5)),:) = mov5; 
%train((length(mov1)+length(mov2)+length(mov3)+length(mov4)+length(mov5)+1):(length(mov1)+length(mov2)+length(mov3)+length(mov4)+length(mov5)+length(mov6)),:) = mov6; 

%
X = train;
Y = [Movement1;Movement2;Movement3]; %Combination of labels
mdl = fitcknn(X,Y,'NumNeighbors',1); %Creating model by using k-NN
x = predict(mdl, testData); %classifies test data and returns related label numbers
%Ploting Graph of test data
subplot(2,1,1)
plot(testData)
title('Test Data')
xlabel('Number of Sample')
ylabel('Magnitude of yaw-pitch-roll values')
hold on
% This part plot a graph to show which object correspond to which activity.
% To show this different colored different symbols are used. 
% This graph is plotted with respect to classification result.
for i = 1:1:length(testData) 
   if (x(i) == 0) 
    subplot(2,1,2)
    plot(i,x(i),'bo'); 
    title('Classifitaion Result')
    xlabel('Number of Sample')
   % ylabel('Magnitude of yaw-pitch-roll values')
    hold on
   elseif (x(i) == 1) 
    subplot(2,1,2)
    plot(i,x(i)-1,'yx')
    title('Classifitaion Result')
    xlabel('Number of Sample')
    hold on
   elseif (x(i) == 2) 
     subplot(2,1,2)
     plot(i,x(i)-2,'r*')
     legend ('Standing');
     legend ('LateralRaise');
     legend ('FrontalRaise');
     
     title('Classifitaion Result')
     xlabel('Number of Sample')
     hold on
   %elseif(x(i) == 3)
    % subplot(2,1,2)
     %plot(i,x(i)-3,'ko')
     %legend ('FrontalRaise');
     %title('Classifitaion Result')
     %xlabel('Number of Sample')
     %hold on
   %elseif (x(i) == 4)
    % subplot(2,1,2)
     %plot(i,x(i)-4,'w*')
     %legend ('FrontalRaise');
     %title('Classifitaion Result')
    % xlabel('Number of Sample')
    % hold on
   %elseif(x(i) == 5)
    % subplot(2,1,2)
     %plot(i,x(i)-5,'c*')
     %title('Classifitaion Result')
     %xlabel('Number of Sample')
     %hold on
   end
   
   
end

 