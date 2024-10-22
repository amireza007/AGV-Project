$Title  A branch and bound problem (TRNSPORT,SEQ=1)

  Sets
        i   containter jobs /1*4/
        m   QC index /1,2/
        L(i)   Loading Containers  / 1,2 /
        D(i)   Unloading Containers  / 3,4 /
        C   All  Containers /L+D/ $ "this is in data file"
        C_prime The set of containers to be assigned $ "This is in data file"
        a   AGV actions /0*4/
        WV(m,i,a)  Vertical Actions /2/
        WH(m,i,a)  Horizontal Actions /1,3,4/
        l   AGV index /1*3/
        B(l)    All AGVs /1,2,3/ $ "This is in data file"
        
        XR  Vertical Operational Area /1*10/
        YR  Horizontal Operational Area /1*14/
        YS  Horizontal Seaside Operation Area /11*14/
        YL  Horizontal Path /1*10/
        psi_1()   Sequence of Container jobs for QC // $ "This is in data file"
        psi_2()   Sequence of Container jobs for ASC // $ "This is in data file"
        ;

  Parameters
        O(m,i)
        A_L(m,i)
        A_R(m,i)
        G_Q(m,i)
        G_Y(m,i)
        
       a(i)  capacity of plant i in cases
         /    seattle     350
              san-diego   0  /

       b(j)  demand at market j in cases
         /    newssss-york    325
              chicago     300
              topeka      275  / ;

$hidden Data
  Table d(i,j)  distance in thousands of miles
                    new-yorksdafasdf       chicago      topeka
      seattle          2.5           1.7          100.8
      san-diego        2.5           1.8          1.4  ;

  Scalars
        S_Q switch time for qc between two containers /2/ $ "This is temporarily assumed constants"
        x_R /10/
        y_R /14/
        y_r /10/
        v AGV speed /1/
        ;


  Variables
        Z(m,i,n,j,l) QC double cycling
        U_AGV(m,i,a_1,n,j,a_2)
        U_QC(m,i,n,j,a)
        
        $ "Path related variables"
        P_X(m,i,a,x)
        P_Y(m,i,a,y)
        P_X(m,i,0,x)
        P_Y(m,i,0,y)
        
        $ "Time related variables"
        T_Q(m,i)
        T_Y(m,i)
        T_start(m,i,a)
        

        $ "Auxiliary Variables"
        t_AGV(m,i,a1,n,j,a2)
        X_position(m,i,a)
        Y_position(m,i,a)
        ;


  Positive Variable x ;

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

