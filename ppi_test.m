function [PLCC SROCC KROCC bestc bestg bestp] = ppi_test()
%%  Initialize and load data
% close all;
clear;
% clc;
format compact;
addpath data;
load Effects.mat Effects;
mos = table2array(Effects(:,2));
[m n ] = size(Effects);
load param_eff.mat para_eff;
div = 0.8;
div_num = round(div*m);
%%  Data preprocessing

[mos_map,psmap] = mapminmax(mos',0,100);
dmos2 = mos_map';

r=randperm(m);   
dmos_r = mos(r,: );        
param_r = para_eff(r,:);



% Separate training set and test set
train_x = param_r(1:div_num,:);
train_y = dmos_r(1:div_num,:);

test_x = param_r(div_num+1:end,:);
test_y = dmos_r(div_num+1:end,:);

train_y_scale = train_y;
test_y_scale  = test_y;

%%  Set the best c, g(p) parameters

bestp = 0.007;
bestc = 256;  bestg = 0.0825;%0.6522

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3  ',' -p ',num2str(bestp)];

%%  Train the model
model = svmtrain(train_y_scale, train_x,cmd);

%%  Predict the score
[ptest, test_mse,~] = svmpredict(test_y_scale,test_x, model);
%%  Inverse mapping + merging + calculating indicators
pred_mos_map = mapminmax('reverse',ptest',psmap);
pred_mos = pred_mos_map';

T_DATA=[ test_y pred_mos];

[RMSE PLCC] = calucc(T_DATA);
SROCC = corr(T_DATA(:,1), T_DATA(:,2), 'type', 'spearman');
KROCC = corr(T_DATA(:,1), T_DATA(:,2), 'type', 'kendall');
end

