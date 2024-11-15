$Title  A branch and bound problem
$onEolCom
$ontext
Sets
       i   "canning plants"   / seattle, san-diego /
       j   "markets"          / new-york, chicago, topeka / ;

  Parameters

       a(i)  "capacity of plant i in cases"
         /    seattle     350
              san-diego   600  /

       b(j)  "demand at market j in cases"
         /    new-york    325
              chicago     300
              topeka      275  / ;
$offtext
*you need to set x_R, y_R, and y_r
Scalars
        S_Q "switch time for qc between two containers" /2/ !! This is temporarily assumed constant
        x /1/
        y /1/
        x_R /10/
        y_R /14/
        y_r1 /10/
        v "AGV speed" /4/
        Mnum "a very large number" /10000000/;
Sets
       
        i "container index" /i0*i4/
        j(i) "a duplicate of i" /#i/ !!this is temporary, a better is to write /#i/
        id(i) "last container" /i4/
        
        m   "QC index" /m0,m1,m2,m3,m4/        
        n(m)   "A duplicate of j" /#m/ !!this is temporary, a better is to write /#m/


        li "AGV index" /l1*l3/
        Bs(li) "set of all agvs" /#li/
        
*       0 in a is a virtual starting point
        a   "AGV actions" /a0*a4/

        XR  "Vertical Operational Area" /1*10/
        YR  "Horizontal Operational Area" /1*14/
        YS(YR)  "Horizontal Seaside Operation Area" /11*14/
        YL(YR)  "Horizontal Path" /1*10/


        o(m,i,XR) /m1.i1.2, m2.i2.3/
        A_L(m,i,XR) /m1.i1.2, m2.i2.1, m3.i3.4, m4.i4.7/
        A_R(m,i,XR) /m1.i1.7, m2.i2.9, m3.i3.6, m4.i4.8/
        
        
        L(m,i)   /m1.i1 , m2.i2/
        D(m,i) "Unloading Containers. U is a subset of index i" /m3.i3, m4.i4/ 
        C(m,i)  "All  Containers" /m1.i1 , m2.i2, m3.i3, m4.i4/ !! this is in data file
        Cd(m,i) "the last QC container job" /m4.i4/
*        C_prime(i) "The set of containers to be assigned" $ "This is in data file" 

        WT(m,i,a) "set of total actions" /#C.#a/
        WV(m,i,a)  "Vertical Actions" /m1.i1.a1/
        WH(m,i,a)  "Horizontal Actions" /m2.i2.a2/

*       or psi_1(m,i,m,i)?
*very challenging set!
        psi_1(m,i,m,i)   "Scnstruence of Container jobs for QC" /m1.i1.m2.i3/ !!This is in data file. This identifies the container job scnstruence, (in a form of 2d graph?)idk
        psi_2(m,i,m,i)   "Scnstruence of Container jobs for ASC" /#psi_1/ !!This is in data file. 
        ;
*O(YR) $(C(m,i)) = yes;
alias(XR, XR_1);
alias(YR, YR_1);

alias (a,a1);
alias (a,a2);
alias (a2,a2_1);
alias (a1,a1_1);
alias (i,i1);
set h(n)/#m/;  !! for cnstr_3
set k(j) /#i/;
set s(YR);
set XR2(XR) /#XR/;
Parameters
        o1(m,i) "merely a copy of the o(m,i,XR), with XR treated as a number" /m1.i1 2, m2.i2 3/
        G_Q(m,i) /m1.i1 1, m2.i2 1, m3.i3 1, m4.i4 1/ !! seems to be constant for all container jobs, bc of const 24
        G_Y(m,i) /m1.i1 1, m2.i2 1, m3.i3 1, m4.i4 1/
        ;

$hidden Data
$ontext
Table d(i,j)  distance in thousands of miles
                    new-yorksdafasdf       chicago      topeka
      seattle          2.5           1.7          100.8
      san-diego        2.5           1.8          1.4  ;
$offtext  

Binary Variables

        z(m, i, m, i, li)   "used mainly for handling QC double cycling, it consists of 0 virtual point!"
        U_AGV(m,i,a,m,i,a)  "U_AGV(j_1,j_2) conducted before" 
        U_QC(m,i,m,i,a)   "U_QC(j,WT) conducted before"
        
*       "Path related variables
        P_X(m,i,a,XR) "P_X(WV,x) finish V loc"
        P_Y(m,i,a,YR) "P_Y(WH,y) finish H loc"
        P_X0(m,i,a,XR) "P_X(WV,x) Start H loc"
        P_Y0(m,i,a,YR) "P_Y(WH,y) Start H loc"
        ;

