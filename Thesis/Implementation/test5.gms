Set i / 1*2 /
    j / 1*3 /;

Positive Variables x(i), c;
Variable           z;
Binary Variables   y(j);

x.up(i) = 5;
c.up    = 7;

Equations Obj, Eq1, Eq2, Eq3, Eq4, Eq5, Eq6;

Obj..   z =e= c + 2*x('1') + x('2');

* Equations for Disjunctions
Eq1..   x('2') - x('1') =l=  - 2;
Eq2..   c =l= 5;
Eq3..   x('2') =g= 2;
Eq4..   c =l= 7;
Eq5..   x('1') - x('2') =l= 1 ;
Eq6..   x('1') =l= 1;

* Equations for Logic Propositions
Logic Equations  LEq1, LEq2, LEq3;

LEq1..   y('1') and not y('2') -> not y('3');
LEq2..   y('2') -> not y('3');
LEq3..   y('3') -> not y('2');

Model small1 / all /;

File emp / 'emp.info' /;
put emp;
$onput
disjunction y('1') Eq1 Eq2 elseif y('2') Eq3 Eq4
disjunction y('3') Eq5 else Eq6
$offput
putclose;

Option optcr = 0.0;

solve small1 using EMP minimize z;