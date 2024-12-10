$title 'GUROBI test suite - general constraints max,min,abs' (GUROBI02,SEQ=709)
$onText
Contributor: Michael Bussieck
$offText

$set   genconstrMax    1
$set   genconstrMin    2
$set   genconstrAbs    3

variable obj, x, y, z, r;
equation defobj, defmax, defmin, defabs;

defobj.. obj =e= r;
defmax.. r =e= x + y + z - 1e3;
defmin.. r =e= x + y + z + 1e3;
defabs.. r =e= x;

model mmax / defmax, defobj /;
model mmin / defmin, defobj /;
model mabs / defabs, defobj /;

x.lo = -4; x.up = 3;
y.lo = -2; y.up = 5;
z.lo = -5; z.up = 5;

$echo defmax.genConstrType %genconstrMax% > gurobi.opt
$echo defmin.genConstrType %genconstrMin% > gurobi.op2
$echo defabs.genConstrType %genconstrAbs% > gurobi.op3

option solver=gurobi;

mmax.optfile = 1; solve mmax min obj using lp;
abort$(abs(r.l+2)>1e-6) 'failed to solve mmax';
mmin.optfile = 2; solve mmin max obj using lp;
abort$(abs(r.l-3)>1e-6) 'failed to solve mmin';
mabs.optfile = 3; solve mabs max obj using lp;
abort$(abs(r.l-4)>1e-6) 'failed to solve mabs';
