%% a is distance of BC, b is distance of AC , c is distance of AB
function [x1, y1, x2, y2] = getPoint(Ax, Ay, Bx, By, a, b)
m = b^2 - Ax^2 - Ay^2;
n = a^2 - Bx^2 - By^2;

if (Ay~=By)
    
    p = (n-m)./(2*(Ay-By));
    q = (Ax-Bx)./(Ay-By);
    
    va = 1 + q^2;
    vb = 2*Ay*q - 2*Ax - 2*p*q;
    vc = Ax^2 + p^2 - 2*Ay*p + Ay^2 -b^2;
    
    x1 = (-vb + sqrt(vb^2 - 4*va*vc))./(2*va);
    x2 = (-vb - sqrt(vb^2 - 4*va*vc))./(2*va);
    
    y1 = p - q*x1;
    y2 = p - q*x2;
    
else
    
    p = (n-m)./(2*(Ax-Bx));
    q = (Ay-By)./(Ax-Bx);
    
    va = 1 + q^2;
    vb = 2*Ax*q - 2*Ay - 2*p*q;
    vc = Ay^2 + p^2 - 2*Ax*p + Ax^2 -b^2;
    
    y1 = (-vb + sqrt(vb^2 - 4*va*vc))./(2*va);
    y2 = (-vb - sqrt(vb^2 - 4*va*vc))./(2*va);
    
    x1 = p - q*y1;
    x2 = p - q*y2;
    
end




