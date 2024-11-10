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
set kk /2/;
set o(i,j,kk) /i1.j1.2/;
*display kk $(1);

set l /j1,j2/; !!this is /s/
set k;
k(i) = yes;
display k;
set t1(i) /i6/;
set gh /h1,h2,h4/;
set gh2(gh) /h1,h2/;
*set ij(i,j)(i) /i1 /;
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
Set ll / l1*l5 /;
display y;

* This will display only the third element
*k(i) $(ord(i) = o('i1','j1')) = no;
variable oi(iii);
variable x;
equation eq_2(ii,i,j);
eq_2(ii,i,j).. x =e= sum(iii $(sameas(iii,'i1')), oi(iii));
equation eq_1;
display y;
eq_1.. x =e= sum((i,j)$(y(i,j)), 1);
Model ww /all/;
solve ww using lp minimizing x;

