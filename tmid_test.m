
function [PLCC SROCC KROCC RMSE bestc bestg bestp] = tmid_test()
%%  Initialize and load data
% close all;
tic
clear;
% clc;
format compact;
addpath data;
load dmos.mat dmos2;
load aparam.mat aparam;
div = 0.8;
div_num = round(div*120);
%%  Data preprocessing

% [mos_map,psmap] = mapminmax(dmos2',0,100);

r=randperm(120);  
dmos_r = dmos2(r,: );        
param_r = aparam(r,:);


% Separate training set and test set
train_x = param_r(1:div_num,:);
train_y = dmos_r(1:div_num,:);

[mos_map,psmap] = mapminmax(train_y',0,100);
train_y = mos_map';

test_x = param_r(div_num+1:end,:);
test_y = dmos_r(div_num+1:end,:);

train_y_scale = train_y;
test_y_scale  = test_y;


%%  Set the best c, g(p) parameters

bestc = 256;  bestg = 0.2895;

bestp = 0.007;

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3  ',' -p ',num2str(bestp)];

%%  Train the model
model = svmtrain(train_y_scale, train_x,cmd);
toc
tic
%%  Predict the score
[ptest, test_mse,~] = svmpredict(test_y_scale,test_x, model);
%%  Inverse mapping + merging + calculating indicators
pred_mos_map = mapminmax('reverse',ptest',psmap);
pred_mos = pred_mos_map';

T_DATA=[ test_y pred_mos];
toc

[RMSE PLCC] = calucc(T_DATA);
SROCC = corr(T_DATA(:,1), T_DATA(:,2), 'type', 'spearman');
KROCC = corr(T_DATA(:,1), T_DATA(:,2), 'type', 'kendall');
end

