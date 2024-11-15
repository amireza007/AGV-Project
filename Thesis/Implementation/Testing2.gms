$onEolCom

scalar r /10/; !! alksdfj
set i "set of all" / i1*i12 /;
set j /j1/;
set c(i,j) /#i.#j/;
*set o "llasdjfl" /i\set(i1)/; !!another way is by writing /(set.c).(set.a)/
c('i1','j1') = no;
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
set Cc(ii,i,j) /i1.i1.j1/;
variable x;
variable yy;
equation eq_2(ii,i,j);
eq_2(ii,i,j) $(cc(ii,i,j)).. x =e= sum(iii $(sameas(iii,'i1')), oi(iii));
equation eq_1;
display y;
eq_1.. yy =e= sum((i,j)$(y(i,j)), 1);
scalars a b c;
equation eq3;
eq3..
$ifthen x == y
 x=e= 1;
$else
1 =e= 1;
$endif
equation er;
er.. x =l= 4;
*x.fx=1;
Model ww /all/;
solve ww using mip minimizing x;

*set j /1*10/;
*alias (j,j_1)
*parameter val(j);
*val(j) = j.val $(j.val > 4);
*variable x;
*equation eq1(j);
*eq1(j).. sum(j_1 $(ord(j_1) < ord(j)), 1) =e= x;
*Set   i         / i1*i3 /
*      s(i,i,i)  "Set members" / i1.i2.i3, i3.i3.i1/
*      pR1(i,i)  "projection right to left with assignment"
*      pR2(i,i)  "projection right to left with option statement"
*      pL1(i,i)  "projection left to right with assignment"
*      pL2(i,i)  "projection left to right with option statement" ;
*Alias (i,ii,iii);
*scalars t,y;
*t = 4;
*y = 5;
*set j2(j);
*j2('4') $(max{t,y} >2) = yes;
*display j2;
** Right-to-left permutation, two ways
*pR1(i,ii) = sum(s(iii,ii,i),1);
*option pR2 < s;
*
** Left-to-right permutation, two ways
*pL1(i,ii) = sum(s(i,ii,iii),1);
*option pL2 <= s;
*
**option s:0:0:1, pR1:0:0:1, pR2:0:0:1, pL1:0:0:1, pL2:0:0:1;
*display s, pR1, pR2, pL1, pL2 ;