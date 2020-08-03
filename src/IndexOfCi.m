function [M] = IndexOfCi(Img)

hsv = rgb2hsv(Img);
H = double(hsv(:,:,1));
S = double(hsv(:,:,2));

M = [mean(H(:)) std(H(:)) mean(S(:)) std(S(:)) ];

LAB = rgb2lab(Img);

A = LAB(:,:,2);
B = LAB(:,:,3);
C = sqrt(A.*A + B.*B);

mu_A_sq = (mean2(A))^2;
mu_B_sq = (mean2(B))^2;
mu_ab  =sqrt(mu_A_sq + mu_B_sq);
mu_C = mean2(C);


sigma_A_sq = (std2(A))^2;
sigma_B_sq = (std2(B))^2;
sigma_ab  =sqrt(sigma_A_sq + sigma_B_sq);


Img = double(Img);
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
rg = R - G;
yb = 1/2*(R+G)-B;


mu_rg   = mean2(rg);
mu_yb   = mean2(yb);
mu_rg_sq = mu_rg.*mu_rg;
mu_yb_sq = mu_yb.*mu_yb;
sigma_rg_sq = (std2(rg))^2;
sigma_yb_sq = (std2(yb))^2;
mu_rgyb = sqrt(mu_rg_sq + mu_yb_sq);
sigma_rgyb  =sqrt(sigma_rg_sq + sigma_yb_sq);

M1 = sigma_ab +0.37*mu_ab;
M2 = sigma_ab +0.94*mu_C;
M3 = sigma_rgyb + 0.3*mu_rgyb;


M = [M M1 M2 M3];
M = M/100;

end