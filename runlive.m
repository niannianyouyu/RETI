%% LIVE
tic;
clear
addpath data;
addpath src;
load LIVE_HDR_NAME.mat
[m n ] = size(name_char);

for i = 1:m 
    str = char(name_str(i,1));
    ldrImage = imread(['F:\ESPL_LIVE_HDR_Database\Images\',str]);
    [a]=strsplit(str,'.');
    a  = cell2table(a);
    a1 = a.a1;
    a2 = a.a2;
    a1 = table2array(a1);
    a2 = table2array(a2);
    str = [a1,'_res.',a2];
    iblImage = imread(['F:\ESPL_LIVE_HDR_Database\Images\',str]);
   
    feature1 = feature_extraction(ldrImage);
    feature2 = ibl_express(iblImage);
    feature = [feature1 feature2];
    para_live(i,:)= feature;
%     if(mod(i,10) ==0)
    disp(i);
    
end
save data/param_live.mat para_live


%% Iterative testing
clear,clc;

   P=ones(1,1000);
   S=ones(1,1000);
   K=ones(1,1000);
   BC=ones(1,1000);
   BG=ones(1,1000);
   BP=ones(1,1000);
for i =1:1000
[po,s,k,rmse,bc,bg,bp] =  runlive();
   P(i)=po;
   S(i)=s;
   K(i)=k;
   RMSE(i)=rmse;
   showsrcc = median(S)
   disp(i);
end
pm = median(P)
sm = median(S)
km = median(K)
Rm = median(RMSE)


toc;