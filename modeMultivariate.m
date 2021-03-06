%clc;
%clear;


s = rng;



%rng(s);
no_of_samples = 1000000+1000; %1000 for initial point selection.

std_store  = zeros(2,2);

for dist = 1:2
    if dist == 1
         mu=[20,15]';
         sigma=[3,2;2,3];
         samples = mvnrnd(mu,sigma,no_of_samples);

    elseif dist ==2
        
        samples = drchrnd([3 3],no_of_samples);  
    end

total_runs = 100;
store_modes = zeros(total_runs,2);

%s = rng;

%rng(s);

for run = 1:total_runs

    


% mu=[20,15]';
% sigma=[3,2;2,3];
% samples = mvnrnd(mu,sigma,no_of_samples);



%samples = random(pd,no_of_samples,1);
mode = mean(samples(1:1000));

epsilon=1.0;

%Robins-Munro starts


for i = 1001:no_of_samples
    
    %(-(mode-samples(i))^2/epsilon^2)
    %direction=(2*epsilon/pi)*(samples(i)-mode)/((epsilon^2+(mode-samples(i))^2)^2);
    %direction=exp(-(mode-samples(i))^2/(2*epsilon^2))*(-1/(epsilon^3*(2*pi)^0.5))*(mode-samples(i));
    direction=exp(-norm(mode-samples(i,:)')^2/epsilon)*(-2/(pi*epsilon^2))*(mode-samples(i,:)');
    %hessian=(2*epsilon/pi)*(3*(mode-samples(i))^2-epsilon^2)/((epsilon^2+(mode-samples(i))^2)^3);
    %hessian=max([0.01,hessian]);
    %hessian=1;
    
    
%     mode = mode + (c/count)*(direction);
    if i<0.9*no_of_samples
        mode = mode + (0.1)*(direction - (0.00001*mode));
 %       epsilon=epsilon*0.99999;
    else
        mode=mode+0.001*(direction- (0.00001*mode));
    end
   
end

store_modes(run,:) = mode;
%fprintf('\n %f \n',mode)

end
fprintf('\n %f %f \n',mean(store_modes),std(store_modes));
std_store(dist,:) = std(store_modes);


end
%actual_mode
%fprintf('\n %f %f\n',actual_median,median);

