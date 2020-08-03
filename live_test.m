function [PLCC SROCC KROCC RMSE bestc bestg bestp] = live_test()
%%  Initialize and load data% close all;
clear;
% clc;
format compact;
addpath data;
addpath src;
load LIVE_MOS_SD.mat;
mos = table2array(LIVE_MOS_SD(:,2));
[m n ] = size(LIVE_MOS_SD);
load param_live.mat para_live;
div = 0.8;
div_num = round(div*m);
%%  Data preprocessing

[mos_map,psmap] = mapminmax(mos',0,100);
dmos2 = mos_map';

r=randperm(m);   
dmos_r = mos(r,: );        
param_r = para_live(r,:);

% Separate training set and test set
train_x = param_r(1:div_num,:);
train_y = dmos_r(1:div_num,:);

test_x = param_r(div_num+1:end,:);
test_y = dmos_r(div_num+1:end,:);

train_y_scale = train_y;
test_y_scale  = test_y;

%%  Set the best c, g(p) parameters

bestc = 256;  bestg = 0.1895;
bestp = 0.007;
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

