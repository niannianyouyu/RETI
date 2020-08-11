%% Feature extraction on images of the entire TMO database

clear
addpath data;
addpath src;
load TMO.mat
[m n ] = size(TMO);

for i = 1:m 
    str = char(table2array(TMO(i,1)));
    ldrImage = imread(['F:\ESPL_LIVE_HDR_Database\TMORES\',str]);
    [a]=strsplit(str,'.');
    a  = cell2table(a);
    a1 = a.a1;
    a2 = a.a2;
    a1 = table2array(a1);
    a2 = table2array(a2);
    str = [a1,'_res.',a2];
    iblImage = imread(['F:\ESPL_LIVE_HDR_Database\TMORES\',str]);
    feature1 = feature_extraction(ldrImage);
    feature2 = ibl_express(iblImage);
    feature = [feature1 feature2];
    para_tmo(i,:)= feature;
%     if(mod(i,10) ==0)
    disp(i);
    
end

save data/param_tmo.mat para_tmo

%% %% Iterative testing
   P=ones(1,1000);
   S=ones(1,1000);
   K=ones(1,1000);
for i =1:1000
[po,s,k] =  tmo_test();
   P(i)=po;
   S(i)=s;
   K(i)=k;
   showsrcc=median(S)
   disp(i);
end
pm = median(P)
sm = median(S)
km = median(K)
% delete(p);
% toc;