$Title  A conflict free container dispatching problem
$onEolCom
$ONEMPTY
*cnstr_15 and cnstr_19 are infeasible and I hypothesize it's due to not setting initial virtual positions!

!!longest qc operation (or job in the problem)
$set d1 2
$set d2 2
$set d3 3
$set agvs 4
$set lngstJob 5
$set qcs 3
!! The default number of qcs and blocks are set to 3 and 6. Therefore AL and AR each should have 12 members. I think the capacity of each block is 5 (bc of number of HPs)
!! However, for the first experiment:
!! blcoks = 6, QC = 3, AGVs = 3, containers = 13

Scalars

        S_Q "switch time for qc between two containers" /300/ !! temporarily assumed constant (take look at 6.1 and qc_double_cycle.svg)
        v "AGV speed" /4/
        Mnum "a very large number" /100000000/;

Sets
        i "index" /i0*i%lngstJob%/ !!
        i1(i) /#i/
        j(i) "a duplicate of i" /#i/ !!this is temporary, a better is to write /#i/

        m   "QC index" /m0*m%qcs%/
        n(m)   "A duplicate of j" /#m/ !!this is temporary, a better is to write /#m/

        L(m,i)   /m1.i2, m1.i3, m2.i2, m2.i4, m3.i2, m3.i4/ !! these are stored in ASC storage area, waiting to be placed in the ship by the QC
        D(m,i) "Unloading Containers. U is a subset of index i" /m1.i1, m2.i1, m2.i3, m2.i5, m3.i1, m3.i3, m3.i5/ !! these are in the ships, waiting to be taking to ASCs

        C(m,i)  "All  Containers" /m1.i2, m1.i3, m2.i2, m2.i4, m3.i2, m3.i4, m1.i1, m2.i1, m2.i3, m2.i5, m3.i1, m3.i3, m3.i5/ !! this is in data file, this should contain 0 node, too!
        Cd(m,i) "the last QC container job for all QCs" /m1.i%d1%, m2.i%d2%, m3.i%d3%/

        li "AGV index" /l1*l%agvs%/
        Bs(li) "set of all agvs" /#li/
        a   "AGV actions" /a0*a4/
        !! Below is written according to Fig 5. of base article
        WT(m,i,a) "set of total actions with virtual node" /#C.(a1,a2,a3,a4)/
        WV(m,i,a)  "Vertical Actions" /#C.a2/ !! those containing a2. Note that this set includes all the containers (m,i) in C(m,i)
        WH(m,i,a)  "Horizontal Actions" /#D.(a1,a3,a4), #L.(a1,a3,a4)/ !! those containing a1,a3,a4. Be sure to include virtual a0 in it.

*********************************************
*Location based sets
        XR (*)  "Vertical Operational Area" /1*35/
        YR (*) "Horizontal Operational Area" /1*10/
        YS(YR)  "Horizontal Seaside Operation Area" /6*10/
        YL(YR)  "Horizontal Path" /1*5/

        o(m,i,XR) / m1.i1.12,
                    m1.i2.13,
                    m1.i3.35,
                    m2.i1.20,
                    m2.i2.17,
                    m2.i3.24,
                    m2.i4.29,
                    m2.i5.20,
                    m3.i1.32,
                    m3.i2.3,
                    m3.i3.28,
                    m3.i4.23,
                    m3.i5.32/

*!!these sets refers right and left positions of the blocks in the fig. 4 of the article. (which is totally a wrong statement, it should contain membs of D(m,i), too!)
        A_L_set(XR) /1,7,13,19,25,31/
        A_R_set(XR) /5,11,17,23,29,35/
        A_L(m,i,XR) /#C.#A_L_set/
        A_R(m,i,XR) /#C.#A_R_set/


