function [f] = IndexOfCd(img)


img = double(img);
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3); 

[final_peakc,cindex] = max([length(find(r==255)),length(find(g==255)),length(find(b==255))]);
rr = hist(r(:),256);
rrmax = max(rr);
gg = hist(g(:),256);
ggmax = max(gg);
bb = hist(b(:),256);
bbmax = max(bb);
all_peakc = max([rrmax ggmax bbmax]);
p1 = final_peakc/(all_peakc);
p2 = final_peakc/sum(rr);

hist_r = hist(r(:),256);
hist_g = hist(g(:),256);
hist_b = hist(b(:),256);

%% Reverse

ihist_r = fliplr(hist_r);
ihist_g = fliplr(hist_g);
ihist_b = fliplr(hist_b);



%% CDF

cdf_r=cumsum(ihist_r)/sum(ihist_r);
cdf_g=cumsum(ihist_g)/sum(ihist_g);
cdf_b=cumsum(ihist_b)/sum(ihist_b);
cc=[
cdf_r(1) cdf_r(25) cdf_r(50) cdf_r(75) cdf_r(100) cdf_r(125)  ;
cdf_g(1) cdf_g(25) cdf_g(50) cdf_g(75) cdf_g(100) cdf_g(125)  ;
cdf_b(1) cdf_b(25) cdf_b(50) cdf_b(75) cdf_b(100) cdf_b(125)  ;
];

ccmax = cc(cindex,:);
% ccc = ccmax-ccmin;
f = [ccmax  p1 p2];
% figure,
% plot(cdf_r,'r','LineWidth',1)
% hold on
% plot(cdf_g,'g','LineWidth',1)
% hold on
% plot(cdf_b,'b','LineWidth',1)
end