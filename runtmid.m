


clear,clc;
addpath data;
addpath src;
% !HSaliency ..\TMQI_SubejctiveTest\*.jpg ..\TMQI_SubejctiveTest\;
for i = 1:15 
    for j = 1:8
    ldrImage = imread(['..\TMQI_SubejctiveTest\',num2str(i),'\',num2str(j),'.jpg']);    
    hsImage = imread(['..\TMQI_SubejctiveTest\',num2str(i),'\',num2str(j)','_res.png']);
    feature = feature_extraction(ldrImage,hsImage);
    aparam(((i-1)*8+j),:)= feature;
    disp((i-1)*8+j); 
    end
end

save data/aparam.mat aparam



%% Iterative testing
clear,clc;

   P=ones(1,1000);
   S=ones(1,1000); 
   K=ones(1,1000);
   BC=ones(1,1000);
   BG=ones(1,1000);
   BP=ones(1,1000);
for i =1:1000
[po,s,k,rmse,bc,bg,bp] =  tmid_test();
   P(i)=po;
   S(i)=s;
   K(i)=k;
   RMSE(i)=rmse;
   BC(i)=bc;
   BG(i)=bg;
   BP(i)=bp;
   show_srcc_median = median(S)
   disp(i);
end
pm = median(P)
sm = median(S)
km = median(K)
rmsem = median(RMSE)
toc;



