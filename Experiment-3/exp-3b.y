%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex();
%}

/* Define a union to store numerical values */
%union {
    double val;
}

/* Declare token data types */
%token <val> NUMBER
%token POW EXP

/* Declare expression return type */
%type <val> expr

%left '+' '-'
%left '*' '/'
%right POW

%%

input: /* empty */
     | input line
     ;

line: '\n'
    | expr '\n' { printf("Result: %lf\n", $1); fflush(stdout); }
    ;

expr: NUMBER { $$ = $1; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { if ($3 != 0) $$ = $1 / $3; else { yyerror("Division by zero"); $$ = 0; } }
    | expr POW expr { $$ = pow($1, $3); }
    | EXP '(' expr ')' { $$ = exp($3); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions (Ctrl+D to exit):\n");
    return yyparse();
}
