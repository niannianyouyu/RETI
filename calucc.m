function [RMSE corr_coef] = calucc(data)

ssimValues = data(:,1);
mos = data(:,2);

%plot objective-subjective score pairs
p = plot(ssimValues,mos,'+');
set(p,'Color','blue','LineWidth',1);

%initialize the parameters used by the nonlinear fitting function
beta(1) = max(mos);
beta(2) = min(mos);
beta(3) = mean(ssimValues);
beta(4) = 0.1;
beta(5) = 0.1;



%fitting a curve using the data
[bayta ehat,J] = nlinfit(ssimValues,mos,@logistic,beta);
%given a ssim value, predict the correspoing mos (ypre) using the fitted curve
[ypre junk] = nlpredci(@logistic,ssimValues,bayta,ehat,J);

RMSE = sqrt(sum((ypre - mos).^2) / length(mos));%root meas squared error

corr_coef = corr(mos, ypre, 'type','Pearson'); %pearson linear coefficient

%draw the fitted curve
% t = min(ssimValues):0.01:max(ssimValues);
% [ypre junk] = nlpredci(@logistic,t,bayta,ehat,J);
% hold on;
% p = plot(t,ypre);
% set(p,'Color','black','LineWidth',2);
% legend('Images in MICT','Curve fitted with logistic function', 'Location','NorthWest');
% xlabel('Objective score by SSIM');
% ylabel('MOS');

end

function [x_fit]= nonlinear_fit(x,y)
if corr(x,y,'type','Pearson')>0
    beta0(1) = max(y) - min(y);
else
    beta0(1) = min(y) - max(y);
end
beta0(2) = 1/std(x);
beta0(3) = mean(x);
beta0(4) = -1;
beta0(5) = mean(y);

beta = nlinfit(x,y,@logistic5,beta0);
x_fit = feval(@logistic5, beta, x);
end
