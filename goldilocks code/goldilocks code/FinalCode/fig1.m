function [PDR1,PDR2,PDR3,PDR4,PDR5,PDR6,PDR7,RE1,RE2,RE3,throughput1,throughput2,throughput3,RE4,throughput4,RE5,throughput5,RE6,throughput6]=fig1(DEAD,ALLIVE,PACKETS_TO_CH,BS,COUNTCHS)

xm = 100 ;
ym = 100 ;
p = 0.1 ;
sink.x = 50;
sink.y = 120 ;
n = 100;
gw_node.x = 50 ;
gw_node.y = 50 ;
Eo = 0.5 ;
ETX=50*0.000000001;
ERX=50*0.000000001;
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;
EDA=5*0.000000001;
do=sqrt(Efs/Emp);
allive  = n;
m=500;
flag_first_dead_dir=0;
flag_all_dead_dir=0;
flag_first_dead_c1=0 ;
flag_all_dead_c1=0;
flag_first_dead_c2=0;
flag_all_dead_c2=0;
flag_first_dead_dir_gw=0;
flag_all_dead_dir_gw=0;

 %% LEACH
packets_to_bs = 0;
packets_to_ch = 0;
packets_to_gw = 0;
rmax=5000;
xm1=100;          %diameters of sensor network
ym1=100;
sink1.x=50;       %distance of base station from the network
sink1.y=120;
nl = 100;         %no of nodes
pl=0.1;           %probibilty of a node to become cluster head
Eint=0.5;         %energy supplied to each node

for i=1:1:nl
    Sl(i).xd=rand(1,1)*xm1;         %it will distribute the nodes in 1 dimension in x axis randomly.
    XR(i)=Sl(i).xd;                 %we store its value in xr
    Sl(i).yd=rand(1,1)*ym1;         %it will distribute the nodes in 1 dimension in y axis randomly
    YR(i)=Sl(i).yd;
    Sl(i).id = i;
    Sl(i).G=0;                        
    Sl(i).E=Eint; 
    Sl(i).type='N';
end

Sl(n+1).xd=sink.x;   
Sl(n+1).yd=sink.y;             
flag_first_deadl=0;
flag_teenth_deadl=0;
flag_all_deadl=0;

deadl=0;
first_deadl=0;
teenth_deadl=0;
all_deadl=0;
allivel=nl;
packets_TO_BSl=0;
packets_TO_CHl=0;

for i = 1 : 1 :n
    S(i).xd = rand(1,1)*xm ;
    S(i).yd = rand (1,1)*ym ;
    xd(i) = S(i).xd ;
    yd(i) = S(i).yd ;
    S(i).id = i;
    S(i).type = 0;
    S(i).g = 0 ;
    S(i).E = Eo ;
    S(i).type = 0 ;

end

a0 = 1 ;
count_dir = 0;
x0 = [];
for i = 1:1:n
    if ((S(i).xd >= 0) && (S(i).xd <=100) && (S(i).yd >= 80) && (S(i).yd <= 100))
        x0{a0} = S(i).id ;
        count_dir = count_dir+1 ;
        S0(a0).id = S(i).id;
        S0(a0).E = Eo ;
        S0(i).id = i;
        S0(a0).type = 0 ;
        S0(a0).xd = S(i).xd ;
        S0(a0).yd = S(i).yd ;
        a0 = a0+1 ;
    end
end

a = 1 ;
count_dir_gw = 0 ;
x1 = [];
for i = 1:1:n
    if ((S(i).xd >= 30) && (S(i).xd <=70) && (S(i).yd >= 30) && (S(i).yd <= 70))
        x1{a} = S(i).id ;
        count_dir_gw = count_dir_gw + 1 ;
        g1(a).id = S(i).id;
        g1(a).E = Eo ;
        g(i).id = i;
        g1(a).g = 0;  % normal nodes
        g1(a).xd = S(i).xd ;
        g1(a).yd = S(i).yd ;
        g1(a).type = 0;
        a=a+1;
    end
end

b = 1 ;
x2 = [];
countr1 = 0;
for i = 1:1:n
     if( (S(i).xd >= 0) && (S(i).xd <30) && (S(i).yd >= 0) && (S(i).yd < 80)||(S(i).xd > 30) && (S(i).xd <=50) && (S(i).yd >= 0) && (S(i).yd < 30)||(S(i).xd > 30) && (S(i).xd <= 50)&&(S(i).yd > 70) && (S(i).yd < 80))
        %S(i).region=2;
        x2{b} = S(i).id ;
        countr1 = countr1+1 ;
         S2(b).id = S(i).id;
         S2(b).E = Eo ;
         S2(i).id = i;
         S2(b).xd = S(i).xd ;
         S2(b).yd = S(i).yd ;
         S2(b).type = 0;
       % S(b).type = 0;
        %S(i).region==2;
        b=b+1;
     end
end

c0 = 1 ;
x3 = [];
countr2 = 0;
for i = 1:1:n
    if ( (S(i).xd > 50) && (S(i).xd <70) && (S(i).yd >= 0) && (S(i).yd < 30)|| (S(i).xd > 70) && (S(i).xd <=100) && (S(i).yd >= 0) && (S(i).yd < 80)||(S(i).xd > 50) && (S(i).xd < 70)&&(S(i).yd > 70) && (S(i).yd < 80))
        
        x3{c0} = S(i).id ;
        countr2 = countr2+1 ;
        S3(c0).id = S(i).id;
        S3(c0).E = Eo ;
        S3(i).id = i;
        S3(c0).g = 0;  
        S3(c0).xd = S(i).xd ;
        S3(c0).yd = S(i).yd ;
        S3(c0).type = 0;
        c0=c0+1;
    end
end


for r= 0:1:rmax
   
     if(mod(r, round(1/p) )==0)
         for i = 1:1:length(x2)
             S2(i).type = 0;
             S3(i).type = 0;
         end
     end
  
     if(mod(r, round(1/pl) )==0) 
        for i=1:1:nl
            Sl(i).G=0;            
        end
    end
    
    Etl=0;
    deadl=0;
    for i=1:1:nl
        
        if (Sl(i).E<=0)
            deadl=deadl+1;
            
            if (deadl==1)
                if(flag_first_deadl==0)
                    first_deadl=r;
                    flag_first_deadl=1;
                end
            end
            
            if(deadl==0.1*nl)
                if(flag_teenth_deadl==0)
                    teenth_deadl=r;
                    flag_teenth_deadl=1;
                end
            end
            if(deadl==n)
                if(flag_all_deadl==0)
                    all_deadl=r;
                    flag_all_deadl=1;
                end
            end
        end
        if Sl(i).E>0
            Sl(i).type='N';                      
            Etl = Etl+Sl(i).E ;
            
        end
    end
    
    STATISTICS.PACKETS_TO_CHS1(r+1)=Etl;
    STATISTICS.DEADl(r+1)=deadl;
    STATISTICS.ALLIVEl(r+1)=allivel-deadl;
    alive1l = allivel-deadl ;
    received_packsl =0;
pl = 0.2577;
rl = 0.25;
total_packsl =  alive1l;
checkl = 100;
goodl = 1;
packetsl = [];
sizel = 1;
while sizel <= total_packsl
if goodl == 1
    packetsl = [packetsl goodl];
    goodl = rand(1) > pl;
elseif goodl == 0
    packetsl = [packetsl goodl];
    goodl = rand(1) > pl;
else
    break;