!! Maybe Badly Put! Needs fixing! In the data file!
        psi_1(m,i,m,i)   "sequence of Container jobs for QC" /
        m1.i1.m1.i2, m1.i2.m1.i3, m2.i1.m2.i2,  m2.i2.m2.i3, m2.i3.m2.i4, m2.i4.m2.i5,m3.i1.m3.i2,  m3.i2.m3.i3, m3.i3.m3.i4, m3.i4.m3.i5/
        
        psi_2(m,i,m,i)   "sequence of Container jobs for ASC" /m1.i2.m2.i2/ !!This is in data file. (m,i) and (m,i) belong to the same block!
        ;
parameter o1(m,i) "Merely a copy of the o(m,i,XR), with XR treated as a number"/
                    m1.i1 12,
                    m1.i2 13,
                    m1.i3 35,
                    m2.i1 20,
                    m2.i2 17,
                    m2.i3 24,
                    m2.i4 29,
                    m2.i5 20,
                    m3.i1 32,
                    m3.i2 3,
                    m3.i3 28,
                    m3.i4 23,
                    m3.i5 32/

*****************************************************************************************************************
*Dupilcates of the some of the sets!
alias (XR, XR1);
alias (XR, XR_1);
alias (YR, YR_1);
alias (a,a1);
alias (a,a2);
alias (a2,a2_1);
alias (a1,a1_1);
*alias (i,i1);
set h(m)/#m/;  !! for cnstr_3
set k(i) /#i/;
set s(YR);
set XR2(XR) /#XR/;
set x_t(XR) /#XR/;
*****************************************************************************************************************
Parameters

        G_Q(m,i)
        G_Y(m,i)
        ;
****************************************************************************************************************
G_Q(m,i) = uniform(60,90);
G_Y(m,i) = uniform(20,30);

Binary Variables
        z(m, i, m, i, li)   "used mainly for handling QC double cycling, it consists of 0 virtual point!" !! (m,i) and (m,i) are NOT equal, TOO!
        U_AGV(m,i,a,m,i,a)  "U_AGV(j_1,j_2) conducted before" !! note that (m,i,a) and (m,i,a) are NOT equal!!
        U_QC(m,i,m,i,a)   "U_QC(j,WT) conducted before"

*       Path related variables
        P_X(m,i,a,XR) "P_X(WV,x) finish V loc, These are defined on actions, NOT ON CONTAINERS!"
        P_Y(m,i,a,YR) "P_Y(WH,y) finish H loc, These are defined on actions, NOT ON CONTAINERS!"
        P_X0(m,i,a,XR) "P_X(WV,x) Start H  loc, These are defined on actions, NOT ON CONTAINERS!"
        P_Y0(m,i,a,YR) "P_Y(WH,y) Start H loc, These are defined on actions, NOT ON CONTAINERS!"
        ;
*****************************************************************************************************************
Positive Variables
*       Time related variables
        T_Q(m,i) "start time of QC"
        T_Y(m,i) "Start time of agv putting cont on ASC"
        T_start(m,i,a) "Start of agv for action (m,i,a)"
        CT(m,i)  "Op. completion time of for each QC m"

*       Auxiliary Variables
        t_AGV(m,i,a,m,i,a)        "t_AGV(WT_1,WT_2"
        X_position(m,i,a)   "X_position(WT)"
        Y_position(m,i,a)   "Y_position(WT)"
        ;
variable obj "objective function";
*****************************************************************************************************************

Equations

        ADRP                       "AGV Dispatching and Routing Problem"
        LJob(m,i)

*       Job assignment constraints
        cnstr_2(m,i)
        cnstr_3(m,i,li)             "C,B"
        cnstr_4(li)                 "B with 0 virtual node"
        cnstr_5(li)               ‌  "B with 0 virutal node"
        cnstr_6(m,i)                "L"
        cnstr_7(m,i)                "D"
