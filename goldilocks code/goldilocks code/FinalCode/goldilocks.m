function [ind3,val,ind2]=goldilocks(idx3,idx,ip,W,C)
 ind3= find(idx3==idx(ip));
 [val,ind2]= min(abs(W(ind3)-C(ip)))