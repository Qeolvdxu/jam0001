%{
#include <stdlib.h>
#include "tokens.h"
%}

%%

define\ [a\-Z]*     {
                        // yylval.sIndex = *yytext - 'a';
                        return VARIABLE;
                    }

[0-9]+              {
                        // yylval.iValue = atoi(yytext);
                        return NUMBER;
                    }

[-+\/\*]            return *yytext;

TL\;DR\ .*          return COMMENT;

"put on screen"     return PRINT;
"give me"           return INPUT;

"if"                return IF;
"else"              return ELSE;

"go to line"        return GOTO;

"is not"            return NE;
"is"                return EQ;
"greater than"      return GT;
"smaller than"      return ST;

[ \t\n]+            ;

.                   yyerror("Invalid character");

%%

void yyerror(char const *s)
{
    printf("yyerror  %s\n",s);
    return ;
}

// int yywrap(void)
// {
//     return 1;
// }
