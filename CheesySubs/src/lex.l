%{
#include <stdlib.h>

#include "parser.tab.h"

#include "common.h"


void yyerror(char *); 
%}

%%

define\ [a\-Z]*     {
                        yylval.sIndex = *yytext - 'a';
                        return VARIABLE;
                    }

[0-9]+              {
                        yylval.iValue = atoi(yytext);
                        return NUMBER;
                    }

[-+\/\*\(\)\<\>,]    return *yytext;

\/\*                return START_COMMENT;
\\\*                return END_COMMENT;

"put on screen"     return PRINT;
"give me"           return INPUT;

"if"                return IF;
"else"              return ELSE;

"go to line"        return GOTO;

"is not"            return NE;
"is"                return EQ;
">="                return GE;
"<="                return LE;

[ \t\n]+            ;

.                   yyerror("Invalid character");

%%

int yywrap(void) {
 return 1;
} 
