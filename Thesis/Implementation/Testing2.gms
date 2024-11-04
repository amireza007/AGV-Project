$onEolCom
scalar r /10/;
set i "set of all" / i1*i12 /;
set j /j1/;
set c(i,j) /#i.#j/;
set a /1,2,3,4/;
*set o "llasdjfl" /i\set(i1)/; !!another way is by writing /(set.c).(set.a)/
c('i1','j1') = no;
set q(i,j,a);
alias(i,i_1);
sets
    p /1/ !!alaskdkjflsdf /3fasdfsdaaaaaasdfdsfi/
    v /3/
    ;

set l /j1,j2/; !!this is /s/
set k;
k(i) = yes;
k(j) = yes;
display k;
parameter
    f(i) "hi" / i1 1 / 
    g(i_1) / i1 1 /;
loop(i$(ord(i)>=2),
  f(i) = f(i-2) + f(i-1);
);
set z /#i,#j/;
display z;
set y(i,j) /i1.j1, i2.j1/;
set z1 /#y, 0.0/;
display z1;
variable x;
set oi /1/;
equation eq_2(i,j);
eq_2(i,j) $(y(i,j)).. x $(y(i,j))  =e= sum(oi, 10);

equation eq_1;
eq_1.. x =e= sum((i,j)$(y(i,j)), 1);
Model ww /all/;
solve ww using lp minimizing x;
$gdxout testing2
$unload i j
$unload f g eq_2
$gdxout