%% Script for recovering the formation graph using signal strength, not real time version
%% Initialization
% Initial the settings and global variables of this program
clear;      %Clear all memery
clc;        %Clear screen
close all;  %Close all figure windows
addpath(genpath('./'));
FormationNum = 5;
x = zeros(1, 4);
y = zeros(1, 4);
windowSize = 5;
left = 1;
right = left + windowSize;
speed = 3;
currentWindow = zeros(4, 4, windowSize);
pauseTime = 0.1;
%% Load data
dataDir = ['./Data/Formation' ,num2str(FormationNum) ,'/'];
testNum = 2;

if testNum == 1
    dataAmount = 56;
elseif testNum == 2
    dataAmount = 500;
else
    dataAmount = 59;
end
sigData = zeros(4, 4, dataAmount);
for i = 1 : 4             % Data stored in ith drone
    piDir = ['Pi0', num2str(i), '+Formation', num2str(FormationNum), '/'];
    for j = 1 : 4         % Signal strength data of jth drone
        if i == j
            continue;
        end
        stationDir = ['station', num2str(j), '/'];
        dataFile = ['Station', num2str(j), '-Test', num2str(testNum)];
        filePath = [dataDir, piDir, stationDir, dataFile];
        %display(filePath);
        sigData(i, j, : ) = [importData(filePath, 1, dataAmount)]';
    end
end


%% Simulate realtime 
while right + speed < dataAmount
    currentWindow = sigData(:, :, left : right);
    
    d = formationDistanceCal(currentWindow);
    for i = 1:4
        for j = 1:4
            d(i, j) = (d(i, j) + d(j, i))/2;
            d(j, i) = d(i, j);
        end
    end
    %% Main algorithm
    % Assumptions
    % All drones are alwayse detectable with each other
    % Pi01 as (0,0) all the time
    % Pi02 is always located on X-axis, y2 = 0
    % y3 is >= 0
    x(1) = 0;
    y(1) = 0;
    
    % Calculate the x(2), the distance between Pi01 and Pi02
    x(2) = d(1, 2);
    y(2) = 0;
    
    % Calculate the coordinate of Pi03 using Pi01 and Pi02
    % x(3) = (power(x(2), 2) - power(d(2, 3), 2) + power(d(1, 3), 2))/(2*x(2));
    % y(3) = sqrt(power(d(1, 3), 2) - power(x(3), 2));
    
    x(3) = ((d(1, 2)^2) - (d(2, 4)^2) + (d(1, 3)^2))/(2*d(1,2));
    y(3) = sqrt(d(1, 3)^2 - x(3)^2);
    [isSolved3, x(3), y(3)] = CalCoordinate(x(1), y(1), x(2), y(2), d(1, 3), d(2, 3));
    if isreal(y(3)) ~= 1
        display('y3 Error');
    end
    % Calculate the coordinate of Pi04 using Pi01 and Pi02
    % If there's no real root, calculate using Pi03 and the other point
    %x(4) = (power(x(2), 2) - power(d(2, 4), 2) + power(d(1, 4), 2))/(2*x(2));
    %y(4) = sqrt(power(d(1, 4), 2) - power(x(4), 2));
    pointA = 1;
    pointB = 2;
    while isSolved3
        [isSolved4, x(4), y(4)] = CalCoordinate(x(pointA), y(pointA), x(pointB), y(pointB), d(pointA, 4), d(pointB, 4));
        if isSolved4
            break;
        else
            if pointB < 3
                pointB = pointB + 1;
            elseif pointA < 2
                pointA = pointA + 1;
            else
                display('y4 Error');
                break;
            end
        end
    end
    
    
%    x(4) = (d(1,4)^2 - d(2,4)^2 + d(1,2)^2)/(2*d(1, 2));
%    y(4) = sqrt(d(1, 4)^2 - x(4)^2);
%    [~, x(4), y(4)] = CalCoordinate(x(1), y(1), x(2), y(2), d(1, 4), d(2, 4));
%    if isreal(y(4)) ~= 1
%        display('y4 Error');
%    end
    %% Plot Results
    clf;
    upLim = 15;
    figure(1); hold on;
    title('Sample Distance Output Figure Average');
    p1 = plot(x(1), y(1), 'o');
    set(p1, 'Color', 'red', 'LineWidth',15 );
    p2 = plot(x(2), y(2), 'o');
    set(p2, 'Color', 'green', 'LineWidth',15 );
    p3 = plot(x(3), y(3), 'o');
    set(p3, 'Color', 'yellow', 'LineWidth',15 );
    p4 = plot(x(4), y(4), 'o');
    set(p4, 'Color', 'magenta', 'LineWidth',15 );
    xlim([-upLim,upLim]);
    ylim([-upLim,upLim]);
    xlabel('Distance(m)','FontSize',12,'FontWeight','bold');
    ylabel('Distance(m)','FontSize',12,'FontWeight','bold');
    hold off;
    
    left = left + speed;
    right = right + speed;
    pause(pauseTime);
end






