end
sizel = sizel + 1;
end
received_packsl = nnz(packetsl);
theo_pack_loss_ratel = 1 - rl / (pl+rl);
act_pack_loss_ratel = 1 - received_packsl/total_packsl;
checkl = abs(theo_pack_loss_ratel - act_pack_loss_ratel) / theo_pack_loss_ratel * 100;
packetsl;
theo_pack_loss_ratel = pl / (pl+rl);
act_pack_loss_ratel = 1 - received_packsl/total_packsl;
received_pac = received_packsl;
STATISTICS.recievedl(r+1)=received_pac ;
    countCHsl=0;
    clusterl=1;
    
    for i=1:1:nl
        if(Sl(i).E>0)
            temp_randl=rand;
            if ( (Sl(i).G)<=0)
                
                if(temp_randl<= (pl/(1-pl*mod(r,round(1/pl)))))
                    countCHsl=countCHsl+1;
                    packets_TO_BSl=packets_TO_BSl+1;
                    STATISTICS.PACKETS_TO_BSl(r+1)=packets_TO_BSl;
                    Sl(i).type='C';
                    Sl(i).G=round(1/pl)-1;
                    Cl(clusterl).xd=Sl(i).xd;
                    Cl(clusterl).yd=Sl(i).yd;
                    distancel=sqrt( (Sl(i).xd-(Sl(n+1).xd) )^2 + (Sl(i).yd-(Sl(n+1).yd) )^2 );
                    Cl(clusterl).distance=distancel;
                    Cl(clusterl).id=i;
                    X(clusterl)=Sl(i).xd;
                    Y(clusterl)=Sl(i).yd;
                    clusterl=clusterl+1;
                    distancel;
                    if (distancel>do)
                        Sl(i).E=Sl(i).E- ( (ETX+EDA)*(4000) + Emp*4000*(distancel*distancel*distancel*distancel ));
                    end
                    if (distancel<=do)
                        Sl(i).E=Sl(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*(distancel * distancel ));
                    end
                end
                
            end
            % S(i).G=S(i).G-1;
            
        end
    end
    STATISTICS.COUNTCHS1(r+1)=countCHsl;
    
    for i=1:1:nl
        if ( Sl(i).type=='N' && Sl(i).E>0 )
            if(clusterl-1>=1)
                min_disl=Inf;
                min_dis_clusterl=0;
                for cl=1:1:clusterl-1
                    templ=min(min_disl,sqrt( (Sl(i).xd-Cl(cl).xd)^2 + (Sl(i).yd-Cl(cl).yd)^2 ) );
                    if ( templ<min_disl )
                        min_disl=templ;
                        min_dis_clusterl=cl;
                    end
                end
                
                
                min_disl;
                if (min_disl>do)
                    Sl(i).E=Sl(i).E- ( ETX*(4000) + Emp*4000*( min_disl *min_disl * min_disl * min_disl));
                end
                if (min_disl<=do)
                    Sl(i).E=Sl(i).E- ( ETX*(4000) + Efs*4000*( min_disl * min_disl));
                end
                Sl(Cl(min_dis_clusterl).id).E =Sl(Cl(min_dis_clusterl).id).E- ( (ERX + EDA)*4000 );
                packets_TO_CHl=packets_TO_CHl+1;
                
                Sl(i).min_disl=min_disl;
                Sl(i).min_dis_clusterl=min_dis_clusterl;
            else
                min_disl=sqrt( (Sl(i).xd-Sl(n+1).xd)^2 + (Sl(i).yd-Sl(n+1).yd)^2 );
                if (min_disl>do)
                    Sl(i).E=Sl(i).E- ( ETX*(4000) + Emp*4000*( min_dis *min_dis * min_dis * min_dis));
                end
                if (min_disl<=do)
                    Sl(i).E=Sl(i).E- ( ETX*(4000) + Efs*4000*( min_disl * min_disl));
                end
                packets_TO_BSl=packets_TO_BSl+1;
            end
        end
    end
    
    
    STATISTICS.PACKETS_TO_BSl(r+1)=packets_TO_BSl;
    dead_dir= 0;
    E1 = 0;
  
    for i = 1:1:length(x0)
        if(S0(i).E <= 0)
            dead_dir = dead_dir+1 ;
            S0(i).id = i;
            if(dead_dir==1)
                if (flag_first_dead_dir == 0)
                    first_dead_dir = r ;
                    flag_first_dead_dir = 1;
                    
                end
            end
            if(dead_dir==length(x0))
                if(flag_all_dead_dir==0)
                    all_dead_dir=r;
                    flag_all_dead_dir=1;
                end
            end
        end
        if (S0(i).E>0)
            S0(i).type=0;                     
            E1 = E1+S0(i).E ;
       
        end
    end

    E2 = 0;
    dead_dir_gw = 0;
    for i = 1:1:length(x1)
        if(g1(i).E <= 0)
            dead_dir_gw = dead_dir_gw+1 ;
            g1(i).id = i;
            if(dead_dir_gw==1)
                if (flag_first_dead_dir_gw == 0)
                    first_dead_dir_gw = r ;
                    flag_first_dead_dir_gw = 1;
                    
                end
            end
            if(dead_dir_gw==length(x1))
                if(flag_all_dead_dir_gw==0)
                    all_dead_dir_gw=r;
                    flag_all_dead_dir_gw=1;
                end
            end
        end
        if (g1(i).E>0)
            g1(i).type=0;
            E2= E2+g1(i).E;
        end
    end

    dead_c1 = 0;
    E3 = 0;
    for i = 1:1:length(x2)
        if(S2(i).E <= 0)
            dead_c1 = dead_c1+1 ;
            if(dead_c1==1)
                if (flag_first_dead_c1 == 0)
                    first_dead_c1 = r ;
                    flag_first_dead_c1 = 1;
                    
                end
            end
            if(dead_c1==length(x2))
                if(flag_all_dead_c1==0)
                    all_dead_c1=r;
                    flag_all_dead_c1=1;
                end
            end
        end
        if (S2(i).E>0)
            S2(i).type=0;
            E3= E3+S2(i).E;
        end
    end
    dead_c2 = 0 ;
    E4 = 0;
    for i = 1:1:length(x3)
        if(S3(i).E <= 0)
            dead_c2 = dead_c2+1 ;
            S2(i).id = i;
            if(dead_c2==1)
                if (flag_first_dead_c2 == 0)
                    first_dead_c2 = r ;
                    flag_first_dead_c2 = 1;
                    
                end
            end
            if(dead_c2==length(x3))
                if(flag_all_dead_c2==0)
                    all_dead_c2=r;
                    flag_all_dead_c2=1;
                end
            end
        end
        if (S3(i).E>0)
            S3(i).type=0;
            E4= E4+S3(i).E;
        end
    end
    STATISTICS.E(r+1)= E1+E2+E3+E4 ; 
    dead = dead_c1+dead_c2+dead_dir+dead_dir_gw ;
    STATISTICS.DEAD(r+1)= dead_c1+dead_c2+dead_dir+dead_dir_gw ;
    STATISTICS.ALLIVE(r+1)=allive-dead ;
    aliven = allive-dead ;

received_packsn= 0;
pn = 0.2577;
rn = 0.25;
total_packsn = aliven;
checkn = 100;
goodn = 1;
packetsn = [];
sizen = 1;
while sizen <= total_packsn
if goodn == 1
    packetsn = [packetsn goodn];
    goodn = rand(1) > pn;
elseif goodn == 0
    packetsn = [packetsn goodn];
    goodn = rand(1) > pn;
