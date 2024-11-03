$title Test extended card and ord functions (CARD01,SEQ=417)

$onText
Contributor: Alex
$offText

set s       text for s / abc this is abc, 1 this is one /
    ss(s,s) this is ss / abc.abc this is element text /;

parameter stl(s)    length of element         / abc 3, 1 1 /
          ste(s)    length of explanatory text/ abc 11, 1 11 /
          sste(s,s) length of text            / abc.abc  20 /;

abort$(card(ss)<>1)          'number of entries:   line %system.line%';
abort$(card('123456789')<>9) 'length of string:    line %system.line%';
abort$(card("123456789")<>9) 'length of string:    line %system.line%';
abort$(card(ss.ts)<>10)      'length of long text: line %system.line%';

loop(s,  abort$(card(s.tl) <>stl(s))   'length of element:      line %system.line%');
loop(s,  abort$(card(s.te) <>ste(s))   'length of element text: line %system.line%');
loop(ss, abort$(card(ss.te)<>sste(ss)) 'length of element text: line %system.line%');

display ord('12 ','3');            
abort$((ord('78',2)-ord('0',1))<>8) 'decimal value: line %system.line%';
abort$(ord(ss.ts,4)<>ord('s',1))    'symbol text: line %system.line%';

alias(s,t);
loop(ss(s,t), abort$((ord(s.tl,3)-ord(t.tl,1))<>2)           'element ascii values: line %system.line%');
loop(ss,      abort$(ord(ss.te,1)<>ord(ss.te,card(ss.te)-3)) 'element text ascii values: line %system.line%');