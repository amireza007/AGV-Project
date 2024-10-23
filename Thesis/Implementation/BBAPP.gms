$Title  A branch and bound problem (TRNSPORT,SEQ=1)

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

Scalars
        S_Q "switch time for qc between two containers" /2/ $ "This is temporarily assumed constants"
        x /1/
        y /1/
        x_R /10/
        y_R /14/
        y_r /10/
        v "AGV speed" /1/
        ;
Sets
        i   "containter jobs" /1*4/
        j "a duplicate of i" /1*4/
        m   "QC index" /1,2/
        n "A duplicate of m" /1,2/
        
        l   "AGV index" /1*3/
        B(l)    "set of All AGVs" /l/ $ "This is in data file"

        a   "AGV actions" /0*4/
        a_1(a) "A duplicate of a" /0*4/
        a_2(a) "A duplicate of a" /0*4/

        XR  "Vertical Operational Area" /1*x_R/
        YR  "Horizontal Operational Area" /1*y_R/
        YS  "Horizontal Seaside Operation Area" /11*14/
        YL  "Horizontal Path" /1*10/

        
        L(i)   "Loading Containers. L is a subset of index i" /1, 2/
        D(i) "Unloading Containers. U is a subset of index i" /3, 4/ 
        C(i)   "All  Containers" /L+D/ $ "this is in data file"
*        C_prime(i) "The set of containers to be assigned" $ "This is in data file" 

        $ "I suppose j_1 and j_2 could be written by alias"
        j "set of all container jobs and qc" /#m.#i/
        
        j_1(j) "set of container jobs and qc"
        j_2(j) "Another set of container jobs and QC"

        WT(m,i,a) "set of total actions" /#m.#i.#a/
        WV(WT)  "Vertical Actions" //
        WH(WT)  "Horizontal Actions" //

        psi_1(j_1,j_2)   "Sequence of Container jobs for QC" // $ "This is in data file"
        psi_2(j_1,j_2)   "Sequence of Container jobs for ASC" // $ "This is in data file"
        ;
        
j_1(j)=YES;
j_2(j) = YES;

Parameters
        
        O() //
        A_L(j) //
        A_R(j) //
        G_Q(j) //
        G_Y(j) //
        ;

$hidden Data
$ontext
Table d(i,j)  distance in thousands of miles
                    new-yorksdafasdf       chicago      topeka
      seattle          2.5           1.7          100.8
      san-diego        2.5           1.8          1.4  ;
$offtext  

Variables
        Z(j_1,j_2,l)           "QC double cycling"
        U_AGV(j_1,j-2) "conducted before" 
        U_QC(j,WT)        "conducted before"
        
        $ "Path related variables"
        P_X(m,i,a,x) "finish V loc"
        P_Y(m,i,a,y) "finish H loc"
        P_X(m,i,0,x) "Start H loc"
        P_Y(m,i,0,y) "Start H loc"
        
        $ "Time related variables"
        T_Q(m,i) "start time of QC"
        T_Y(m,i) "Start time of agv putting cont on ASC"
        T_start(m,i,a) "Start of agv for action (m,i,a)"
        

        $ "Auxiliary Variables"
        t_AGV(m,i,a_1,n,j,a_2)
        X_position(m,i,a)
        Y_position(m,i,a)
        ;

*  Positive Variable x ;

Equations
        cost        define objective function
        supply(i)   observe supply limit at plant i
        demand(j)   satisfy demand at market j ;

cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;

Model transport /all/ ;

Solve transport using lp minimizing z ;

Display x.l, x.m ;