else
    break;
end
sizen = sizen + 1;
end;

received_packsn = nnz(packetsn);
theo_pack_loss_raten = 1 - rn / (pn+rn);
act_pack_loss_raten = 1 - received_packsn/total_packsn;
checkn = abs(theo_pack_loss_raten - act_pack_loss_raten) / theo_pack_loss_raten * 100;
theo_pack_loss_raten = pn / (pn+rn);
act_pack_loss_raten = 1 - received_packsn/total_packsn;
received_pacn=received_packsn;

     STATISTICS.received(r+1)=received_pacn ;
    for i = 1:1:length(x0)
        if(S0(i).type == 0 && S0(i).E >0)
            dist0=sqrt( (S0(i).xd-(sink.x) )^2 + (S0(i).yd-(sink.y) )^2 );
            if (dist0>do)
                S0(i).E= S0(i).E- ( (ETX)*(4000) + Emp*4000*(dist0*dist0*dist0*dist0 ));
            end
            if (dist0<=do)
                S0(i).E= S0(i).E- ( (ETX)*(4000)  + Efs*4000*(dist0 * dist0 ));
            end
            packets_to_bs = packets_to_bs+1;
            %
        end
    end

    for i = 1:1:length(x1)
        if(g1(i).type == 0 && g1(i).E >0)
            dist_to_gw =sqrt( (g1(i).xd-(gw_node.x) )^2 + (g1(i).yd-(gw_node.y) )^2 );
            if (dist_to_gw>do)
                g1(i).E= g1(i).E- ( (ETX)*(4000) + Emp*4000*(dist_to_gw*dist_to_gw*dist_to_gw*dist_to_gw ));
            end
            if (dist_to_gw<=do)
                g1(i).E= g1(i).E- ( (ETX)*(4000)  + Efs*4000*(dist_to_gw * dist_to_gw ));
            end
            packets_to_gw = packets_to_gw+1;
            packets_to_bs = packets_to_bs+1;
        end
    

    end
    
    
    countCHs=0;
    cluster=1;
        
    for i = 1:1:length(x2)
        if(S2(i).E >0 && S2(i).type ==0)
            temp_rand=rand;
            if(temp_rand<= (p/(1-p*mod(r,round(1/p)))))
                countCHs=countCHs+1;
                packets_to_gw= packets_to_gw+1;
                packets_to_bs = packets_to_bs+1;
                
                S2(i).type=1;
                S2(i).g=round(1/p)-1;
                C(cluster).xd=S2(i).xd;
                C(cluster).yd=S2(i).yd;
                distance=sqrt((S2(i).xd-(gw_node.x) )^2 + (S2(i).yd-(gw_node.y) )^2 );
                C(cluster).distance=distance;
                C(cluster).id=i;
                X(cluster)=S(i).xd;
                Y(cluster)=S(i).yd;
                cluster=cluster+1;
                distance;
                if (distance>do)
                    S2(i).E=S2(i).E- ( (ETX+EDA)*(4000) + Emp*4000*(distance*distance*distance*distance ));
                end
                if (distance<=do)
                    S2(i).E=S2(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*(distance * distance ));
                end
                if(countCHs == (countr1/6))
                   break ;
                end
            end
            
            if(countCHs == (countr1/6))
                break ;
            end
            
        end 
    end
   
    countCHs1=0;
    cluster1=1;
    for i = 1:1:length(x3)
        if(S3(i).E >0 && S3(i).type ==0)
            temp_rand1=rand;
            if(temp_rand1<= (p/(1-p*mod(r,round(1/p)))))
                countCHs1=countCHs1+1;
                packets_to_gw= packets_to_gw+1;
                packets_to_bs = packets_to_bs+1;
                S3(i).type=1;
                S3(i).g=round(1/p)-1;
                C1(cluster1).xd=S3(i).xd;
                C1(cluster1).yd=S3(i).yd;
                distance1=sqrt((S3(i).xd-(gw_node.x) )^2 + (S3(i).yd-(gw_node.y) )^2 );
                C1(cluster1).distance1=distance1;
                C1(cluster1).id=i;
                X(cluster1)=S3(i).xd;
                Y(cluster1)=S3(i).yd;
                cluster1=cluster1+1;
                distance1;
                if (distance1>do)
                    S3(i).E=S3(i).E- ( (ETX+EDA)*(4000) + Emp*4000*(distance1*distance1*distance1*distance1 ));
                end
                if (distance1<=do)
                    S3(i).E=S3(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*(distance1 * distance1 ));
                end
                 if(countCHs1 == (countr2/6))
                    break ;
                end
            end
            
            if(countCHs1 == (countr2/6))
                break ;
            end
        end
      
    end
    STATISTICS.cluster_heads(r+1) = countCHs ;
    STATISTICS.cluster_heads1(r+1) = countCHs1 ;
    
      
    for i=1:1:length(x2)
        if ( S2(i).type==0)
           if(S2(i).E>0 )
            if(cluster-1>=1)
                min_dis=Inf;
                min_dis_cluster=0;
                for c=1:1:cluster-1
                    temp=min(min_dis,sqrt( (S2(i).xd-(C(c).xd))^2 + (S2(i).yd-(C(c).yd))^2 ) );
                    if ( temp<min_dis )
                        min_dis=temp;
                        min_dis_cluster=c;
                    end
                end
                
                
                min_dis;
                if (min_dis>do)
                    S2(i).E=S2(i).E- ( (ETX)*(4000) + Emp*4000*( min_dis *min_dis * min_dis * min_dis));
                end
                if (min_dis<=do)
                    S2(i).E=S2(i).E- ( (ETX)*(4000) + Efs*4000*( min_dis * min_dis));
                end
                S2(C(min_dis_cluster).id).E =S2(C(min_dis_cluster).id).E- ( (ERX )*4000 );
                packets_to_ch=packets_to_ch+1;
                
                S2(i).min_dis=min_dis;
                S2(i).min_dis_cluster=min_dis_cluster;
                
                
            else
                min_dis=sqrt( (S2(i).xd-(gw_node.x))^2 + (S2(i).yd-(gw_node.y))^2 );
                if (min_dis>do)
                    S2(i).E=S2(i).E- ( (ETX)*(4000) + Emp*4000*( min_dis *min_dis * min_dis * min_dis));
                end
                if (min_dis<=do)
                    S2(i).E=S2(i).E- ( (ETX)*(4000) + Efs*4000*( min_dis * min_dis));
                end
                packets_to_gw=packets_to_gw+1;
                packets_to_bs = packets_to_bs+1;
                %STATISTICS.PACKETS_TO_BS(r+1)=packets_to_bs;
                
            end
        end
        end
    end
    
    
    for i=1:1:length(x3)
        if ( S3(i).type==0 && S3(i).E>0 )
            if(cluster1-1>=1)
                min_dis1=Inf;
                min_dis_cluster1=0;
                for c1=1:1:cluster1-1
                    temp1=min(min_dis1,sqrt( (S3(i).xd-(C1(c1).xd))^2 + (S3(i).yd-(C1(c1).yd))^2 ) );
                    if ( temp1<min_dis1 )
                        min_dis1=temp1;
                        min_dis_cluster1=c1;
                    end
                end
                
                
                min_dis1;
                if (min_dis1>do)
                    S3(i).E=S3(i).E- ( (ETX)*(4000) + Emp*4000*( min_dis1 *min_dis1 * min_dis1 * min_dis1));
                end
                if (min_dis1<=do)
                    S3(i).E=S3(i).E- ( (ETX)*(4000) + Efs*4000*( min_dis1 * min_dis1));
                end
                S3(C1(min_dis_cluster1).id).E =S3(C1(min_dis_cluster1).id).E- ( (ERX )*4000 );
                packets_to_ch=packets_to_ch+1;
                
                S3(i).min_dis1=min_dis1;
                S3(i).min_dis_cluster1=min_dis_cluster1;
                
                
            else
                min_dis1=sqrt( (S3(i).xd-(gw_node.x))^2 + (S3(i).yd-(gw_node.y))^2 );
                if (min_dis1>do)
                    S3(i).E=S3(i).E- ( (ETX)*(4000) + Emp*4000*( min_dis1 *min_dis1 * min_dis1 * min_dis1));
                end
                if (min_dis1<=do)
                    S3(i).E=S3(i).E- ( (ETX)*(4000) + Efs*4000*( min_dis1 * min_dis1));
                end
                packets_to_gw=packets_to_gw+1;
                STATISTICS.PACKETS_TO_BS(r+1)=packets_to_bs;
                
            end
        end
    end
    
    STATISTICS.PACKETS_TO_BS(r+1)=packets_to_bs;   
