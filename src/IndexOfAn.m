 function [N] = IndexOfAn(Img)

ImgYxy = RGBtoYxy(double(Img));
ImgYxy = double(ImgYxy(:,:,1));
N = StatisticalNaturalness(ImgYxy);
 end
 
 %============ Statistical Naturalness Measure ================

function [N] = StatisticalNaturalness(Img)
u = mean2(Img);
fun = @(x) std(x(:))*ones(size(x));
I1 = blkproc(Img,[11 11],fun);
sig = (mean2(I1));
%------------------ Contrast ----------
phat(1) = 4.4;
phat(2) = 10.1;
beta_mode = (phat(1) - 1)/(phat(1) + phat(2) - 2);
C_0 = betapdf(beta_mode, phat(1),phat(2));
C   = betapdf(sig./64.29,phat(1),phat(2));
pc = C./C_0;
%----------------  Brightness ---------
muhat = 115.94;
sigmahat = 27.99;
B = normpdf(u,muhat,sigmahat);
B_0 = normpdf(muhat,muhat,sigmahat);
pb = B./B_0;
%-------------------------------
N = pb*pc;
end

%%========================================================================
function [Yxy] = RGBtoYxy(RGB)
RGB = double(RGB);
M = [ 0.4124 0.3576 0.1805
      0.2126 0.7152 0.0722
      0.0193 0.1192 0.9505];

 RGB2 = reshape(RGB,size(RGB,1)*size(RGB,2),3);
 XYZ2 = M *  RGB2';
 S = sum(XYZ2);
 Yxy2 = zeros(size(XYZ2));
 Yxy2(1,:)=XYZ2(2,:);
 Yxy2(2,:)=XYZ2(1,:)./(S+eps);
 Yxy2(3,:)=XYZ2(2,:)./(S+eps);
 Yxy = reshape(Yxy2',size(RGB,1),size(RGB,2),3);
end