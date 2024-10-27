
$onEolCom
scalar r /10/;
set i "set of all" / i1*i12 /;
set j /j1/;
set c(i,j) /#i.#j/;
set a /1,2,3,4/;
set o "llasdjfl" /#c.#a/; !!another way is by writing /(set.c).(set.a)/
set z /z63*z49/;
c('i1','j1') = no;
set q(i,j,a);
alias(i,i_1);
sets
    p /1/ !!alaskdkjflsdf /3fasdfsdaaaaaasdfdsfi/lk;jasjddfkljsdhf
    v /3/
    ;
display z;
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
scalar d;
d=2;
display d;
!! trying to display set
g(i)$(ord(i)>=2) = 3; !! what an stupid language, eh??
display f,g;
$ontext
Set       i     / i1*i5 /;
Parameter s(i)  / i1 3, i2 5, i4 8 /
          t(i)  / i1*i4 13 /
          u(i)  / i2 1 /
          v(i)  / i1 7, i3 2, i5 29 /;

u(i) $ (not s(i))               = v(i);
*display u;
u(i) $ (s(i) and u(i) and t(i)) = s(i);
u(i) $ (s(i) or v(i) or t(i))   = 4;
$offtext