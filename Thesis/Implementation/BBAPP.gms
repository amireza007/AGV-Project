$Title  A branch and bound problem (TRNSPORT,SEQ=1)

  Sets
        i   containter jobs /1*4/
        m   QC index /1,2/
        L(i)   Loading Containers  / 1,2 /
        D(i)   Unloading Containers  / 3,4 /
        C   All  Containers /L+D/
        a   AGV actions /0*4/
        WV(a)  Vertical Actions /2/
        WH(a)  Horizontal Actions /1,3,4/
        l   AGV index
        B(l)    All AGVs /1,2,3/
        XR  Vertical Operational Area /1*10/
        YR  Horizontal Operational Area /1*14/
        YS  Horizontal Seaside Operation Area /11*14/
        YL  Horizontal Path /1*10/
        psi_1()   Sequence of Container jobs for QC //
        psi_2()   Sequence of Container jobs for ASC //
        ;

  Parameters

       a(i)  capacity of plant i in cases
         /    seattle     350
              san-diego   0  /

       b(j)  demand at market j in cases
         /    newssss-york    325
              chicago     300
              topeka      275  / ;

  Table d(i,j)  distance in thousands of miles
                    new-yorksdafasdf       chicago      topeka
      seattle          2.5           1.7          100.8
      san-diego        2.5           1.8          1.4  ;

  Scalars
        x_R /10/
        y_R /14/
        y_r /10/
        v AGV speed /1/
        ;

  Parameter c(i,j)  transport cost in thousands of dollars per case ;

            c(i,j) = f * d(i,j) / 1000 ;

  Variables
       x(i,j)  shipment quantities in cases
       z       total transportation costs in thousands of dollars ;

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

