function [error1,error2] = errorCal(distance, results)

%   This function calculate the Error between each Data
% distance : Vector[1,W], contaning the standarded distances 
% results : Vector[1,W], result from our experiment
W = length(distance);
error1 =  sum(abs(results - distance))/W;
error2 =  sum(abs(results - distance)./distance)/W;
end