**********************************************************************
*       Location constraints of AGV acitons
*        cnstr_8(m,i,n,j,XR)         "C,C,XR"
*        cnstr_8_slack(m,i,n,j)
        cnstr_8(m,i,n,j,xr)
        cnstr_8_1(m,i,n,j,xr)
        cnstr_9(m,i,n,j,YR)         "C,C,YR"
        cnstr_9_1(m,i,n,j,YR)         "C,C,YR"
        cnstr_10(m,i,a)             "C,a"
        cnstr_11(m,i,a)             "C,a"
        cnstr_12(m,i)               "L"
        cnstr_13(m,i)               "D"
        cnstr_14(m,i,XR)            "D"
        cnstr_15(m,i)               "L"
        cnstr_19(m,i)               "D"
        cnstr_16(m,i)               "D"
        cnstr_17(m,i)               "L"
        cnstr_18(m,i,XR)            "L"
        cnstr_20(m, i, a, a, YR)    "WH,YR"
        cnstr_21(m,i,a,a,XR)        "WV,XR"

**********************************************************************
*       Conflict Free Constraints
        cnstr_22(m,i,n,j)           "C,C"
        cnstr_23(m,i,a,n,j,a,YR,XR, a, a) "WH,WH,YR,XR" !!Look How many equations it would add to the model
        cnstr_24(m,i,n,j,a)         "C, WH"
        cnstr_25(m,i,n,j,a,a)       "C, WH"
        cnstr_26(n,j,a,YS,m,i,a,a)  "WH,YS,D"
        cnstr_27(m,i,a,n,j,a,XR)    "WV, XR"
        cnstr_28(m,i,a, a)          "C,a"
**********************************************************************
****Time Constraints
        cnstr_29(m,i,i)             "C,C"      !! two consecutive containers, i and i+1
        cnstr_30(m,i,m,i)           "psi_1"
        cnstr_31(m,i,m,i)           "psi_2"
        cnstr_32(m,i)               "D"
        cnstr_33(m,i)               "L"
        cnstr_34(m,i,m,i)           "D,L"
        cnstr_35(m,i,m,i)           "L,D"
        cnstr_36(m,i,a)             "D,a"
        cnstr_37(m,i,a)             "D,a"
        cnstr_38(m,i,a,a,n,j,a)     "WT,WT"
        cnstr_39(m,i,a,XR)          "C,a,XR"
        cnstr_39_1(m,i,a,XR)          "C,a,XR"
        cnstr_40(m,i,a,YR)          "C,a,YR"
        cnstr_40_1(m,i,a,YR)          "C,a,YR"
        cnstr_41(m,i,a,m,i,a)
        ;

**********************************************************************
*This determines whether the last container job is for QC or AGV
LJob(Cd).. CT(Cd) =e= max(T_Q(Cd)+G_Q(cd), T_Y(Cd)+G_Y(Cd));
*This constraint clarifies the lengthiest operation among all container jobs
ADRP.. obj  =e= smax(Cd, CT(Cd));

*****************************************************************************************************************
**Job assinment constraints
*as soon as you include conditional $(C(m,i)), you ignore virtual node!
*there are many actions, having a0 as their starting. a0 is not in the formulation in the article
cnstr_2(m,i) $(C(m,i)).. sum((li,n,j) $((C(n,j) and (not sameas(m,n) or not sameas(i,j))) or (sameas(n,'m0') and sameas(j, 'i0'))),  z(m,i,n,j,li)) =e= 1 ;

cnstr_3(m,i,li) $(C(m,i))..sum((n,j) $((C(n,j)and (not sameas(m,n) or not sameas(i,j))) or (sameas(n,'m0') and sameas(j, 'i0'))), z(n,j,m,i,li)) -sum((h,k) $(C(h,k) or (sameas(h,'m0') and sameas(k,'i0'))), z(m,i,h,k,li)) =e= 0;

cnstr_4(li).. sum((m,i) $(C(m,i)), z('m0', 'i0', m, i, li))=e= 1;
cnstr_5(li).. sum((m,i) $(C(m,i)), z(m, i, 'm0', 'i0', li))=e= 1;

