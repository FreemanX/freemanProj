function [error1,error2] = errorCalGetVar(distance, results)

%%  This function calculate the Error between each Data
% distance : Vector[1,W], contaning the standarded distances 
% results : Vector[1,W], result from our experiment
totalError1 = 0; %#ok<*NASGU>
totalError2 = 0; %#ok<*NASGU>

%we dismiss the error data result(5)
for i = [1:4] 
 totalError1 = totalError1 + abs(results(i)-distance(i));
 totalError2 = totalError2 + abs((results(i)-distance(i))./distance(i));
end

%we dismiss the error data result(12)
for i = [6:11]
 totalError1 = totalError1 + abs(results(i)-distance(i));
 totalError2 = totalError2 + abs((results(i)-distance(i))./distance(i));
end

%return the 2 types of errors
error1 =  totalError1./10;
error2 =  totalError2./10;

end