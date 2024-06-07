clc;
clear all;
close all;
warning off all;
%% NETWORK PARAMETER INITIALIZATION
N=100;
xm=100;
ym=100;
sink.x=0.5*xm;                 %location of sink on x-axis
sink.y=0.5*ym;                 %location of sink on y-axis
n=100;
P=0.1;                         %probability of cluster heads
Eo=0.5;                        %initial energy
Echeck=Eo;
ETX=50*0.000000001;            %tx energy
ERX=50*0.000000001;            %rx energy
Efs=10*0.000000000001;         %free space loss
Emp=0.0013*0.000000000001;     %multipath loss
EDA=5*0.000000001;             %compression energy
a=1.5;                         %fraction of energy enhancment of advance nodes
rmax=5000;                     %maximum number of rounds
do=sqrt(Efs/Emp);              %distance do is measured
Et=0; 
RU=[];                         
min1=0;
max11=400;
max1=200;
maxv=50;
minv=10;
vel=rand(1,N);
E=rand(1,N);
minTh=E/2;     
m=0.5;
mo=0.4;
b=3;
normal=n*(1-m);
advance=n*m*(1-mo);
monaysuper=n*m*mo;

%% CLUSTER FORMATION AND CH SELECTION
X = min1+(max11-min1)*rand(1,N);
Y = min1+(max1-min1)*rand(1,N);
Xb = max11+2+rand(1,1);
Yb =(max1+2)+rand(1,1);
tic
figure;
title('Network Area');
set(gcf,'Visible','On')
for i2 = 1:N 
          plot(X(i2),Y(i2),'o','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','b',...
                    'MarkerSize',8'); 
          xlabel('X in m')
          ylabel('Y in m')
          text(X(i2), Y(i2), num2str(i2),'FontSize',10); 
          hold on;
end
hold on
         plot(Xb,Yb,'s','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','y',...
                    'MarkerSize',12'); 
          xlabel('X in m')
          ylabel('Y in m')
          text(Xb, Yb, 'Sink','FontSize',10); 
          hold on;

zX=0:100:max11;
zY=0:100:max1;
id=zeros(1,N);
ik1=1;
for ik=1:numel(zX)-1
    for ij=1:numel(zY)-1
    points =[zX(ik) zY(ij); zX(ik)+100 zY(ij);  zX(ik)+100 zY(ij)+100 ;zX(ik) zY(ij)+100 ;zX(ik) zY(ij)]
    if(~isempty(RU))
        plot(RU(1),100,'^','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','g',...
                    'MarkerSize',11'); 
          xlabel('X in m')
          ylabel('Y in m')
          text(Xb, Yb, 'Base','FontSize',10); 
          hold on;
    end
    [in,on]=inpolygon(X,Y,points(:,1),points(:,2))
    ind=find(in==1);
     if(~isempty(RU))
         if(RU(1)>zX(ik) && RU(1)<zX(ik+1))
         ind=[];
         end
     else
 
    Ec=E(ind);      
    SN1=ind;
    SN(ik1).id=ind;
    L=0.*ind;
    [val1,ind2]=sort(Ec,'descend');
    MonitorID(ik1)=ind(ind2(1));
    ipd0=find(ind==ind(ind2(1)));
    L(ipd0)=1; 
    plot(X(MonitorID(ik1)),Y(MonitorID(ik1)),'o','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','g',...
                    'MarkerSize',10'); 
          xlabel('X in m')
          ylabel('Y in m')
          hold on;
    chmtosinkdist=abs(X(MonitorID(ik1))-Xb); 
    pc=distpch(chmtosinkdist);
    s1=ceil((pc/100)*numel(ind))
    SN(ik1).s1=s1;   
    pos1=[X(ind) Y(ind)];
    vel1=vel(ind);
    Bs=E(ind);
    [idx3,C,sumdist3,W]=MBE(X,Y,ind,ik,zX,ij,zY,vel1,Bs,s1);
    idx=unique(idx3);
    for ip=1:numel(idx)
        [ind3,val,ind2]=goldilocks(idx3,idx,ip,W,C);
        L((ind3(ind2(1))))=ip+1;       
       ind3(ind2(1))=[];
       L((ind3))=ip+1+0.1;         
    end
    SN(ik1).L=L;
    SN(ik1).Z=(ik1).*ones(1,numel(L));
     end
    L=[];
    ik1=ik1+1;
    hold on
    end
end
L1=[SN.L];
id1=[SN.id];
ind4=find(L1==1)
hold on
plot(X(id1(ind4)),Y(id1(ind4)),'o','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor','g',...
                      'MarkerSize',8'); 
            xlabel('X in m')
            ylabel('Y in m')
code=['r' 'm' 'y' 'k' 'c' 'w'];
for iv=2: max([SN.s1])
 ind5=find(round(L1)==iv)   
 ind6=find(L1==iv)   
hold on
plot(X(id1(ind5)),Y(id1(ind5)),'o','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',8'); 
            xlabel('X in m')
            ylabel('Y in m')       
hold on
plot(X(id1(ind6)),Y(id1(ind6)),'s','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',11'); 
            xlabel('X in m')
            ylabel('Y in m')            
end          
round=200;
delv=[5 10 20 30 ];
R=[80 100 130 160];
Az=2;
for iu=1:4
ik=1;
while(ik<=70)
for ik1=1:numel(zX)-1
end
    z1=[SN.Z];
    L1=[SN.L];
    id1=[SN.id];
    indw=find(mod(z1,2)==0)
    vel1=vel;
    vel1(id1(indw))=-vel(id1(indw));
    if(Az==1)
     X=X+delv(iu).*vel1   
    else
     X=X+delv(2).*vel1   
    end 
    X(X<-20)=400;
    X(X>420)=0; 
    code=['r' 'm' 'y' 'k' 'c' 'w'];
    for iv=2: max([SN.s1])
    ind5=find(floor(L1)==iv)   
    ind6=find(L1==iv)   
    hold on
    plot(X(id1(ind5)),Y(id1(ind5)),'o','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',8'); 
            xlabel('X in m')
            ylabel('Y in m')        
    hold on
    plot(X(id1(ind6)),Y(id1(ind6)),'s','LineWidth',1,...
        'MarkerEdgeColor','b',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',8');
    end
    
    %% PATH ESTIMATION

    A=randperm(N);
    path=[];
    L1=[SN.L];
    id1=[SN.id];
    z1=[SN.Z];
    A(1)
    indw=find(id1==A(1))
    Zo=z1(indw)
    Lz=SN(Zo).L;
    indb=find(Lz==floor(L1(indw)))
    path1=SN(Zo).L(indb)
    if(ik>20)
    x=[X' Y' vel' E'];
    tic
    tp1=toc  
    else
    tp1=1;
    indCH=(find(L1==1 | L1==2 |  L1==3 | L1 ==4 | L1==5 | L1==6 | L1==7));
    indCH=id1(indCH);
    indCH1=[indCH N+1]
    end
    X1=[X Xb];
    Y1=[Y Yb];
    hold on
    plot(X1(indCH1),Y1(indCH1),'s','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor','w',...
                      'MarkerSize',11'); 
            xlabel('X in m')
            ylabel('Y in m')  
            hold on
            for icc=1:numel(indCH1)
            text(X1(indCH1(icc)),Y1(indCH1(icc)),num2str(indCH1(icc)),'FontSize',10); 
            end
            hold on
           plot(X1(end),Y1(end),'s','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor','y',...
                      'MarkerSize',11'); 
            xlabel('X in m')
            ylabel('Y in m')  
   distCHtoCH=pdist2([X1(indCH1);Y1(indCH1)]',[X1(indCH1);Y1(indCH1)]') % CH to CH distance
   tr=distCHtoCH;
   if(Az==2)
   tr(distCHtoCH>(R(iu)))=inf;
   else
   tr(distCHtoCH>(R(3)))=inf;    
   end
   w1=tr;
   [r_path, r_cost] = Predictive(path1,size(tr,1), w1)
   [r_pathE, r_costE] = padovan(path1,size(tr,1), w1)
   indCH1(r_path)
   t_cost(ik)=r_cost;
   t_path{ik}=r_path;
   path=indCH1(r_path);
   for p =1:(length(path)-1) 
   line([X1(path(p)) X1(path(p+1))], [Y1(path(p)) Y1(path(p+1))], 'Color','m','LineWidth',2.5, 'LineStyle','-') 
   end 

      PDR(ik)= 0;
   if(~isempty(path))
        if(path(end)==61)
           PDR(ik)= 1;
        end      
   end
   
       E2E(ik)=numel(r_path);
       E2Ex(ik)=numel(r_pathE);
       CHF(ik)=tp1;
       CHFe(ik)=(2).*tp1;
    ik=ik+1; 
    pause(0.02);
    clf;
end

AvgPDR(iu)=sum(PDR)/ik;
E2E(isinf(E2E))=0;
E2Ex(isinf(E2Ex))=0;
E2Edelay(iu)=mean(E2E)
E2Edelaye(iu)=mean(E2Ex)
CHdelay(iu)=mean(CHF);
CHdelaye(iu)=mean(CHFe);
end

figure;
for i2 = 1:N 
    
          plot(X(i2),Y(i2),'o','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','r',...
                    'MarkerSize',8'); 
          xlabel('X in m')
          ylabel('Y in m')
          hold on;
end
hold on

         plot(Xb,Yb,'s','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','y',...
                    'MarkerSize',12'); 
          xlabel('X in m')
          ylabel('Y in m')
           hold on;
            
           plot(X(MonitorID(ik1)),Y(MonitorID(ik1)),'o','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','g',...
                    'MarkerSize',10'); 
          xlabel('X in m')
          ylabel('Y in m')
          text(Xb, Yb, 'Base','FontSize',10); 
          hold on;
          hold on
          
plot(X(id1(ind4)),Y(id1(ind4)),'o','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor','r',...
                      'MarkerSize',8'); 
            xlabel('X in m')
            ylabel('Y in m')
            text(X(id1(ind4)),Y(id1(ind4)), 'Base','FontSize',10); 
            
            hold on;
            
plot(X(id1(ind5)),Y(id1(ind5)),'o','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',8'); 
            xlabel('X in m')
            ylabel('Y in m')
  
            
hold on

plot(X(id1(ind6)),Y(id1(ind6)),'s','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',11'); 
            xlabel('X in m')
            ylabel('Y in m')   
            hold on;
             hold on;
             
    plot(X(id1(ind5)),Y(id1(ind5)),'o','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',8'); 
            xlabel('X in m')
            ylabel('Y in m')
 
    hold on
    
    plot(X(id1(ind6)),Y(id1(ind6)),'s','LineWidth',1,...
                 'MarkerEdgeColor','k',...
                      'MarkerFaceColor',code(iv-1),...
                      'MarkerSize',11'); 
             points =[zX(ik1) zY(ij); zX(ik1)+100 zY(ij);  zX(ik1)+100 zY(ij)+100 ;zX(ik1) zY(ij)+100 ;zX(ik1) zY(ij)]
             hold on;
              
    plot(X1(indCH1),Y1(indCH1),'s','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor','w',...
                      'MarkerSize',11'); 
            xlabel('X in m')
            ylabel('Y in m')  
            hold on
            for icc=1:numel(indCH1)
            text(X1(indCH1(icc)),Y1(indCH1(icc)),num2str(indCH1(icc)),'FontSize',10); 
            end
            hold on
           plot(X1(end),Y1(end),'s','LineWidth',1,...
                      'MarkerEdgeColor','k',...
                      'MarkerFaceColor','y',...
                      'MarkerSize',11'); 
            xlabel('X in m')
            ylabel('Y in m')   
            hold off
            title('Network nodes');
          
% if(Az==1)
toc
%% PERFORMANCE ANALYSIS
perfanalysis(xm,ym,n,P,Eo,Echeck,ETX,ERX,Efs,Emp,EDA,a,rmax,do,Et);