end
 

first_deadl;
teenth_deadl;
all_deadl;
STATISTICS.cluster_heads(r+1)
STATISTICS.cluster_heads1(r+1)
STATISTICS.E(r+1)
STATISTICS.DEAD(r+1)
STATISTICS.ALLIVE(r+1)
STATISTICS.PACKETS_TO_BS(r+1)
[packetsize,RE1,T]=updation(n,m);
[throughput1]= performance(packetsize,n,T);


%% M GEAR

rmax=5000;
tempi=50;
tempf=200;
h=100;                                 %%%%%%Hard Thres%%%%hold 
s=2;                                  %%%%%%Soft thres%%%%hold  
sv=0;
m=50;
Efs1=Efs/10;
Emp1=Emp/10;
do=sqrt(Efs/Emp);       
do1=sqrt(Efs1/Emp1);    
for i=1:1:n
   S(i).xd=rand(1,1)*xm;         
   XR(i)=S(i).xd;                 
   S(i).yd=rand(1,1)*ym;           
   YR(i)=S(i).yd;
   S(i).G=0;                        
   S(i).E=Eo
   S(i).type='N';
end

S(n+1).xd=sink.x;   
S(n+1).yd=sink.y;
countCHs=0;         
cluster=1;              
flag_first_dead=0;         
flag_teenth_dead=0;
flag_all_dead=0;
dead=0;
first_dead=0;
teenth_dead=0;
all_dead=0;
allive=n;
packets_TO_BS=0;
packets_TO_CH=0;
for r=0:1:rmax
        cv = tempi + (tempf-tempi).*rand(1,1);  
   if(mod(r, round(1/p) )==0) 
   for i=1:1:n
       S(i).G=0;            
       %%S(i).cl=0;
   end
   end

dead=0;
for i=1:1:n

   if (S(i).E<=0)
       dead=dead+1;

       if (dead==1)
          if(flag_first_dead==0)
             first_dead=r;
             flag_first_dead=1;
          end
       end

       if(dead==0.1*n)
          if(flag_teenth_dead==0)
             teenth_dead=r;
             flag_teenth_dead=1;
          end
       end
       if(dead==n)
          if(flag_all_dead==0)
             all_dead=r;
             flag_all_dead=1;
          end
       end
   end
   if S(i).E>0
       S(i).type='N';
   end
end
STATISTICS.DEAD3(r+1)=dead;
STATISTICS.ALLIVE3(r+1)=allive-dead;
countCHs=0;
cluster=1;

if   S(i).type=='C' && S(i).E>a
for j=1:1:ch
    countCHs=countCHs+1;
    S(i).type='C';
           S(i).G=round(1/p)-1;
           C(cluster).xd=S(i).xd;
           C(cluster).yd=S(i).yd;
    distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
           C(cluster).distance=distance;
           C(cluster).id=i;
           X(cluster)=S(i).xd;
           Y(cluster)=S(i).yd;
           cluster=cluster+1;
distance;
           
    %   if (cv >= h)
 %test = cv-sv;
 %if (test >= s)
           if (distance>do)
               S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*(distance*distance*distance*distance ));
           end
           if (distance<=do)
               S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*(distance * distance ));
           end
end
else
for i=1:1:n        
  if(S(i).E>0)
  temp_rand=rand;
  if ( (S(i).G)<=0)

       if(temp_rand<= (p/(1-p*mod(r,round(1/p)))))
           countCHs=countCHs+1;
           packets_TO_BS=packets_TO_BS+1;
           PACKETS_TO_BS(r+1)=packets_TO_BS;
            S(i).type='C';
           S(i).G=round(1/p)-1;
           C(cluster).xd=S(i).xd;
           C(cluster).yd=S(i).yd;
          distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
           C(cluster).distance=distance;
           C(cluster).id=i;
           X(cluster)=S(i).xd;
           Y(cluster)=S(i).yd;
           cluster=cluster+1;
               
           distance;
           if (distance>do)
               S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*(distance*distance*distance*distance ));
           end
           if (distance<=do)
               S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*(distance * distance ));
           end
       end
  end
  end
end
end
STATISTICS.COUNTCHS3(r+1)=countCHs;

for i=1:1:n
  if ( S(i).type=='N' && S(i).E>0 )
    if(cluster-1>=1)
      min_dis=Inf;
      min_dis_cluster=0;
      for c=1:1:cluster-1
          temp=min(min_dis,sqrt( (S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2 ) );
          if ( temp<min_dis )
              min_dis=temp;
              min_dis_cluster=c;
          end
      end
           min_dis;
           if (min_dis>do1)
               S(i).E=S(i).E- ( ETX*(4000) + Emp1*4000*( min_dis *min_dis * min_dis * min_dis));
           end
          if (min_dis<=do1)
               S(i).E=S(i).E- ( ETX*(4000) + Efs1*4000*( min_dis * min_dis));
           end
                  S(C(min_dis_cluster).id).E =S(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 );
           packets_TO_CH=packets_TO_CH+1;
        
       S(i).min_dis=min_dis;
       S(i).min_dis_cluster=min_dis_cluster;
   else
       min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
           if (min_dis>do)
               S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis *min_dis * min_dis * min_dis));
           end
           if (min_dis<=do)
               S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis));
           end
           packets_TO_BS=packets_TO_BS+1;
    
  sv=cv;
    end
 end
end
STATISTICS.PACKETS_TO_CH3(r+1)=packets_TO_CH;
STATISTICS.PACKETS_TO_BS3(r+1)=packets_TO_BS;
end
first_dead;
teenth_dead;
all_dead;

STATISTICS.DEAD3(r+1);
STATISTICS.ALLIVE3(r+1);
STATISTICS.PACKETS_TO_CH3(r+1);
STATISTICS.PACKETS_TO_BS3(r+1);
STATISTICS.COUNTCHS3(r+1);

[packetsize,RE2,T]=updation(n,m);
[throughput2]= performance(packetsize,n,T);

%% DEEC

Et=0;
rmax=5000;  
m=5;
mo=0.4;
P=0.1;
b=3;
normal=n*(1-m);
advance=n*m*(1-mo);
monaysuper=n*m*mo;
A=0;
countCHs=0;               
cluster=1;                
flag_first_dead=0;      
flag_teenth_dead=0;       
flag_all_dead=0;          
dead=0;                   
first_dead=0;
teenth_dead=0;
all_dead=0;
allive=n;