cnstr_6(m,i) $(L(m,i)).. sum((li,n,j) $(D(n,j) or (sameas(n,'m0') and sameas(j,'i0'))), z(m,i,n,j,li))=e= 1 ;
cnstr_7(m,i) $(D(m,i)).. sum((li,n,j) $(L(n,j) or (sameas(n,'m0') and sameas(j,'i0'))), z(m,i,n,j,li))=e= 1 ;

cnstr_8(m,i,n,j,xr) $(c(m,i) and c(n,j) and (not sameas(m,n) or not sameas(i,j))).. abs(P_x(m,i,'a4',xR)- P_x(n,j,'a0',xR)) - Mnum*abs(1 - sum(li, z(m,i,n,j,li)))  =l= 0;
cnstr_8_1(m,i,n,j,xr) $(c(m,i) and c(n,j)and (not sameas(m,n) or not sameas(i,j))).. abs(P_x(m,i,'a4',xR) - P_x(n,j,'a0',xR)) + Mnum*abs(1 - sum(li, z(m,i,n,j,li))) =g= 0;

cnstr_9(m,i,n,j,yr) $(c(m,i) and c(n,j)and (not sameas(m,n) or not sameas(i,j))).. abs(P_Y(m,i,'a4',YR) - P_Y(n,j,'a0',yR)) - Mnum*abs(1 - sum(li, z(m,i,n,j,li)))  =l= 0;
cnstr_9_1(m,i,n,j,yr) $(c(m,i) and c(n,j)and (not sameas(m,n) or not sameas(i,j))).. abs(P_Y(m,i,'a4',YR) - P_Y(n,j,'a0',yR)) + Mnum*abs(1 - sum(li, z(m,i,n,j,li))) =g= 0;

cnstr_10(m,i,a) $(c(m,i)).. sum(XR, P_X(m,i,a,XR)) =e= 1;
cnstr_11(m,i,a) $(c(m,i)).. sum(YR, P_Y(m,i,a,YR)) =e= 1;

cnstr_12(m,i) $(L(m,i)).. sum(YL, P_Y(m,i,'a0',YL)) =e= 1;
cnstr_13(m,i) $(D(m,i)).. sum(YS, P_Y(m,i,'a0',YS)) =e= 1;

cnstr_14(m,i,XR) $(D(m,i) and o(m,i,XR)).. P_X(m, i,'a0',XR) =e= 1;
* A_L depends on container (m,i), it needs fixing, hence cnstr_15 and cnstr_19 and A_R
cnstr_15(m,i) $(L(m,i))..sum((A_L_set, A_R_set) $(ord(A_L_set) = ord(A_R_set)),sum(x_t $(x_t.val >= A_L_set.val and x_t.val<=A_R_set.val) ,P_X(m,i,'a0',x_t))) =e= 1; !!this ord shows forces the container to belong to one and only one block
cnstr_19(m,i) $(D(m,i))..sum((A_L_set, A_R_set) $(ord(A_L_set) = ord(A_R_set)) ,sum(x_t $(x_t.val >= A_L_set.val and x_t.val<=A_R_set.val) ,P_X(m,i,'a3',x_t))) =e= 1;

cnstr_16(m,i) $(D(m,i)).. sum(YL, P_Y(m,i,'a3',YL)) =e= 1;
cnstr_17(m,i) $(L(m,i)).. sum(YS, P_Y(m,i,'a3',YS)) =e= 1;
cnstr_18(m,i,XR) $(L(m,i) and o(m,i,XR)).. P_X(m, i,'a3',XR) =e= 1;

cnstr_20(m, i, a1, a1_1, YR) $(WH(m,i,a1) and (ord(a1_1) = ord(a1)-1)).. P_Y(m,i,a1,YR) =e= P_Y(m,i,a1_1,YR);
cnstr_21(m, i, a1, a1_1, XR) $(WV(m,i,a1) and (ord(a1_1) = ord(a1)-1))..P_X(m, i, a1, XR) =e= P_X(m,i,a1_1,XR);

