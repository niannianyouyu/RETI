 function [grayscale] = IndexOfCg(Img)

 tem_val = stretchlim(Img);
 grayscale = [tem_val(2,1)  tem_val(1,1) tem_val(2,2)  tem_val(1,2) tem_val(2,3)  tem_val(1,3)];
 end