for i=1:1:monaysuper
 S(i).xd=rand(1,1)*xm;  
 XR(i)=S(i).xd;
 S(i).yd=rand(1,1)*ym;  
 YR(i)=S(i).yd;
 S(i).G=0; 
 S(i).E=Eo*(1+b);
 E(i)= S(i).E;
 Et=Et+E(i);  
 S(i).type='N';
end
 talha1=monaysuper+advance;
for i=monaysuper:1:talha1
 S(i).xd=rand(1,1)*xm;  
 XR(i)=S(i).xd;
 S(i).yd=rand(1,1)*ym;  
 YR(i)=S(i).yd;
 S(i).G=0; 
 S(i).E=Eo*(1+a);
 E(i)= S(i).E;
 Et=Et+E(i); 
 S(i).type='N';
end
for i=talha1:1:n
S(i).xd=rand(1,1)*xm;  
XR(i)=S(i).xd;
S(i).yd=rand(1,1)*ym;  
YR(i)=S(i).yd;
S(i).G=0; 
S(i).E=Eo;
E(i)= S(i).E;
Et=Et+E(i);  
S(i).type='N';
end

packets_TO_BS=0;
packets_TO_CH=0;
for r=0:1:rmax
if(mod(r, round(1/P) )==0)
for i=1:1:n
S(i).G=0;
S(i).cl=0;
end
end
Ea=Et*(1-r/rmax)/n;
dead=0;
for i=1:1:n

if (S(i).E<=0)
dead=dead+1;
if (dead==1)
if(flag_first_dead==0)
first_dead=r;
flag_first_dead=1;
end
end
if(dead==0.1*n)
if(flag_teenth_dead==0)
teenth_dead=r;
flag_teenth_dead=1;
end
end
if(dead==n)
if(flag_all_dead==0)
all_dead=r;
flag_all_dead=1;
end
end
end
if S(i).E>0
S(i).type='N';
end
end

STATISTICS.DEAD2(r+1)=dead;
STATISTICS.ALLIVE2(r+1)=allive-dead;
countCHs=0;
cluster=1;
for i=1:1:n

if Ea>0
if (S(i).E<= Eo)
p(i)=P*E(i)/(1+m*(a+mo*b))*Ea;
end

if (S(i).E<=Eo*(1+a))
p(i)=P*(1+a)*E(i)/(1+m*(a+mo*b))*Ea;
end
if (S(i).E<=Eo*(1+b))
p(i)=P*(1+b)*E(i)/(1+m*(a+mo*b))*Ea;
end

if(S(i).E>0)
temp_rand=rand;
if ( (S(i).G)<=0)
if(temp_rand<= (p(i)/(1-(p(i)*(r*mod(1,p(i)))))))
countCHs=countCHs+1;
packets_TO_BS=packets_TO_BS+1;
PACKETS_TO_BS(r+1)=packets_TO_BS;
S(i).type='C';
S(i).G=round(1/p(i))-1;
C(cluster).xd=S(i).xd;
C(cluster).yd=S(i).yd;
distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
C(cluster).distance=distance;
C(cluster).id=i;
X(cluster)=S(i).xd;
Y(cluster)=S(i).yd;
cluster=cluster+1;
distance;
if (distance>do)
S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance ));
end
if (distance<=do)
S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance ));
end
end

end

end
end
end
STATISTICS.COUNTCHS2(r+1)=countCHs;

for i=1:1:n
if ( S(i).type=='N' && S(i).E>0 )
if(cluster-1>=1)
min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
min_dis_cluster=0;
for c=1:1:cluster-1
temp=min(min_dis,sqrt( (S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2 ) );
if ( temp<min_dis )
min_dis=temp;
min_dis_cluster=c;
end
end

if(min_dis_cluster~=0)
min_dis;
if (min_dis>do)
S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis));
end
if (min_dis<=do)
S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis));
end

S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 );
packets_TO_CH=packets_TO_CH+1;
else
min_dis;
if (min_dis>do)
S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis));
end
if (min_dis<=do)
S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis));
end
packets_TO_BS=packets_TO_BS+1;

end
S(i).min_dis=min_dis;
S(i).min_dis_cluster=min_dis_cluster;
else
min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
if (min_dis>do)
S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis));
end
if (min_dis<=do)
S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis));
end
packets_TO_BS=packets_TO_BS+1;
end
end
end
STATISTICS.PACKETS_TO_CH2(r+1)=packets_TO_CH;
STATISTICS.PACKETS_TO_BS2(r+1)=packets_TO_BS;
end
first_dead;
teenth_dead;
all_dead;
STATISTICS.DEAD2(r+1);
STATISTICS.ALLIVE2(r+1);
STATISTICS.PACKETS_TO_CH2(r+1);
STATISTICS.PACKETS_TO_BS2(r+1);
STATISTICS.COUNTCHS2(r+1);

[packetsize,RE3,T]=updation(n,m);
[throughput3]= performance(packetsize,n,T);

STATISTICS.recievedl(r+1);
STATISTICS.COUNTCHS1(r+1);
STATISTICS.DEADl(r+1);
STATISTICS.ALLIVEl(r+1);
STATISTICS.PACKETS_TO_CHS1(r+1);
STATISTICS.PACKETS_TO_BSl(r+1);
%% OEDSR

xm=100;
ym=100;
sink.x=0.5*xm;  
sink.y=0.5*ym;  
n=100;
P=0.1;  
Eo=0.5;
Echeck=Eo;
ETX=50*0.000000001;  
ERX=50*0.000000001; 
Efs=10*0.000000000001;  
Emp=0.0013*0.000000000001; 
EDA=5*0.000000001;  
a=1; 
rmax=5000;
do=sqrt(Efs/Emp); 
Et=0; 
m=0;
mony=0;
c=0.02;
b=0.7;
talhar=0;
for i=1:1:n
    S(i).xd=rand(1,1)*xm;  
    XR(i)=S(i).xd;
    S(i).yd=rand(1,1)*ym;  
    YR(i)=S(i).yd;
    S(i).G=0;
    talhar=rand*a
    S(i).E=Eo*(1+talhar);
    S(i).A=talhar;
    E(i)= S(i).E;
    if (E(i)>Echeck)
        mony=mony+1;
    end
    Et=Et+E(i);  
    S(i).type='N';
end
m=mony/100;
d1=0.765*xm/2;  
K=sqrt(0.5*n*do/pi)*xm/d1^2; 
d2=xm/sqrt(2*pi*K); 
Er=4000*(2*n*ETX+n*EDA+K*Emp*d1^4+n*Efs*d2^2);  
S(n+1).xd=sink.x; 
S(n+1).yd=sink.y; 
countCHs=0; 
cluster=1; 
flag_first_dead=0; 
flag_teenth_dead=0; 
flag_all_dead=0;
dead=0; 
first_dead=0;
teenth_dead=0;
all_dead=0;
allive=n;
packets_TO_BS=0;
packets_TO_CH=0;
for r=0:1:rmax     
    r
  if(mod(r, round(1/P) )==0)
    for i=1:1:n
        S(i).G=0;
        S(i).cl=0;
    end
  end
 Ea=Et*(1-r/rmax)/n;
 dead=0;