*******************************************************************************************************************************************************************************************
****Conflict Free Constraints
cnstr_22(m,i,n,j) $(c(m,i) and c(n,j)).. U_AGV(m,i,'a4',n,j,'a1') =g= sum(li, z(m,i,n,j,li));
* wt(a1_1) and wt(a2_1) are computed here!
cnstr_23(m,i,a1,n,j,a2,YR,XR,a1_1,a2_1)$((ord(a1_1) = ord(a1) - 1) and (ord(a2_1) =  ord(a2) - 1) and WH(m,i,a1) and WH(n,j,a2) and (not sameas(m,n) or not sameas(i,j) or not sameas(a1,a2)))..U_AGV(m,i,a1,n,j,a2) + U_AGV(n,j,a2,m,i,a1) + 3 - P_Y(m,i,a1,YR) - P_Y(n,j,a2, YR) -(sum(XR1 $(XR1.val <= XR.val), P_X(m,i,a1_1,XR1) + P_X(n,j,a2,XR1) - P_X(m,i,a1,XR1) - P_X(n,j,a2_1,XR1))) =g= 0;
*
cnstr_24(m,i,n,j,a) $(C(m,i) and WH(n,j,a)).. T_Q(m,i) + G_Q(m,i) + Mnum*(1 - U_QC(m,i,n,j,a)) =g= T_start(n,j,a);
cnstr_25(m,i,n,j,a1, a1_1) $(C(m,i) and WH(n,j,a1) and (ord(a1_1)=ord(a1)-1)).. T_Start(n,j,a1) + t_AGV(n,j,a1_1,n,j,a1) + Mnum*(1 - U_QC(m,i,n,j,a1) ) =g= T_Q(m,i);
*
*!! YS is used in here!
cnstr_26(n,j,a2,YS,m,i,a1,a2_1) $( ( (sameas(a1, 'a0') and D(m,i)) or (sameas(a1, 'a3') and L(m,i)) ) and wh(n,j,a2) and (ord(a2_1)=ord(a2)-1))..(3 - U_QC(m,i,n,j,a2) - P_Y(m,i,a1,YS) - P_Y(n,j,a2,YS) +abs(sum(XR $(XR.val <= o1(m,i)), P_x(n,j,a2,XR)) - sum(XR $(XR.val > o1(m,i)), P_X(n,j,a2_1,XR)))) * Mnum +T_start(n,j,a2) + t_agv(n,j,a2_1,m,i,a1) =g= T_Q(m,i) + G_Q(m,i);
cnstr_27(m,i,a1,n,j,a2,XR) $(Wv(m,i,a1) and Wv(n,j,a2) and (not sameas(m,n) or not sameas(i,j) or not sameas(a1,a2))).. U_AGV(m,i,a1,n,j,a2) + U_AGV(n,j,a2,m,i,a1) =g= P_X(m,i,a1,XR) + P_X(n,j,a2,XR) - 1;
cnstr_28(m,i,a1, a1_1) $(C(m,i) and (sameas(a1,'a2') or sameas(a1,'a3') or sameas(a1,'a4')) and (ord(a1_1) = ord(a1) - 1)).. U_AGV(m,i,a1_1,m,i,a1) =e= 1;

*******************************************************************************************************************************************************************************************
***Time Constraints
cnstr_29(m,i,i1) $(c(m,i) and (ord(i1)=ord(i)+1) and c(m,i1)).. T_Q(m,i1) - T_Q(m,i) - G_Q(m,i) - S_Q=g= 0;
cnstr_30(m,i,n,j) $(psi_1(m,i,n,j)).. T_Q(n,j) =g= T_Q(m,i) + G_Q(m,i);
cnstr_31(m,i,n,j) $(psi_2(m,i,n,j)).. T_Y(n,j) =g= T_Y(m,i) +G_Y(m,i);

