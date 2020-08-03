function [LBPHIST] = IndexOfPe(img)

      [CE_gray,CE_by,CE_rg ] = CE11(img);
      MAPPING=getmapping(8,'riu2');
      GLBPHIST=lbp(CE_gray,2,8,MAPPING,'hist');
      BYLBPHIST=lbp(CE_by,2,8,MAPPING,'hist');
      RGLBPHIST=lbp(CE_rg,2,8,MAPPING,'hist');
      LBPHIST = [GLBPHIST/sum(GLBPHIST)  BYLBPHIST/sum(BYLBPHIST) RGLBPHIST/sum(RGLBPHIST)];
end
