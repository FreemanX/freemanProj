function [ distanceResults ] = sampleCalDistance( signalStrength )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
a = 26.7;
b = 32.7;
distanceResults = power(10,((signalStrength(1,1) - signalStrength - a)/b))- power(10, -a/ b);
end

