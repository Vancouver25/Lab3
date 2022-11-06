%approximation 
clear all;
close all;

e_average = 1;
n = 0;
m = 0.15;
x = 0.1:1/22:1; %input values
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2; %desired response
[hights,pos] = findpeaks(d);
[lows,poss] = findpeaks(-d);

%calculate weights, radius, centers
c1 = x(pos(1));
r1 =  (x(poss(1))-x(pos(1)))/2;

c2 = x(pos(2));
r2 =   x(pos(2))- (x(pos(2))+ x(poss(1)))/2;

w0 = randn(1);
w1 = randn(1);
w2 = randn(1);

%calculations

while e_average > 0.0005
    n = n + 1;
    
    for i = 1 : length(x)
        %Gauss f(x)
        F1 = exp(-(x(i)-c1)^2/(2*r1^2));
        F2 = exp(-(x(i)-c2)^2/(2*r2^2));
        %net response
        y(i) = F1*w1+F2*w2+w0;
        %error
        e = d(i) - y(i);
        %update weights
        w1 = w1 + m*e*F1;
        w2 = w2 + m*e*F2;
        w0 = w0 + m*e;
    end
    %average error
    e_average = immse(y,d);
        if (n == 10000)
            w0 = randn(1);
            w1 = randn(1);
            w2 = randn(1);
            n = 0;
        end    
end

%compare original and calculated graphs
figure;
plot(x, d, x, y, 'xr')
    