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
Sets
    t1 /1,3,5/
    t2 /2,4,6/
    t3(t1,t2) /#t1.#t2/
    t4 /7,9,11/
    t4_p(t4) /7/
    t5(t1,t2,t4) /#t3.#t4_p/
    ;
display t5;
x.l = 0;

y $(x.l = 1) = 20;
display y;
$set d 20
display 'hi';
set i /i1*i%d%/;
variable x4;
set i54(*);
set tre /1*9/;
equation q9;
q9.. x4 =e= sum(tre $(tre.val < 6), 1);

display i;
equation eq1,eq2,eq3;
p.up = 100;
p.lo = 0;
set jh(i,*) /i1.56, i2.1, i2.56/;
jh('i1','hello')= yes;
display jh;
scalar iuiu;
iuiu = 9;
variables x1,x2;
x1.up = 10000;
x1.lo = 2;
x2.lo = 1;
display x2.l;
*x1.l = x2.l + 1  $(x1.l>=0);
eq2.. x2*x2 =l= 1100;
eq3..  x1 - 1 =e= x2 $(x2.l < 10) + 9 ;
eq1.. u  =e=  sum(j , a1(j));

set t55 /1*8/;
set t66(t55) /4*6/;
equation eq5(t55);
variable test;
eq5(t66).. test =e= 1;

Model er /all/;
solve er using minlp maximizing x1;
display x1.l, x2.l;

















