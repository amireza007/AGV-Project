binary variable p1,p2;
set i /1*4/;
set ii /1*3/;
binary variable z(ii);
set oo /slack, w/;
variable slack;
variable x(i);
variable ind(oo);
sos1 variable x, ind;
x.l(i)  = 9 $(not sameas (i, '1'));
x.l('1') = 1;
equation defBinarySOS1;
defBinarySOS1.. sum(i,x(i)) =e= 1;
slack.l = 0;

binary variable w;
w.l = 1;
equation eq1, eq2, eq3, indOn, indOff;
x.up(i) = 1;
x.lo(i) = 0;
eq1.. sum(ii,z(ii)) =e= sum (i,i.val*x(i));
eq2.. w =e= x('1');
eq3.. abs(p1-p2) =e= slack;
indOn.. ind('slack') - slack =e= 0;
indOff.. ind('w') =e= w;

variable obj;
equation costFunc;
costfunc.. obj =e= sum(ii, z(ii));

variable ht1, ht2, y1, y2;

Model hello /all/;

Solve hello using MINLP max obj;
execute_unload 'THEFILE';
display ind.l;

