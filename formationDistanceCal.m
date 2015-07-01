function [ distance ] = formationDistanceCal( sigStrength )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
a = 26.7;
b = 32.7;
avgSigStrength = mean(sigStrength, 3);
distance = power(10,((avgSigStrength(1,1) - avgSigStrength - a)/b)) - power(10, -a/b);
end