Positive Variables

*       Time related variables
        T_Q(m,i) "start time of QC"
        T_Y(m,i) "Start time of agv putting cont on ASC"
        T_start(m,i,a) "Start of agv for action (m,i,a)"
        

*       Auxiliary Variables
        t_AGV(m,i,a,m,i,a)        "t_AGV(WT_1,WT_2"
        X_position(m,i,a)   "X_position(WT)"
        Y_position(m,i,a)   "Y_position(WT)"

        ;
variable obj "objective function";

Equations
        ADRP                        "AGV Dispatching and Routing Problem"

*       Job assignment constraints
        cnstr_2(m,i)               
        cnstr_3(m,i,li)             "C,B"      
        cnstr_4(li)                 "B with 0 virtual node"         
        cnstr_5(li)               ‌  "B with 0 virutal node"         
        cnstr_6(m,i)                "L"         
        cnstr_7(m,i)                "D"         
*
**       LOcation constraints of AGV acitons
        cnstr_8(m,i,n,j,XR, li)         "C,C,XR"        
        cnstr_9(m,i,n,j,YR, li)         "C,C,YR"    
        cnstr_10(m,i,a)             "C,a"     
        cnstr_11(m,i,a)             "C,a"      
        cnstr_12(m,i)               "L"        
        cnstr_13(m,i)               "D"        
        cnstr_14(m,i,XR)            "D"        
        cnstr_15(m,i)               "L"
        cnstr_16(m,i)               "D"
        cnstr_17(m,i)               "L"
        cnstr_18(m,i,XR)            "L"
        cnstr_19(m,i)               "D"
        cnstr_20(m, i, a, a, YR)    "WH,YR"
        cnstr_21(m,i,a,a,XR)        "WV,XR"
*
**Conflict Free Constraints
        cnstr_22(m,i,n,j)           "C,C"
        cnstr_23(m,i,a,n,j,a,YR,XR) "WH,WH,YR,XR"
        cnstr_24(m,i,n,j,a)         "C, WH"
        cnstr_25(m,i,n,j,a,a)       "C, WH"
*        cnstr_26(n,j,a,YS,m,i,a,a)  "WH,YS,D"  !! for both alpha = 0 and alpha =  3
        cnstr_27(m,i,a,n,j,a,XR)    "WV, XR"
        cnstr_28(m,i,a, a)          "C,a"      !! alpha>2

**Time Constraints
        cnstr_29(m,i,i)             "C,C"      !! two consecutive containers, i and i+1
        cnstr_30(m,i,m,i)           "psi_1"
        cnstr_31(m,i,m,i)           "psi_2"
        cnstr_32(m,i)               "D"
        cnstr_33(m,i)               "L"
        cnstr_34(m,i,m,i)           "D,L"
        cnstr_35(m,i,m,i)           "L,D"
        cnstr_36(m,i,a)             "D,a"      !!alpha=4 and 1
        cnstr_37(m,i,a)             "D,a"      !!alpha=1 and 1
        cnstr_38(m,i,a,a,n,j,a)     "WT,WT"
        cnstr_39(m,i,a,XR)          "C,a,XR"
        cnstr_40(m,i,a,YR)          "C,a,YR"
        cnstr_41(m,i,m,i,a,a)       "C,C,a,a"
        ;


ADRP.. obj =e= T_Q('m4','i4') + G_Q('m4','i4') + T_Y('m4','i4') + G_Y('m4','i4');


**Job assinment constraints
cnstr_2(m,i) $(C(m,i) and not sameas(m,'m0') and not sameas(i,'i0')).. sum((li,n,j) $C(n,j),  z(m,i,n,j,li)) =e= 1;
cnstr_3(m,i,li) $(C(m,i)).. sum((n,j) $C(n,j), z(m,i,n,j,li)) =e= sum((h,k) $C(h,k), z(m,i,h,k,li));
cnstr_4(li).. sum((m,i) $(C(m,i) and not sameas(m,'m0') and not sameas(i,'i0')), z('m0', 'i0', m, i, li)) =e= 1;
cnstr_5(li).. sum((m,i) $(C(m,i) and not sameas(m,'m0') and not sameas(i,'i0')), z(m, i, 'm0', 'i0', li)) =e= 1;
cnstr_6(m,i) $(L(m,i)).. sum((li,n,j) $(D(n,j)), z(m,i,n,j,li)) =e= 1;
cnstr_7(m,i) $(D(m,i)).. sum((li,n,j) $(L(n,j)), z(m,i,n,j,li)) =e= 1;
*
**Location constraints of AGV acitons
cnstr_8(m,i,n,j,xr, li) $(C(m,i) and C(n,j))..
$ifthen z(m,i,n,j,li) == 1
 P_X(m,i,'a4',XR)  =e= P_X(n,j,'a0',XR);  !! a bit different from the article's forumulation
