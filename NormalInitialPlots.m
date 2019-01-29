%clc;
%clear;

s = rng;

%rng(s)

initial_modes = [5;10;15];

mode_storage = zeros(3,100000);

for init = 1:3

mode = initial_modes(init);
    
no_of_samples = 1000000; %1000 for initial point selection.


pd = makedist('Normal','mu',10,'sigma',5);


samples = random(pd,no_of_samples,1);

epsilon=1.0;

count = 2;
j = 1;

mode_storage(init,1) = mode;

%Robins-Munro starts


for i = 1:no_of_samples
    
    %(-(mode-samples(i))^2/epsilon^2)
    direction=(2*epsilon/pi)*(samples(i)-mode)/((epsilon^2+(mode-samples(i))^2)^2);
    %hessian=(2*epsilon/pi)*(3*(mode-samples(i))^2-epsilon^2)/((epsilon^2+(mode-samples(i))^2)^3);
    %hessian=max([0.01,hessian]);
    %hessian=1;
    
    
%     mode = mode + (c/count)*(direction);
    if i<0.9*no_of_samples
        mode = mode + (0.1)*(direction - (0.00001*mode));
 %       epsilon=epsilon*0.99999;
    else
        mode=mode+0.001*(direction - (0.00001*mode));
    end
   
   if i > 1000 && rem(i,j) ==0
       mode_storage(init,count) = mode;
       count = count+1;
   end
        
end

mode

end

hold off;
plot(mode_storage(1,1:50000))
hold on;
plot(mode_storage(2,1:50000))
hold on;
plot(mode_storage(3,1:50000))

%actual_mode
%fprintf('\n %f %f\n',actual_median,median);

