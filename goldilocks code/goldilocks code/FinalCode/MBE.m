function [idx3,C,sumdist3,W]=MBE(X,Y,ind,ik,zX,ij,zY,vel1,Bs,s1)

posd=pdist2([X(ind); Y(ind)]',[zX(ik)+50 zY(ij)+50]);
    w1=0.6;
    w2=0.2;
    w3=0.2;
    W=w1.*posd+w2.*vel1'+w3.*Bs';
    rng('default') 
    [idx3,C,sumdist3] = kmeans([X(ind)+W'; Y(ind)+W']',s1,'Distance','cityblock','Display','final');