$else
1 =e= 1;
$endif
cnstr_9(m,i,n,j,yr, li) $(C(m,i) and C(n,j))..
$ifthen z(m,i,n,j,li) == 1
 P_Y(m,i,'a4',YR) =e= P_Y(n,j,'a0',YR);
$else
1 =e= 1;
$endif
cnstr_10(m,i,a) $(C(m,i)).. sum(XR, P_X(m,i,a,XR)) =e= 1;
cnstr_11(m,i,a) $(C(m,i)).. sum(YR, P_Y(m,i,a,YR)) =e= 1;
cnstr_12(m,i) $(L(m,i)).. sum(YL, P_Y(m,i,'a0',YL)) =e= 1;
cnstr_13(m,i) $(D(m,i)).. sum(YS, P_Y0(m,i,'a0',YS)) =e= 1;
cnstr_14(m,i,XR) $(D(m,i) and o(m,i,XR)).. P_X0(m, i,'a0',XR) =e= 1; !! You could use P_X0('m1','i1','a0','3').fx = 1 (this is used when wanting the variable to be fixed!)
cnstr_15(m,i) $(L(m,i)).. sum(XR $(A_L(m,i,XR) and A_R(m,i,XR)), P_X0(m,i,'a0',XR)) =e= 1;
cnstr_16(m,i) $(L(m,i)).. sum(YS, P_Y(m,i,'a3',YS)) =e= 1;
cnstr_17(m,i) $(L(m,i)).. sum(YS, P_Y(m,i,'a3',YS)) =e= 1;
cnstr_18(m,i,XR) $(L(m,i) and o(m,i,XR)).. P_X0(m, i,'a3',XR) =e= 1;
cnstr_19(m,i) $(D(m,i)).. sum(XR $(A_L(m,i,XR) and A_R(m,i,XR)), P_X0(m,i,'a3',XR)) =e= 1;
cnstr_20(m, i, a1, a1_1, YR) $(WH(m,i,a1) and ord(a1_1) < ord(a1)).. P_Y(m,i,a1,YR) =e= P_Y(m,i,a1_1,YR);
cnstr_21(m, i, a1, a1_1, XR) $(WH(m,i,a1) and ord(a1_1) < ord(a1)).. P_X(m, i, a1, XR) =e= P_X(m,i,a1_1,XR);
*
**Conflict Free Constraints
cnstr_22(m,i,n,j) $(C(m,i) and C(n,j)).. U_AGV(m,i,'a4',n,j,'a1') =g= sum(li, z(m,i,n,j,li));
cnstr_23(m,i,a1,n,j,a2,YR,XR) $(WH(m,i,a1) and WH(n,j,a2)).. U_AGV(m,i,a1,n,j,a2) + U_AGV(n,j,a2,m,i,a1) + 3 - P_Y(m,i,a1,YR) - P_Y(n,j,a2, YR) - sum((XR_1, a1_1, a2_1) $(ord(XR_1) <= ord(XR) and ord(a1_1)<ord(a1) and ord(a2_1) <ord(a2)), P_X(m,i,a1_1,XR_1) + P_X(n,j,a2,XR_1) - P_X(m,i,a1,XR_1) - P_X(n,j,a2_1,XR_1)) =g= 0;
cnstr_24(m,i,n,j,a) $(C(m,i) and WH(n,j,a)).. T_Q(m,i) + G_Q(m,i) + Mnum*(1 - U_QC(m,i,n,j,a)) =g= T_start(n,j,a);
cnstr_25(m,i,n,j,a1, a1_1) $(C(m,i) and WH(n,j,a1) and ord(a1_1)<ord(a1))..  T_Start(n,j,a1) + t_AGV(n,j,a1_1,n,j,a1) + Mnum*(1 - U_QC(m,i,n,j,a1) ) =g= T_Q(m,i);
*cnstr_26(n,j,a2,YS,m,i,a1,a2_1) $( ( (sameas(a1, 'a0') and D(m,i)) or (sameas(a1, 'a3') and L(m,i)) ) and wh(n,j,a2) and ord(a2_1)<ord(a2)).. (3 - U_QC(m,i,n,j,a2) - P_Y(m,i,a1,YS) - P_Y(n,j,a2,YS) + abs(sum(XR $(XR.val <= o1(m,i)), P_x(n,j,a2,XR)) - sum(XR $(XR.val > o1(m,i)), P_X(n,j,a2_1,XR))) ) * Mnum + T_start(n,j,a2) + t_agv(n,j,a2_1,m,i,a1) =g= T_Q(m,i) + G_Q(m,i);
cnstr_27(m,i,a1,n,j,a2,XR) $(WH(m,i,a1) and WH(n,j,a2)).. U_AGV(m,i,a1,n,j,a2) + U_AGV(n,j,a2,m,i,a1) =g= P_X(m,i,a1,XR) + P_X(n,j,a2,XR) - 1;
cnstr_28(m,i,a1, a1_1) $(C(m,i) and (sameas(a1,'a2') or sameas(a1,'a3') or sameas(a1,'a4') ) and ord(a1_1)<ord(a1)).. U_AGV(m,i,a1_1,m,i,a1) =e= 1;

