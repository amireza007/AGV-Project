$onEolCom
scalar r /10/; !! alksdfj;lkasdjf
set i "set of all" / i1*i12 /;
set j /j1/;
set c(i,j) /#i.#j/;
set a /1,2,3,4/;
*set o "llasdjfl" /i\set(i1)/; !!another way is by writing /(set.c).(set.a)/
c('i1','j1') = no;
set q(i,j,a);
alias(i,i_1);
sets
    p /1/ 
    v /3/
    ;
set l /j1,j2/; !!this is /s/
set k;
k(i) = yes;
k(j) = yes;
display k;
set t1(i) /i6/;
set gh /h1,h2,h4/;
set gh2(gh) /h1,h2/;

set gh1(gh,i) /#gh2.#i/;
t1('i2') = Yes;
alias(j,t2);
parameter
    f(i) "hi" / i1 1 / 
    g(i_1) / i1 1 /;
loop(i$(ord(i)>=2),
  f(i) = f(i-2) + f(i-1);
);
set z /#i,#j/;
display z;
set y(i,j);
alias (i,iii);
set ii(i) /i1,i2/;
y(ii,j) = yes;
variable oi(iii);
variable x;
equation eq_2(ii,i,j);
eq_2(ii,i,j) $(not sameas(i,'i1') and not sameas(i,'i2') and y(ii,j)).. x =e= sum(iii $(sameas(iii,'i1')), oi(iii));
*display set.i;
equation eq_1;
eq_1.. x =e= sum((i,j)$(y(i,j)), 1);
Model ww /all/;
solve ww using lp minimizing x;

$gdxout testing2
$unload i j
$unload f g eq_2
$gdxout