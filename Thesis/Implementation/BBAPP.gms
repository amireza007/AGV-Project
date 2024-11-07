$Title  A branch and bound problem (TRNSPORT,SEQ=1)

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
        S_Q "switch time for qc between two containers" /2/ !!This is temporarily assumed constant
        x /1/
        y /1/
        x_R /10/
        y_R /14/
        y_r1 /10/
        v "AGV speed" /1/
        ;
Sets
       
        i "container index" /i0*i4/
        j(i) "a duplicate of i" /#i/ !!this is temporary, a better is to write /#i/
        
        m   "QC index" /m0,m1,m2,m3,m4/        
        n(m)   "A duplicate of j" /#m/ !!this is temporary, a better is to write /#m/
        
        li "AGV index" /l1*l3/
        Bs(li) "set of all agvs" /#li/
        
*       0 in a is a virtual starting point
        a   "AGV actions" /a0*a4/

        XR  "Vertical Operational Area" /x1*x10/
        YR  "Horizontal Operational Area" /y1*y14/
        YS  "Horizontal Seaside Operation Area" /y11*y14/
        YL  "Horizontal Path" /y1*y10/

        L(m,i)   /m1.i1 , m2.i2/
        D(m,i) "Unloading Containers. U is a subset of index i" /m3.i3,m4.i4/ 
        C(m,i)  "All  Containers" /m1.i1 , m2.i2,m3.i3,m4.i4/ !! this is in data file
*        C_prime(i) "The set of containers to be assigned" $ "This is in data file" 

        
        
        WT(m,i,a) "set of total actions" /#C.#a/
        WV(m,i,a)  "Vertical Actions" /m1.i1.a1/
        WH(m,i,a)  "Horizontal Actions" /m1.i2.a2/

*       or psi_1(m,i,m,i)?
*very challenging set!
        psi_1(m,i,n,j)   "Sequence of Container jobs for QC" /m1.i1.m2.i3/ !!This is in data file. This identifies the container job sequence, (in a form of 2d graph?)idk
        psi_2(m,i,n,j)   "Sequence of Container jobs for ASC" /#psi_1/ !!This is in data file. 
        ;
        

alias(a,a_2);
alias(j,j_1); !!set of container jobs and qc
alias(j,j_2); !!Another set of container jobs and QC

alias (WT, WT_1);
alias (WT, WT_2);

Parameters
        
        O(j) /i1 1/
        A_L(j) /i1 1/
        A_R(j) /i1 1/
        G_Q(j) /i1 1/ !!seems to be constant for all container jobs, bc of const 24
        G_Y(j) /i1 1/
        ;

$hidden Data
$ontext
Table d(i,j)  distance in thousands of miles
                    new-yorksdafasdf       chicago      topeka
      seattle          2.5           1.7          100.8
      san-diego        2.5           1.8          1.4  ;
$offtext  

Binary Variables

        z(m,i,n,j,li) "used mainly for handling QC double cycling, it consists of 0 virtual point!"
        U_AGV(j_1,j_2) "U_AGV(j_1,j_2) conducted before" 
        U_QC(j,m,i,a) "U_QC(j,WT) conducted before"
        
*       "Path related variables
        P_X(m,i,a,XR) "P_X(WV,x) finish V loc"
        P_Y(m,i,a,YR) "P_Y(WH,y) finish H loc"
        P_X(m,i,a,XR) "P_X(WV,x) Start H loc"
        P_Y(m,i,a,YR)"P_Y(WH,y) Start H loc"
        ;

Positive Variables

*       Time related variables
        T_Q(m,i) "start time of QC"
        T_Y(m,i) "Start time of agv putting cont on ASC"
        T_start(m,i,a) "Start of agv for action (m,i,a)"
        

*       Auxiliary Variables
        t_AGV(m,i,a) "t_AGV(WT_1,WT_2"
        X_position(m,i,a) "X_position(WT)"
        Y_position(m,i,a) "Y_position(WT)"
        ;

*  Positive Variable x ;

Equations
        ADRP        1st equation, AGV Dispatching and Routing Problem

*       Job assignment constraints
        eq_2(m,i)               C            Equation 2(C)
        eq_3(m,i,li)            "C,B"      
        eq_4(li)                B with 0 virtual node         
        eq_5(li)               ‌ B with 0 virutal node         
        eq_6(m,i)               L         
        eq_7(m,i)               D         
        eq_8(m,i,n,j,XR)               "C,C,XR"        
        eq_9(m,i,n,j,YR)               "C,C,YR"    
        eq_10(m,i,a)              "C,a"     
        eq_11(m,i,a)              "C,a"      
        eq_12(m,i)              "L"        
        eq_13(m,i)              "D"        
        eq_14(m,i)              "D"        
        eq_15(m,i)              "L"
        eq_16(m,i)              "D"
        eq_17(m,i)              "L"
        eq_18(m,i)              "L"
        eq_19(m,i)              "D"
        eq_20(m,i,a,YR)              "WH,YR"
        eq_21(m,i,a,XR)              "WV,XR"
        eq_22(m,i,n,j)              "C,C"
        eq_23(m,i,a,n,j,a,YR,XR)              "WH,WH,YR,XR"
        eq_24(m,i,n,j,a)              "C, WH"
        eq_25(m,i)              "C, WH"
        eq_26(n,j,a,YS,m,i)              "WH,YS,D"  !! for alpha = 0
        eq_26_prime(n,j,a)        "L"  !! for alpha = 3, try the actual definition of the equation with conditions and ord(I)
        eq_27              "WV, XR"
        eq_28              "C,a"      !!alpha>2
        eq_29              "C,C"      !! two consecutive containers, i and i+1
        eq_30              "psi_1"
        eq_31              "psi_2"
        eq_32              "D"
        eq_33              "L"
        eq_34              "D,L"
        eq_35              "L,D"
        eq_36              "D,a"      !!alpha=4
        eq_36_prime        "L,a"     !!alpha=1
        eq_37              "D,a"      !!alpha=1
        eq_37_prime        "L,a"     !!alpha=4
        eq_38              "WT,WT"
        eq_39              "C,a,XR"
        eq_40              "C,a,YR"
        eq_41              "C,C,a,a"
        ;

*ADRP.. ;
set h(n)/#m/;
set k(j) /#i/;
eq_2(m,i) $(C(m,i) and not sameas(i,'i0') and not sameas(m,'m0')).. sum((li,n,j) $C(n,j),  z(m,i,n,j,li)) =e= 1;
eq_3(m,i,li) $(C(m,i)).. sum((n,j), z(m,i,n,j,li)) =e= sum((h,k), z(m,i,h,k,li));

*eq_4(l) $(Bs(li)).. sum((m,i)$C(m,i), z('m0','i0',m,i,l) =e= 1 ;
*eq_5(l) $(Bs(li)).. sum((



 
*Model transport /all/ ;

*Solve transport using lp minimizing z ;

*Display x.l, x.m ;