*Time Constraints
cnstr_29(m,i,i1) $(c(m,i) and (ord(i)<ord(i1))).. T_Q(m,i1) =g= T_Q(m,i) + G_Q(m,i) + S_Q;
cnstr_30(m,i,n,j) $(psi_1(m,i,n,j)).. T_Q(n,j) =g= T_Q(m,i) + G_Q(m,i);
cnstr_31(m,i,n,j) $(psi_2(m,i,n,j)).. T_Y(n,j) =g= T_Y(m,i) +G_Y(m,i);
cnstr_32(m,i) $(D(m,i)).. T_y(m,i) =g= T_start(m,i,'a3') + t_AGV(m,i,'a2',m,i,'a3');
cnstr_33(m,i) $(L(m,i)).. T_Q(m,i) =g= T_start(m,i,'a3') + t_agv(m,i,'a2',m,i,'a3');
cnstr_34(m,i,n,j) $(D(m,i) and L(n,j)).. T_y(n,j) + Mnum*(1 - sum(li, z(m,i,n,j,li))) =g= T_start(m,i,'a4') + t_agv(m,i,'a3',m,i,'a4');
cnstr_35(m,i,n,j) $(L(m,i) and D(n,j)).. T_Q(n,j) + Mnum*(1 - sum(li, z(m,i,n,j,li))) =g= T_start(m,i,'a4') + t_agv(m,i,'a3',m,i,'a4');
cnstr_36(m,i,a) $( (D(m,i) and sameas(a,'a4')) or (L(m,i) and sameas(a,'a1')) ).. T_start(m,i,a) =g= t_y(m,i) + G_y(m,i);
cnstr_37(m,i,a) $( (D(m,i) and sameas(a,'a1')) or (L(m,i) and sameas(a,'a4')) ).. T_start(m,i,a) =g= t_Q(m,i) + G_Q(m,i);
cnstr_38(m,i,a1,a1_1,n,j,a2) $(WT(m,i,a1) and wt(n,j,a2) and (ord(a1_1) < ord(a1))).. T_start(n,j,a2) + Mnum*(1-U_AGV(m,i,a1,n,j,a2)) =g= t_start(m,i,a1) + t_AGV(m,i,a1_1,m,i,a1);

cnstr_39(m,i,a,XR) $(c(m,i))..
$ifthen P_x(m,i,a,XR) == 1
 x_position(m,i,a)  =e= 1; !! This constraint is similar to the declaration of cnstr_8 and cnstr_9
$else
 1 =e= 1;
$endif

cnstr_40(m,i,a,YR) $(c(m,i))..
$ifthen P_x(m,i,a,XR) == 1
 y_position(m,i,a) =e= 1; !! This constraint is similar to the declaration of cnstr_8 and cnstr_9
$else
1 =e= 1;
$endif

cnstr_41(m,i,n,j,a1,a2) $(c(m,i) and c(n,j)).. t_agv(m,i,a1,n,j,a2) =e= (abs(x_position(m,i,a1) - x_position(n,j,a2)) + abs(Y_position(m,i,a1) - y_position(n,j,a2)))/v;
*
Model ConflictFreeSch /all/ ;

Solve ConflictFreeSch using minlp minimizing obj;

*Display x.l, x.m ;
