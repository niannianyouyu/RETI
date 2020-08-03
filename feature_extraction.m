function [feature] = feature_extraction(Img,hsImg)
%---------- default parameters -----

AN = IndexOfAn(Img);
AP = IndexOfAp(Img);
AR = IndexOfAr(hsImg);


PI = IndexOfPi(Img);
PE = IndexOfPe(Img);

CI = IndexOfCi(Img);                   
CG = IndexOfCg(Img);
CD = IndexOfCd(Img);


% stable_feature;
Fa = [ AN AP AR ];
Fp = [ PI PE ];
Fs = [ CI CG CD ];
feature = [Fa Fp Fs  ];

end


