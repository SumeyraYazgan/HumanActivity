%This function classifies the test data. 
%Plots graph of test data and in the below shows in which class the objec
%is blong with some different colored symbols. 
function[] = classifier5 (mov2, mov3, mov4, mov5,mov6, testData)

%Gives numbers to each activity. these numbers will be used for label
indexMov2 = 1; 
indexMov3 = 2; 
indexMov4 = 3; 
indexMov5 = 4; 
indexMov6 = 5;

%Creates labels for each activity
Movement2 = indexMov2 * ones(length(mov2),1);
Movement3 = indexMov3 * ones(length(mov3),1);
Movement4 = indexMov4 * ones(length(mov4),1);
Movement5 = indexMov5 * ones(length(mov5),1);
Movement6 = indexMov6 * ones(length(mov6),1);

%%
%By combaining data of different activities creates training set. 
X = [mov2;mov3;mov4;mov5;mov6];
Y = [Movement2;Movement3;Movement4;Movement5;Movement6]; %Combination of labels


mdl = fitcknn(X,Y,'NumNeighbors',1); %Creating model by using k-NN
x = predict(mdl, testData); %classifies test data and returns related label numbers
% cp = classperf (Y,x);
% get(cp)
% cp.CorrectRate

%%
%Ploting Graph of test data
subplot(2,1,1)
a1 = plot(testData(:,1),'r'); 
hold on 
a2 = plot(testData(:,4),'r--');
hold on 
a3 = plot(testData(:,2),'g');
hold on 
a4 = plot(testData(:,5),'g--');
hold on 
a5 = plot(testData(:,3),'b');
hold on 
a6 = plot(testData(:,6),'b--');
hold on
title('Test Data')
xlabel('Number of Sample')
ylabel('Magnitude of yaw-pitch-roll values')
legend ([a1 a2 a3 a4 a5 a6], 'yaw of 1st sensor', 'yaw of 2nd sensor','pitch of 1st sensor','pitch of 2nd sensor', 'roll of 1st sensor', 'roll of 2nd sensor');

% This part plot a graph to show which object correspond to which activity.
% To show this different colored different symbols are used. 
% This graph is plotted with respect to classification result.
tic
d1 = [];
d2 = [];
d3 = [];
d4 = [];
d5 = [];

for i = 1:1:length(testData) 
 
     switch x(i);
      case 1 
      subplot(2,1,2)
      d1 = [d1; i (x(i)-1)];  
      title('Classifitaion Result')
      xlabel('Number of Sample')
      hold all


      case 2
      subplot(2,1,2)
      d2 = [d2; i (x(i)-2)];      
      title('Classifitaion Result')
      xlabel('Number of Sample')
      hold on

      case 3
      subplot(2,1,2)
      d3 = [d3; i (x(i)-3)];
      title('Classifitaion Result')
      xlabel('Number of Sample')
      hold on

      case 4
      subplot(2,1,2)
      d4 = [d4; i (x(i)-4)];
      title('Classifitaion Result')
      xlabel('Number of Sample')
      hold on
     
      case 5
      subplot(2,1,2)
      d5 = [d5; i (x(i)-5)];     
      title('Classifitaion Result')
      xlabel('Number of Sample')
      hold on

    end 
end
try 
  plot(d1(:,1),d1(:,2), 'bo');
catch
end

try
  plot(d2(:,1),d2(:,2), 'y*');
catch 
end

try 
  plot(d3(:,1),d3(:,2), 'rs');
catch 
end

try
   plot(d4(:,1),d4(:,2), 'cv');
catch
end

try
   plot(d5(:,1),d5(:,2), 'm+');
catch
end
L = [{'adduction', 'flexion','extension', 'lateral rotation', 'circumduction'}];




if(isempty(d1))
    index = strfind(L,'adduction');
    j = find(not(cellfun('isempty', index))); 
    L(j) = []; 
end
    
if(isempty(d2))
    index = strfind(L,'flexion');
    j = find(not(cellfun('isempty', index))); 
    L(j) = []; 
end

if(isempty(d3))
    index = strfind(L,'extension');
    j = find(not(cellfun('isempty', index))); 
    L(j) = []; 
end

if(isempty(d4))
    index = strfind(L,'lateral rotation');
    j = find(not(cellfun('isempty', index))); 
    L(j) = []; 
end

if(isempty(d5))
    index = strfind(L,'circumduction');
    j = find(not(cellfun('isempty', index))); 
    L(j) = []; 
end
toc
 legend(L)