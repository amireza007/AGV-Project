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
        y_r /10/
        v "AGV speed" /1/
        ;
Sets
       
        i "container index" /i1*i4*/
        j "a duplicate of i" /j1*j4/ !!this is temporary, a better is to write /#i/

        m   "QC index" /m1,m2/
        n   "A duplicate of j" /n1,n2/ !!this is temporary, a better is to write /#m/

        l "AGV index" /l1*l3/

*       0 in a is a virtual starting point
        a   "AGV actions" /a0*a4/

        XR  "Vertical Operational Area" /x1*x10/
        YR  "Horizontal Operational Area" /y1*y14/
        YS  "Horizontal Seaside Operation Area" /y11*y14/
        YL  "Horizontal Path" /y1*y10/

        L(m,i)  "Loading Containers. L is a subset of index i" //
        D(m,i) "Unloading Containers. U is a subset of index i" // 
        C   "All  Containers" /C+D/ $ "this is in data file"
*        C_prime(i) "The set of containers to be assigned" $ "This is in data file" 

        
        
        WT(m,i,a) "set of total actions" /#C.#a/
        WV(m,i,a)  "Vertical Actions" //
        WH(m,i,a)  "Horizontal Actions" //

*       or psi_1(m,i,m,i)?
*very challenging set!
        psi_1(m,i,n,j)   "Sequence of Container jobs for QC" // !!This is in data file. This identifies the container job sequence, (in a form of 2d graph?)idk
        psi_2(m,i,n,j)   "Sequence of Container jobs for ASC" // !!This is in data file. 
        ;
        
alias(l,B); !!set of All AGVs, merely a duplicate of l

alias(a,a_1);
alias(a,a_2);
alias(m,n);
alias(j,j_1); !!set of container jobs and qc
alias(j,j_2); !!Another set of container jobs and QC

alias (WT, WT_1);
alias (WT, WT_2);

Parameters
        
        O(j) //
        A_L(j) //
        A_R(j) //
        G_Q(j) // !!seems to be constant for all container jobs, bc of const 24
        G_Y(j) //
        ;

$hidden Data
$ontext
Table d(i,j)  distance in thousands of miles
                    new-yorksdafasdf       chicago      topeka
      seattle          2.5           1.7          100.8
      san-diego        2.5           1.8          1.4  ;
$offtext  

Binary Variables

        Z(m,i,l)        "used mainly for handling QC double cycling"
        U_AGV(j_1,j_2)      "conducted before" 
        U_QC(j,WT)          "conducted before"
        
*       Path related variables
        P_X(WV,x) "finish V loc"
        P_Y(WH,y) "finish H loc"
        P_X(WV,x) "Start H loc"
        P_Y(WH,y) "Start H loc";

Positive Variables:

*       Time related variables
        T_Q(m,i) "start time of QC"
        T_Y(m,i) "Start time of agv putting cont on ASC"
        T_start(WT) "Start of agv for action (m,i,a)"
        

*       Auxiliary Variables
        t_AGV(WT_1,WT_2)
        X_position(WT)
        Y_position(WT)
        ;

*  Positive Variable x ;

Equations
        ADRP        1st equation, AGV Dispatching and Routing Problem

*       Job assignment constraints
        eq_2               C            Equation 2(C)
        eq_3               C,B      
        eq_4               B         
        eq_4               L         
        eq_5               D         
        eq_6               L         
        eq_7               D         
        eq_8               C,C,XR        
        eq_9               C,C,YR    
        eq_10              C,a     
        eq_11              C,a      
        eq_12              L        
        eq_13              D        
        eq_14              D        
        eq_15              L
        eq_16              D
        eq_17              L
        eq_18              L
        eq_19              D
        eq_20              WH,YR
        eq_21              WV,XR
        eq_22              C,C
        eq_23              WH,YR,XR
        eq_24              C, WH
        eq_25              C, WH
        eq_26              WH,YS,D  !!for alpha = 0
        eq_26_prime        L  !!for alpha = 3, try the actual definintin of the equation with conditions and ord(I)
        eq_27              WV, XR
        eq_28              C,a      !!alpha>2
        eq_29              C,C      !! two consecutive containers, i and i+1
        eq_30              psi_1
        eq_31              psi_2
        eq_32              D
        eq_33              L
        eq_34              D,L
        eq_35              L,D
        eq_36              D,a      !!alpha=4
        eq_36_prime        L,a     !!alpha=1
        eq_37              D,a      !!alpha=1
        eq_37_prime        L,a     !!alpha=4
        eq_38              WT,WT
        eq_39              C,a,XR
        eq_40              C,a,YR
        eq_41              C,C,a,a
        ;

eq_2.. sum((m,i) $(C(m,i)), 
Model transport /all/ ;

Solve transport using lp minimizing z ;

Display x.l, x.m ;

