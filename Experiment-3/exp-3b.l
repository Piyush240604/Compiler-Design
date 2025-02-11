%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "exp-3b.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? { yylval.val = atof(yytext); return NUMBER; }
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
pow { return POW; }
exp { return EXP; }
"(" { return '('; }
")" { return ')'; }
[ \t]+ ;
\n { return '\n'; }
. { printf("Unexpected character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}