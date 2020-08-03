 function [ar] = IndexOfAr(hsimg)


 
window = fspecial('gaussian', 3, 0.5);	
window = window/sum(sum(window));
%----------------------------------------------------
img1 = double(hsimg);
mu1   = filter2(window, img1, 'valid');
mu1_sq = mu1.*mu1;
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
sigma1 = sqrt(max(0, sigma1_sq));
% figure,imshow(sigma1)

ar = entropy(sigma1);
 end