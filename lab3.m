%approximation 
clear all;
close all;

x = 0.1:1/22:1; %input values
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2; %desired response
m = 0.15; %learning rate
X = x;
Y = d;


%choose weights, centers, radius
w0 = rand(1);
w1 = rand(1);
w2 = rand(1);

c1_x = 2.5;
c1_y = 1.75;
r1 = 4;

c2_x = 2;
c2_y = 3.50;
r2 = 3;

    for epoch = 1:10000
        for n = 1:length(x)
        %radial basis f(x) response, using Gauss f(x)
        F1 = exp(-( ((X(n)-c1_x)^2 + (Y(n)-c1_y)^2)/(2*r1^2) ));
        F2 = exp(-( ((X(n)-c2_x)^2 + (Y(n)-c2_y)^2)/(2*r2^2) ));

        %net response 
        y(n) = F1*w1 +F2*w2 + w0;
       
        %error calculation
        e = d(n) - y(n);

        %weight update
        w1 = w1 + m*e*X(n);
        w2 = w2 + m*e*Y(n);
        w0 = w0 + m*e;
        end   
    end
    
%compare original and calculated graphs
figure;
plot(x, d, x, y, 'xr')
    