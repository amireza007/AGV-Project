scalar a, b;
a = 10;
variable u;
set j /1*3/;
Binary variable a1(j), p;
a1.up(j) = 1;
a1.lo(j) = 0;
scalar tt;
if (a1.l('1') <> 0,
    tt = a1.l('1');
else
    tt = a1.l('1');
    display 'this is tt: ', tt;
);
variables x;
scalar y;
x.l = 1;

y $(x.l = 1) = 10;  
display y;

x.l = 0;

y $(x.l = 1) = 20;
display y;

display 'hi';

equation eq1;
p.up = 100;
p.lo = 0;
a1('1') = a1('2');
eq1.. u  =e=  sum(j , a1(j));
Model er /all/;
solve er using mip maximizing u;
display x.l;