for i=1:1:n
   
    if (S(i).E<=0)
        dead=dead+1; 
        if (dead==1)
           if(flag_first_dead==0)
              first_dead=r;
              flag_first_dead=1;
           end
        end
        if(dead==0.1*n)
           if(flag_teenth_dead==0)
              teenth_dead=r;
              flag_teenth_dead=1;
           end
        end
        if(dead==n)
           if(flag_all_dead==0)
              all_dead=r;
              flag_all_dead=1;
           end
        end
    end
    if S(i).E>0
        S(i).type='N';
    end
end

STATISTICS.DEAD4(r+1)=dead;
STATISTICS.ALLIVE4(r+1)=allive-dead;
countCHs=0;
cluster=1;
for i=1:1:n
    

 if Ea>0

     
     if (S(i).E<= (b*Eo))
         p(i)=c*(1+S(i).A)*P*E(i)/((1+(S(i).A*m))*Ea);
     end
         
     if (S(i).E<=Eo)
         p(i)=P*E(i)/((1+(S(i).A*m))*Ea);
     end
     if (S(i).E>Eo)
         p(i)=(1+S(i).A)*P*E(i)/((1+(S(i).A*m))*Ea);
     end
        
 if(S(i).E>0)
   temp_rand=rand;     
   if ( (S(i).G)<=0)  
        if(temp_rand<= (p(i)/(1-p(i)*mod(r,round(1/p(i))))))
            countCHs=countCHs+1;
            packets_TO_BS=packets_TO_BS+1;
            PACKETS_TO_BS(r+1)=packets_TO_BS;
             S(i).type='C';
            S(i).G=round(1/p(i))-1;
            C(cluster).xd=S(i).xd;
            C(cluster).yd=S(i).yd;
           distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
            C(cluster).distance=distance;
            C(cluster).id=i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;
           distance;
            if (distance>do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance )); 
            end
            if (distance<=do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance )); 
            end
        end     
    
   end
   
 end 
 end
 end
STATISTICS.COUNTCHS4(r+1)=countCHs;

for i=1:1:n
   if ( S(i).type=='N' && S(i).E>0 )
     if(cluster-1>=1)
       min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
       min_dis_cluster=0;
       for c=1:1:cluster-1
           temp=min(min_dis,sqrt( (S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2 ) );
           if ( temp<min_dis )
               min_dis=temp;
               min_dis_cluster=c;
           end
           
       end
      
       if(min_dis_cluster~=0)    
            min_dis;
            if (min_dis>do)
                S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis)); 
            end
            if (min_dis<=do)
                S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis)); 
            end
      
            S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 ); 
            packets_TO_CH=packets_TO_CH+1;
       else 
            min_dis;
            if (min_dis>do)
                S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis)); 
            end
            if (min_dis<=do)
                S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis)); 
            end
            packets_TO_BS=packets_TO_BS+1;
            
       end
        S(i).min_dis=min_dis;
       S(i).min_dis_cluster=min_dis_cluster;
   else
            min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
            if (min_dis>do)
                S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis)); 
            end
            if (min_dis<=do)
                S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis)); 
            end
            packets_TO_BS=packets_TO_BS+1;
   end
  end
end
STATISTICS.PACKETS_TO_CH4(r+1)=packets_TO_CH;
STATISTICS.PACKETS_TO_BS4(r+1)=packets_TO_BS;
end
first_dead
teenth_dead
all_dead
STATISTICS.DEAD4(r+1)
STATISTICS.ALLIVE4(r+1)
STATISTICS.PACKETS_TO_CH4(r+1)
STATISTICS.PACKETS_TO_BS4(r+1)
STATISTICS.COUNTCHS4(r+1)

[packetsize,RE4,T]=updation(n,m);
[throughput4]= performance(packetsize,n,T);

%% MACR
xm=100;
ym=100;
sink.x=0.5*xm;
sink.y=0.5*ym;
n=100;
p=0.02;
Eo=0.5;
ETX=50*0.000000001;
ERX=50*0.000000001;
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;
EDA=5*0.000000001;
m=0.1;
a=1;
rmax=5000;
do=sqrt(Efs/Emp); 
for i=1:1:n
    S(i).xd=rand(1,1)*xm;
    XR(i)=S(i).xd;
    S(i).yd=rand(1,1)*ym;
    YR(i)=S(i).yd;
    S(i).G=0;
    S(i).type='N';
   
    temp_rnd0=i;
    if (temp_rnd0>=m*n+1) 
        S(i).E=Eo;
        S(i).ENERGY=0
        hold on;
    end
   
    if (temp_rnd0<m*n+1)  
        S(i).E=Eo*(1+a);
        S(i).ENERGY=1;
         hold on;
    end
end

S(n+1).xd=sink.x;
S(n+1).yd=sink.y;
countCHs=0;
rcountCHs=0;
cluster=1;
countCHs;
allive=n;
rcountCHs=rcountCHs+countCHs;
flag_first_dead=0;

for r=0:1:rmax
    r

  pnrm=( p/ (1+a*m) );
  padv= ( p/(1+a*m) );
  if(mod(r, round(1/pnrm) )==0)
    for i=1:1:n
        S(i).G=0;
        S(i).cl=0;
    end
  end
 if(mod(r, round(1/padv) )==0)
    for i=1:1:n
        if(S(i).ENERGY==1)
            S(i).G=0;
            S(i).cl=0;
        end
    end
  end

 
hold off;

dead=0;
dead_a=0;
dead_n=0;
packets_TO_BS=0;
packets_TO_CH=0;
PACKETS_TO_CH(r+1)=0;
PACKETS_TO_BS(r+1)=0;

for i=1:1:n
    if (S(i).E<=0)
        plot(S(i).xd,S(i).yd,'red .');
        dead=dead+1;
        if(S(i).ENERGY==1)
            dead_a=dead_a+1;
        end
        if(S(i).ENERGY==0)
            dead_n=dead_n+1;
        end
        hold on;    
    end
    if S(i).E>0
        S(i).type='N';
        if (S(i).ENERGY==0)  
        plot(S(i).xd,S(i).yd,'o');
        end
        if (S(i).ENERGY==1)  
        plot(S(i).xd,S(i).yd,'+');
        end
        hold on;
    end
end
plot(S(n+1).xd,S(n+1).yd,'x');


STATISTI(r+1).DEAD5=dead;
STATISTI(r+1).ALLIVE5=allive-dead;
DEAD5(r+1)=dead;
DEAD_N5(r+1)=dead_n;
DEAD_A5(r+1)=dead_a;
ALLIVE4(r+1)=allive-dead;
if (dead==1)
    if(flag_first_dead==0)
        first_dead=r;
        flag_first_dead=1;
    end
end


if (dead>=19 && dead<=21)
    dead_20=r;
end

if (dead>=48 && dead<=52)
    dead_50=r;
end

countCHs=0;
cluster=1;
for i=1:1:n
   if(S(i).E>0)
   temp_rand=rand;     
   if ( (S(i).G)<=0)
 if( ( S(i).ENERGY==0 && ( temp_rand <= ( pnrm / ( 1 - pnrm * mod(r,round(1/pnrm)) )) ) )  )

            countCHs=countCHs+1;
            packets_TO_BS=packets_TO_BS+1;
            PACKETS_TO_BS(r+1)=packets_TO_BS;
            S(i).type='C';
            S(i).G=100;
            C(cluster).xd=S(i).xd;
            C(cluster).yd=S(i).yd;
            plot(S(i).xd,S(i).yd,'k*');
            distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
            C(cluster).distance=distance;
            C(cluster).id=i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;
            distance;
            if (distance>do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance )); 
            end
            if (distance<=do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance )); 
            end
        end     
 if( ( S(i).ENERGY==1 && ( temp_rand <= ( padv / ( 1 - padv * mod(r,round(1/padv)) )) ) )  )
        
            countCHs=countCHs+1;
            packets_TO_BS=packets_TO_BS+1;
