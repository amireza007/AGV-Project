$title XPRESS test suite - solution pool example (XPRESS03,SEQ=548)

$onText

A simple version of a facility location problem is used to show how the
solution pool and the tools associated with it work. This example is taken
from the Cplex 11 User's Manual (ILOG, Cplex 11 User's Manual, 2007)

A company is considering opening as many as four warehouses in order to serve
nine different regions. The goal is to minimize the sum of fixed costs
associated with opening warehouses as well as the various transportation
costs incurred to ship goods from the warehouses to the regions.

Whether or not to open a warehouse is represented by binary variable ow.
Whether or not to ship goods from warehouse i to region j is represented
by binary variable oa.

Each region needs a specified amount of goods, and each warehouse can store
only a limited quantity of goods. In addition, each region must be served
by exactly one warehouse.


The following GAMS program demonstrates how to collect the solutions
found during optimization with GAMS/XPRESS.  GAMS/XPRESS will store the
individual solutions in GDX containers/files which can then be further
used by other programs or the same GAMS run.  GAMS/XPRESS will name
these GDX containers 'soln_loc_sNN.gdx', where NN will be the serial
number of the solution found.  To manage the different solutions, the
names of the GDX containers created by GAMS/XPRESS will be stored in
solnpool.gdx in the set 'index' using the set elements file*.

$offText

Set i    warehouses   / w1*w4 /
    j    regions      / r1*r9 /
Parameters
    f(i) fixed costs  / w1 130, w2 150, w3 170, w4 180 /
    c(i) capacity     / w1  90, w2 110, w3 130, w4 150 /
    d(j) demand       / r1 10, r2 10, r3 12, r4 15, r5 15,
                        r6 15, r7 20, r8 20, r9 30 /;

Table t(j,i) transport costs
        w1   w2   w3   w4
    r1  10   30   25   55
    r2  10   25   25   45
    r3  20   23   30   40
    r4  25   10   26   40
    r5  28   12   20   29
    r6  36   19   16   22
    r7  40   39   22   27
    r8  75   65   55   35
    r9  34   43   41   62;

Variables
    totcost    total cost
    fcost      fixed cost
    tcost      transportation cost
    ow(i)      indicator for open warehouse
    oa(i,j)    indicator for open shipment arc warehouse to region
Binary variables ow, oa;

Equations
    deftotcost definition total cost
    deffcost   definition fixed cost
    deftcost   definition transportation cost
    defwcap(i) limit utilization of warehouse by its capacity
    onew(j)    only one warehouse per region
    defow(i,j) warehouse open if shipment from i to j;

deftotcost.. totcost =e= fcost + tcost;

deffcost..   fcost =e= sum(i, f(i)*ow(i));

deftcost..   tcost =e= sum((i,j), t(j,i)*oa(i,j));

defwcap(i).. sum(j, d(j)*oa(i,j)) =l= c(i);

onew(j)..    sum(i, oa(i,j)) =e= 1;

defow(i,j).. ow(i) =g= oa(i,j);

Model loc /all/ ;


* --- Define sets, parameters and files to hold solutions

Sets soln           possible solutions /file1*file1000/
     solnpool(soln) actual solutions;
Scalar cardsoln     number of solutions;

Alias (soln,s1,s2), (*,u);
Parameters
    owX(soln,i)    warehouse indicator by solution
    oaX(soln,i,j)  arc indicator by solution
    xcostX(soln,*) cost structure by solution;
files fsoln, fopt / xpress.opt /;
option limrow=0, limcol=0;
option optcr=0;
option mip=xpress;
loc.optfile=1; loc.solprint=%solPrint.quiet%; loc.savepoint = 1;

putclose fopt 'solnpool solnpool.gdx';
solve loc min totcost using mip;

execute_load 'solnpool.gdx', solnpool=index;
cardsoln = card(solnpool); display cardsoln;
oaX(soln,i,j) = 0; owX(soln,i) = 0; xcostX(soln,u) = 0;
loop(solnpool(soln),
  put_utility fsoln 'gdxin' / solnpool.te(soln);
  execute_loadpoint;
  oaX(soln,i,j)             = round(oa.l(i,j));
  owX(soln,i)               = round(ow.l(i));
  xcostX(soln,'totcost')    = totcost.l;
  xcostX(soln,'tcost')      = tcost.l;
  xcostX(soln,'fcost')      = fcost.l;
);
* Restore the solution reported to GAMS
execute_loadpoint 'loc_p.gdx';

display xcostX;
