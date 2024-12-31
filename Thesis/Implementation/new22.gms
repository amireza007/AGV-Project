binary variable p1,p2;
set i /1*4/;
set ii /1*3/;
binary variable z(ii);
set oo /slack, w/;
variable slack;
variable x(i);
variable ind(oo);
SOS1 variable x, ind;
equation defBinarySOS1;
defBinarySOS1.. sum(i,x(i)) =e= 1; 
binary variable w;
equation eq1, eq2, eq3, indOn, indOff;
x.up(i) = 1;
x.lo(i) = 0;
eq1.. sum(ii,z(ii)) =e= sum (i,i.val*x(i));
eq2.. w =e= x('1');
eq3.. abs(p1-p2) =e= slack;
indOn.. ind('slack') =e= slack;
indOff.. ind('w') =e= w;

variable obj;
equation costFunc;
costFunc.. obj =g= sum(ii,z(ii)) ;
Model hello /all/;

Solve hello using MINLP minimizing obj; 