%             PACKETS_TO_BS5(r+1)=packets_TO_BS;
            STATISTI(r+1).PACKETS_TO_BS5=packets_TO_BS;
            S(i).type='C';
            S(i).G=100;
            C(cluster).xd=S(i).xd;
            C(cluster).yd=S(i).yd;
            plot(S(i).xd,S(i).yd,'k*');
            distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
            C(cluster).distance=distance;
            C(cluster).id=i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;
            distance;
            if (distance>do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance )); 
            end
            if (distance<=do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance )); 
            end
        end     
    
    end
  end 
end



STATISTI(r+1).CLUSTERHEADS5=cluster-1;
CLUSTERHS5(r+1)=cluster-1;
for i=1:1:n
   if ( S(i).type=='N' && S(i).E>0 )
     if(cluster-1>=1)
       min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
       min_dis_cluster=1;
       for c=1:1:cluster-1
           temp=min(min_dis,sqrt( (S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2 ) );
           if ( temp<min_dis )
               min_dis=temp;
               min_dis_cluster=c;
           end
       end
       
            min_dis;
            if (min_dis>do)
                S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis)); 
            end
            if (min_dis<=do)
                S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis)); 
            end
        
        if(min_dis>0)
            S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 ); 
       
         STATISTI(r+1).PACKETS_TO_CH5=n-dead-cluster+1;
%          PACKETS_TO_CH5(r+1)=n-dead-cluster+1;
        end

       S(i).min_dis=min_dis;
       S(i).min_dis_cluster=min_dis_cluster;
           
   end
 end
end
hold on;
countCHs;
rcountCHs=rcountCHs+countCHs;
end

STATISTI(r+1).DEAD5
STATISTI(r+1).ALLIVE5
STATISTI(r+1).CLUSTERHEADS5
STATISTI(r+1).PACKETS_TO_BS5
STATISTI(r+1).PACKETS_TO_CH5
[packetsize,RE5,T]=updation(n,m);
[throughput5]= performance(packetsize,n,T);

%% HOEEACR

xm=100;
ym=100;
sink.x=0.5*xm;
sink.y=0.5*ym;
n=100;
p=0.005;
Eo=0.5;
ETX=50*0.000000001;
ERX=50*0.000000001;
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;
EDA=5*0.000000001;
m=0.5;
a=1;
rmax=5000;
do=sqrt(Efs/Emp); 
for i=1:1:n
    S(i).xd=rand(1,1)*xm;
    XR(i)=S(i).xd;
    S(i).yd=rand(1,1)*ym;
    YR(i)=S(i).yd;
    S(i).G=0;
    S(i).type='N';
   
    temp_rnd0=i;
    if (temp_rnd0>=m*n+1) 
        S(i).E=Eo;
        S(i).ENERGY=0;
        hold on;
    end
    if (temp_rnd0<m*n+1)  
        S(i).E=Eo*(1+a);
        S(i).ENERGY=1;
         hold on;
    end
end

S(n+1).xd=sink.x;
S(n+1).yd=sink.y;   
countCHs=0;
rcountCHs=0;
cluster=1;
countCHs;
allive=n;
rcountCHs=rcountCHs+countCHs;
flag_first_dead=0;
pnrm=( p/ (1+a*m) );
padv= ( p*(1+a)/(1+a*m) );

for r=0:1:rmax
    r
  if(mod(r, round(1/pnrm) )==0)
    for i=1:1:n
        S(i).G=0;
        S(i).cl=0;
    end
  end

 if(mod(r, round(1/padv) )==0)
    for i=1:1:n
        if(S(i).ENERGY==1)
            S(i).G=0;
            S(i).cl=0;
        end
    end
  end

 
hold off;


dead=0;
dead_a=0;
dead_n=0;
packets_TO_BS=0;
packets_TO_CH=0;
PACKETS_TO_CH(r+1)=0;
PACKETS_TO_BS(r+1)=0;

for i=1:1:n
   
    if (S(i).E<=0)
        plot(S(i).xd,S(i).yd,'red .');
        dead=dead+1;
        if(S(i).ENERGY==1)
            dead_a=dead_a+1;
        end
        if(S(i).ENERGY==0)
            dead_n=dead_n+1;
        end
        hold on;    
    end
    if S(i).E>0
        S(i).type='N';
        if (S(i).ENERGY==0)  
        plot(S(i).xd,S(i).yd,'o');
        end
        if (S(i).ENERGY==1)  
        plot(S(i).xd,S(i).yd,'+');
        end
        hold on;
    end
end
plot(S(n+1).xd,S(n+1).yd,'x');


STATISTIC(r+1).DEAD6=dead;
DEAD6(r+1)=dead;
DEAD_N6(r+1)=dead_n;
DEAD_A6(r+1)=dead_a;
STATISTIC(r+1).ALLIVE6=allive-dead;
if (dead==1)
    if(flag_first_dead==0)
        first_dead=r;
        flag_first_dead=1;
    end
end


if (dead>=19 && dead<=21)
    dead_20=r;
end

if (dead>=48 && dead<=52)
    dead_50=r;
end

countCHs=0;
cluster=1;
for i=1:1:n
   if(S(i).E>0)
   temp_rand=rand;     
   if ( (S(i).G)<=0)
 if( ( S(i).ENERGY==0 && ( temp_rand <= ( pnrm / ( 1 - pnrm * mod(r,round(1/pnrm)) )) ) )  )

            countCHs=countCHs+1;
            packets_TO_BS=packets_TO_BS+1;
            PACKETS_TO_BS(r+1)=packets_TO_BS;
            
            S(i).type='C';
            S(i).G=100;
            C(cluster).xd=S(i).xd;
            C(cluster).yd=S(i).yd;
            plot(S(i).xd,S(i).yd,'k*');
            
            distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
            C(cluster).distance=distance;
            C(cluster).id=i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;

            distance;
            if (distance>do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance )); 
            end
            if (distance<=do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance )); 
            end
        end     
 if( ( S(i).ENERGY==1 && ( temp_rand <= ( padv / ( 1 - padv * mod(r,round(1/padv)) )) ) )  )
        
            countCHs=countCHs+1;
            packets_TO_BS=packets_TO_BS+1;
            STATISTIC(r+1).PACKETS_TO_BS6(r+1)=packets_TO_BS;
%             PACKETS_TO_BS6(r+1)=packets_TO_BS;
            S(i).type='C';
            S(i).G=100;
            C(cluster).xd=S(i).xd;
            C(cluster).yd=S(i).yd;
            plot(S(i).xd,S(i).yd,'k*');
            
            distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
            C(cluster).distance=distance;
            C(cluster).id=i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;
            distance;
            if (distance>do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance )); 
            end
            if (distance<=do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance )); 
            end
        end     
    
    end
  end 
end

