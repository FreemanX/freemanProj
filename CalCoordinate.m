function [isSolved, Cx,Cy ] = CalCoordinate( Ax, Ay, Bx, By, AC, BC )
%   Detailed explanation goes here
%This function is to calculate the coordinates of an unknown point C(Cx, Cy)
%with two known points A(Ax, Ay), and B(Bx, By) and  the distance AC and BC 
AB = sqrt((Ax - Bx)^2 + (Ay - By)^2);
if BC + AC >= AB
    [Cx, Cy, ~, ~] = getPoint(Ax, Ay, Bx, By, BC, AC);
    
    if isreal(Cx) && isreal(Cy)
       isSolved = true;
    else
        isSolved = false;
    end
else
    isSolved = false;
    Cx = inf;
    Cy = inf;
end

end

