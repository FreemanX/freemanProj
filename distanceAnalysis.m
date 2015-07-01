%% Script for analysing the relationship between distance and signal strength
%% Initialization
% Initial the settings and global variables of this program
clear;      %Clear all memery
clc;        %Clear screen
close all;  %Close all figure windows
addpath(genpath('./'));   
%% Load data
% You can modify the path to load whatever data we get from the experiemnt
% All the data are in the Data directory, as we are using the ralative
% path to load data, don't change the './Data/' part in dataDir veriable 
% You may change the dataDir and dataFile to load the data you want
% Here is an example of how to load the data of distance test from Pi1,
% output is a 13*600 matrix
dataDir = './Data/distancePi3/';
Pi1data = zeros(600, 13);   %There are 13 sets of data and each contains 600 data. Store them in a 13*600 matrix
for i = 1 : 13              %The matrix index starts from 1 rather than 0
    dataFile = ['Station1-Test',num2str(i - 1)];    
    filePath = [dataDir, dataFile];
    Pi1data(:, i) = [importData(filePath, 1, 600)]'; %You may change the name of the data matrix
end

%% Pre-process Data
% The output of this part is a 1*13 matrix, indicating the signal strength
% for each distance

% I have consider 2 ways to deal with the signal strength
% The 1st one is stright forward, just calculate the average value for each
% distance test
avgSig = mean(Pi1data);
% The 2nd way is taking the most frequent signal strength into
% consideration. Assume that if there is no change of the enviroment or
% other sudden influence on two nodes, the signal strength from the other
% side should remain the same. So it might be worse to calculate the
% average signal strength.
mostFreq = mode(Pi1data);



%% Process Data (main Algorithm)
% Put the distance-signalStrength function here, the output should be
% distance
results = sampleCalDistance(mostFreq);

%% Calculate error
% Compare the distance getting from previous part with the actual distance
% and get the error. An error calculation function is included
% Example:
distance = [0 1 2 3 4 5 6 7 8 9 10 11 12];
[error1, error2] = errorCal(distance(2:13), results(2:13));

display (['The error1 is: ', num2str(error1)]);
display (['The error2 is: ', num2str(error2)]);
%% Plot Results
figure(2); hold on;
title('Sample Distance Output Figure Average');
p1 = plot(1:length(results), results, 'x');
set(p1, 'Color', 'red', 'LineWidth',2 );
p2 = plot(1:length(distance), distance, 'o');
set(p2, 'Color', 'blue', 'LineWidth',1 );
%xlim([1,length(results)]);
%xlabel('Content','FontSize',12,'FontWeight','bold');
ylabel('Distance(m)','FontSize',12,'FontWeight','bold');
hold off;





