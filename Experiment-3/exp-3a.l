%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "exp-3a.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? { yylval.val = atof(yytext); return NUMBER; }
\+ { return '+'; }
\* { return '*'; }
sin { return SIN; }
cos { return COS; }
asin { return ASIN; }
acos { return ACOS; }
\( { return '('; }
\) { return ')'; }
[ \t]+ ;
\n { return '\n'; }
. { printf("Unexpected character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
