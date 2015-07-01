%% Script for analysing the relationship between distance and signal strength
%% Initialization
% Initial the settings and global variables of this program
clear;      %Clear all memery
clc;        %Clear screen
%close all;  %Close all figure windows
addpath(genpath('./'));
%% Load data
% You can modify the path to load whatever data we get from the experiemnt
% All the data are in the Data directory, as we are using the ralative
% path to load data, don't change the './Data/' part in dataDir veriable
% You may change the dataDir and dataFile to load the data you want
% Here is an example of how to load the data of distance test from Pi1,
% output is a 13*600 matrix
dataDir = './Data/distancePi1/';
Testdata = zeros(600, 12);   %There are 13 sets of data and each contains 600 data. Store them in a 13*600 matrix
for i = 1 : 12              %The matrix index starts from 1 rather than 0
    dataFile = ['Station3-Test',num2str(i)];
    filePath = [dataDir, dataFile];
    Testdata(:, i) = [importData(filePath, 1, 600)]'; %You may change the name of the data matrix
end

%% Pre-process Data
% The output of this part is a 1*13 matrix, indicating the signal strength
% for each distance

% I have consider 2 ways to deal with the signal strength
% The 1st one is stright forward, just calculate the average value for each
% distance test
avgSig = mean(Testdata);
% The 2nd way is taking the most frequent signal strength into
% consideration. Assume that if there is no change of the enviroment or
% other sudden influence on two nodes, the signal strength from the other
% side should remain the same. So it might be worse to calculate the
% average signal strength.
mostFreq = mode(Testdata);

A_var = 20;
B_var = 20;
current_Error1 = 100;
current_Error2 = 100;
distance = [1:12];

while  A_var<=30
    
    while B_var <= 60
        B_var = B_var + 0.1;
        
        test_results = power(10,((-2 - avgSig - A_var)/B_var)) - power(10,(-A_var)/B_var);
        
        [error1, error2] = errorCalGetVar(distance,test_results);
        
        if(error1<current_Error1)
            current_Error1 = error1;
            currnet_Error1_1 = error1;
            currnet_Error2_1 = error2;
            mA_var1 = A_var;
            mB_var1 = B_var;
        end
        
        if(error2<current_Error2)
            current_Error2 = error2;
            currnet_Error1_2 = error1;
            currnet_Error2_2 = error2;
            mA_var2 = A_var;
            mB_var2 = B_var;
        end
        display (['The A_var is: ', num2str(A_var)]);
        display (['The B_var is: ', num2str(B_var)]);
        display (['The error1 is: ', num2str(error1)]);
        display (['The error2 is: ', num2str(error2)]);
        
    end
    A_var = A_var + 0.1;
    B_var = 20;
end

display (['If we minimize error1: ']);
display (['The A_var is: ', num2str(mA_var1)]);
display (['The B_var is: ', num2str(mB_var1)]);
display (['The error1 is: ', num2str(currnet_Error1_1)]);
display (['The error2 is: ', num2str(currnet_Error2_1)]);

display (['If we minimize error2: ']);
display (['The A_var is: ', num2str(mA_var2)]);
display (['The B_var is: ', num2str(mB_var2)]);
display (['The error1 is: ', num2str(currnet_Error1_2)]);
display (['The error2 is: ', num2str(currnet_Error2_2)]);


%% Plot Results
%put the variable inside
test_results = power(10,((-2 - avgSig - mA_var1)/mB_var1)) - power(10,(-mA_var1)/mB_var1);


figure(2); hold on;
title('Sample Distance Output Figure Average');
p1 = plot(1:length(test_results), test_results, 'x');
set(p1, 'Color', 'red', 'LineWidth',2 );
p2 = plot(1:length(distance), distance, 'o');
set(p2, 'Color', 'blue', 'LineWidth',1 );
%xlim([1,length(results)]);
%xlabel('Content','FontSize',12,'FontWeight','bold');
ylabel('Distance(m)','FontSize',12,'FontWeight','bold');
hold off;