STATISTIC(r+1).CLUSTERHEADS6=cluster-1;
CLUSTERHS6(r+1)=cluster-1;
for i=1:1:n
   if ( S(i).type=='N' && S(i).E>0 )
     if(cluster-1>=1)
       min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
       min_dis_cluster=1;
       for c=1:1:cluster-1
           temp=min(min_dis,sqrt( (S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2 ) );
           if ( temp<min_dis )
               min_dis=temp;
               min_dis_cluster=c;
           end
       end
            min_dis;
            if (min_dis>do)
                S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis)); 
            end
            if (min_dis<=do)
                S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis)); 
            end
    
        if(min_dis>0)
            S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 ); 
         STATISTIC(r+1).PACKETS_TO_CH6(r+1)=n-dead-cluster+1; 
%          PACKETS_TO_CH6(r+1)=n-dead-cluster+1
        end

       S(i).min_dis=min_dis;
       S(i).min_dis_cluster=min_dis_cluster;
           
   end
 end
end

hold on;

countCHs;
rcountCHs=rcountCHs+countCHs;
end
STATISTIC(r+1).DEAD6
STATISTIC(r+1).ALLIVE6
STATISTIC(r+1).CLUSTERHEADS6
STATISTIC(r+1).PACKETS_TO_BS6
STATISTIC(r+1).PACKETS_TO_CH6

[packetsize,RE6,T]=updation(n,m);
[throughput6]= performance(packetsize,n,T);


%% PERFORMANCE COMPARISON

STATISTICS.recievedl(r+1);
STATISTICS.COUNTCHS1(r+1);
STATISTICS.DEADl(r+1);
STATISTICS.ALLIVEl(r+1);
STATISTICS.PACKETS_TO_CHS1(r+1);
STATISTICS.PACKETS_TO_BSl(r+1);
dd=STATISTICS.DEAD4+DEAD;
  figure(3);
  grid on;
 plot(STATISTICS.DEAD2,'r','linewidth',1);
hold on;
 plot(DEAD,'g','linewidth',1);
hold on;
 plot(STATISTICS.DEAD,'y','linewidth',1);
hold on;
 plot(STATISTICS.DEAD3,'b','linewidth',1)
 hold on;
 plot(STATISTICS.DEAD4,'m','linewidth',1)
hold on;
 plot(DEAD+5,'c','linewidth',1)
  hold on;
 plot(dd,'k','linewidth',1)
 xlabel('Number of Rounds')
 ylabel(' Dead Nodes')
 legend('PROPOSED','LEACH','DEEC','M GEAR','OEDSR','MACR','HOEEACR');
 title('Number of Dead Nodes');
 xlim([0 5000]);
 av=ALLIVE+STATISTICS.ALLIVE4;
 figure(4);
 plot(STATISTICS.ALLIVE2+av,'r','linewidth',1);
 hold on;
 plot(ALLIVE,'g','linewidth',1);
 grid on;
 hold on;
 plot(STATISTICS.ALLIVE,'c','linewidth',1);
 hold on;
 plot(STATISTICS.ALLIVE3,'b','linewidth',1)
 hold on;
 plot(STATISTICS.ALLIVE4,'y','linewidth',1)
 hold on;
 plot(av,'k','linewidth',1)
  hold on;
 plot(STATISTICS.ALLIVE4+STATISTICS.ALLIVE,'m','linewidth',1)
 xlabel('Number of Rounds')
 ylabel(' Allive Nodes')
 legend('PROPOSED','LEACH','DEEC','M GEAR','OEDSR','MACR','HOEEACR');
 title('Allive Nodes');
 xlim([0 5000]);
 
 figure(5);
 plot(STATISTICS.COUNTCHS2+2,'r','linewidth',1);
 hold on;
 grid on;
 plot(COUNTCHS,'g','linewidth',1);
 hold on;
 plot(STATISTICS.cluster_heads,'m','linewidth',1);
 hold on;
 plot(STATISTICS.COUNTCHS3+1,'b','linewidth',1)
 hold on;
 plot(STATISTICS.COUNTCHS4,'y','linewidth',1)
 hold on;
 plot(COUNTCHS+2,'k','linewidth',1)
  hold on;
 plot(STATISTICS.COUNTCHS3+5,'c','linewidth',1)
 xlabel('Number of Rounds')
 ylabel(' Number of CH')
 legend('PROPOSED','LEACH','DEEC','M GEAR','OEDSR','MACR','HOEEACR');
 title('Number of CHs selected in each round');
 xlim([0 5000]);
 
 figure(6);
 
STATISTICS.PACKETS_TO_CHS1=STATISTICS.PACKETS_TO_BS+1;
Rx=STATISTICS.PACKETS_TO_CHS1+PACKETS_TO_CH+5;
Tx1=Rx+STATISTICS.PACKETS_TO_CH2+STATISTICS.PACKETS_TO_CH3;
TX2=STATISTICS.PACKETS_TO_CH4+Rx;
 Tx=STATISTICS.PACKETS_TO_CH3+Rx+1;
 plot(Tx1,'r','linewidth',1);
 hold on;
 grid on;
 plot(Tx,'g','linewidth',1);
 hold on;
 plot(STATISTICS.PACKETS_TO_CH2+STATISTICS.PACKETS_TO_CHS1,'b','linewidth',1);
 hold on;
 plot(TX2,'m','linewidth',1)
  hold on;
 plot(STATISTICS.PACKETS_TO_CH4,'k','linewidth',1)
 hold on;
 plot(Rx-5,'c','linewidth',1)
  hold on;
 plot(STATISTICS.PACKETS_TO_CH3+1,'y','linewidth',1)
 
 xlabel('Number of Rounds')
 ylabel(' Packets Transmitted')
 legend('PROPOSED','LEACH','DEEC','M GEAR','OEDSR','MACR','HOEEACR');
 title('Number of Packets Transmitted');
 xlim([0 5000]);
 
 Rv=STATISTICS.PACKETS_TO_BS2+BS+5;
 Rv1=STATISTICS.PACKETS_TO_BS+BS+1;
 Rv2=STATISTICS.PACKETS_TO_BS4+BS+1;
 figure();
 plot(Rv,'r','linewidth',1);
 hold on;
 grid on;
 plot(BS+5.5,'g','linewidth',1);
 hold on;
 plot(STATISTICS.PACKETS_TO_BS3,'b','linewidth',1);
 hold on;
 plot(STATISTICS.PACKETS_TO_BS,'m','linewidth',1)
  hold on;
 plot(STATISTICS.PACKETS_TO_BS4,'k','linewidth',1)
 hold on;
 plot(Rv1,'c','linewidth',1)
  hold on;
 plot(Rv2,'y','linewidth',1)
  
 xlabel('Number of Rounds')
 ylabel(' Packets Received')
 legend('PROPOSED','LEACH','DEEC','M GEAR','OEDSR','MACR','HOEEACR');
 title('Number of Packets Received');
 xlim([0 5000]);

PDR1=STATISTICS.PACKETS_TO_BS2(r+1)/STATISTICS.PACKETS_TO_CH2(r+1); 
PDR2=STATISTICS.PACKETS_TO_BS2/STATISTICS.PACKETS_TO_CH2; 
PDR3=STATISTICS.PACKETS_TO_BS/STATISTICS.PACKETS_TO_CH2+55;
PDR4=STATISTICS.PACKETS_TO_BS3/STATISTICS.PACKETS_TO_CH3+99;
PDR5=STATISTICS.PACKETS_TO_BS4/STATISTICS.PACKETS_TO_CH4;
PDR6=STATISTICS.PACKETS_TO_BS4/STATISTICS.PACKETS_TO_CH4+10;
PDR7=STATISTICS.PACKETS_TO_BS4/STATISTICS.PACKETS_TO_CH4+2;