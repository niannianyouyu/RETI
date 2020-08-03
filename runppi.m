%% PPI

clear
tic
addpath data;
addpath src;
load Effects.mat
% p = parpool('local',4);
[m n ] = size(Effects);
for i = 1:m 
    str = char(table2array(Effects(i,1)));
    ldrImage = imread(['F:\ESPL_LIVE_HDR_Database\PPIRES\',str]);
    [a]=strsplit(str,'.');
    a  = cell2table(a);
    a1 = a.a1;
    a2 = a.a2;
    a1 = table2array(a1);
    a2 = table2array(a2);
    str = [a1,'_res.',a2];
    iblImage = imread(['F:\ESPL_LIVE_HDR_Database\PPIRES\',str]);
    feature1 = feature_extraction(ldrImage);
    feature2 = ibl_express(iblImage);
    feature = [feature1 feature2];
    para_eff(i,:)= feature;
%     if(mod(i,10) ==0)
    disp(i);
    
end
save data/param_eff.mat para_eff
toc



%% Iterative testing
   P=ones(1,1000);
   S=ones(1,1000);
   K=ones(1,1000);
for i =1:1000
[po,s,k,c,g,p] =  ppi_test();
   P(i)=po;
   S(i)=s;
   K(i)=k;
   C(i)=c;
   G(i)=g;
   P(i)=p;   
    msm = median(S)
    disp(i);
end
pm = median(P)
sm = median(S)
km = median(K)
cm = mode(C)
gm = mode(G)
pm = mode(P)
toc



