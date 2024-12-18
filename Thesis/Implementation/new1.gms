option solver =  Gurobi;

set i /1,2,3,4/;
variables x(i), y(i);
set j /1/;
variable obj;

scalar s /5/;
equation eq1;
eq1.. obj =e=
abs(x('1'));
set xr /1,4,33,90/;
scalar t /900/;
display xr.val;
Model md /all/;

$onecho > gurobi.opt
funcnonlinear 1
scaleflag 2
$offecho
md.optfile = 1;
solve md using DNLP min obj;