cnstr_32(m,i) $(D(m,i)).. T_y(m,i) =g= T_start(m,i,'a3') + t_AGV(m,i,'a2',m,i,'a3');
cnstr_33(m,i) $(L(m,i)).. T_Q(m,i) =g= T_start(m,i,'a3') + t_agv(m,i,'a2',m,i,'a3');

cnstr_34(m,i,n,j) $(D(m,i) and L(n,j))..T_y(n,j) + Mnum*(1 - sum(li, z(m,i,n,j,li))) =g= T_start(m,i,'a4') + t_agv(m,i,'a3',m,i,'a4');
cnstr_35(m,i,n,j) $(L(m,i) and D(n,j))..T_Q(n,j) + Mnum*(1 - sum(li, z(m,i,n,j,li))) =g= T_start(m,i,'a4') + t_agv(m,i,'a3',m,i,'a4');

cnstr_36(m,i,a) $( (D(m,i) and sameas(a,'a4')) or (L(m,i) and sameas(a,'a1')) )..T_start(m,i,a) =g= t_y(m,i) + G_y(m,i);
cnstr_37(m,i,a) $( (D(m,i) and sameas(a,'a1')) or (L(m,i) and sameas(a,'a4')) )..T_start(m,i,a) =g= t_Q(m,i) + G_Q(m,i);
cnstr_38(m,i,a1,a1_1,n,j,a2) $(WT(m,i,a1) and wt(n,j,a2) and (ord(a1_1) = ord(a1)-1) and (not sameas(m,n) or not sameas(i,j) or not sameas(a1,a2))).. T_start(n,j,a2) + Mnum*(1-U_AGV(m,i,a1,n,j,a2)) =g= T_start(m,i,a1) + t_AGV(m,i,a1_1,m,i,a1);

* THE BIG-M TRICK FOR IF-CONDITIONAL
cnstr_39(m,i,a,XR) $(C(m,i)).. x_position(m,i,a) - XR.val - Mnum *abs(1-P_X(m,i,a,XR)) =l= 0;
cnstr_39_1(m,i,a,XR) $(C(m,i)).. x_position(m,i,a) - XR.val + Mnum *abs(1-P_X(m,i,a,XR)) =g= 0;
cnstr_40(m,i,a,YR) $(C(m,i)).. y_position(m,i,a) - YR.val  -Mnum *abs(1-P_Y(m,i,a,YR)) =l= 0;
cnstr_40_1(m,i,a,YR) $(C(m,i))..  y_position(m,i,a) - YR.val  +Mnum *abs(1-P_Y(m,i,a,YR)) =g= 0;
****************************************
* Just writing the switch time between actions according the position of the start and finish locaiton of the action and AGVs next aciton
*and the speed of the vehicle which is constant. Which might be bad!!
cnstr_41(m,i,a1,n,j,a2) $(c(m,i) and c(n,j)).. t_agv(m,i,a1,n,j,a2) - (abs(x_position(m,i,a1) - x_position(n,j,a2)) + abs(Y_position(m,i,a1) - y_position(n,j,a2)))/v =e= 0;
****************************************

Model ConflictFreeSch /all/ ;
option SOLVER = Gurobi;

* This is for detecting a set of Irredicuible Infeasible Solutions; Gurobi-specific:
*$onEcho > CFS.opt
*iis 1
*indic cnstr_8(m,i,n,j,XR)$slack(m,i,n,j) 1
*$offEcho
*ConflictFreeSch.Optfile = 1;
solve conflictfreesch using MINLP min obj;




*Option MIP = COPT;
*Model ConflictFreeSch /adrp3, cnstr_2, cnstr_3, cnstr_4, cnstr_5, cnstr_6, cnstr_7/ ;
*Solve ConflictFreeSch using mip minimizing slack1;
*display z.l;
*Solve ConflictFreeSch using mip minimizing slack1;
*display z.l;
*$gdxout BBAPP
*$unload
*$gdxout
*Display x.l, x.m ;





































































