%{

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include <common.h>

nodeType *oper(int oper, int nops, ...);
nodeType *id(int i);
nodeType *con(int value);
void freeNode(nodeType *p);
int ex(nodeType *p);
int yylex(void);
void yyerror(char *s);
int sym[26]; 

%}

%union {
    int iValue;
    char sIndex;
    nodeType *nPtr;
};

%token <iValue> NUMBER;
%token <sIndex> VARIABLE;
%token IF PRINT INPUT
%token GOTO
%token ELSE
%token END_COMMENT
%token START_COMMENT

%nonassoc IFX
%nonassoc ELSE

%left GE LE EQ NE '<' '>'
%left '+' '-'
%left '*' '/'

%type <nPtr> stmt expr stmt_list

%%

stmt:
      END_COMMENT               { $$ = oper(END_COMMENT, 2, NULL, NULL); }
    | expr END_COMMENT          { $$ = $1; }
    | PRINT expr END_COMMENT    { $$ = oper(PRINT, 1, $2); }
    ;

stmt_list:
      stmt              { $$ = $1; }
    | stmt_list stmt    { $$ = oper(',', 2, $1, $2); }
    ;

expr:
      NUMBER            { $$ = con($1); }
    | VARIABLE          { $$ = id($1); }
    | expr '+' expr     { $$ = oper('+', 2, $1, $3); }
    | expr '-' expr     { $$ = oper('-', 2, $1, $3); }
    | expr '*' expr     { $$ = oper('*', 2, $1, $3); }
    | expr '/' expr     { $$ = oper('/', 2, $1, $3); }
    | expr '<' expr     { $$ = oper('<', 2, $1, $3); }
    | expr '>' expr     { $$ = oper('>', 2, $1, $3); }
    | expr GE expr      { $$ = oper(GE, 2, $1, $3); }
    | expr LE expr      { $$ = oper(LE, 2, $1, $3); }
    | expr EQ expr      { $$ = oper(EQ, 2, $1, $3); }
    | expr NE expr      { $$ = oper(NE, 2, $1, $3); }
    | '(' expr ')'      { $$ = $2; }
    ;

%%

nodeType *con(int value) {
    nodeType *p;
    /* allocate node */
    if ((p = malloc(sizeof(conNodeType))) == NULL)
    yyerror("out of memory");
    /* copy information */
    p->type = typeCon;
    p->con.value = value;
    return p;
}

nodeType *id(int i) {
    nodeType *p;
    /* allocate node */
    if ((p = malloc(sizeof(idNodeType))) == NULL)
    yyerror("out of memory");
    /* copy information */
    p->type = typeId;
    p->id.i = i;
    return p;
}

nodeType *oper(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    size_t size;
    int i;
    /* allocate node */
    size = sizeof(oprNodeType) + (nops - 1) * sizeof(nodeType*);
    if ((p = malloc(size)) == NULL)
    yyerror("out of memory");
    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
    p->opr.op[i] = va_arg(ap, nodeType*);
    va_end(ap);
    return p;
} 

void freeNode(nodeType *p) {
    int i;
    if (!p) return;
    if (p->type == typeOpr) {
    for (i = 0; i < p->opr.nops; i++)
        freeNode(p->opr.op[i]);
    }
    free (p);
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int ex(nodeType *p) {
    if (!p) return 0;
    switch(p->type) {
    case typeCon: return p->con.value;
    case typeId: return sym[p->id.i];
    case typeOpr:
    switch(p->opr.oper) {
        case IF: 
            if (ex(p->opr.op[0]))
                ex(p->opr.op[1]);
            else if (p->opr.nops > 2)
                ex(p->opr.op[2]);
            return 0;
        case PRINT: 
            printf("%d\n", ex(p->opr.op[0]));
            return 0;
        case ';': 
            ex(p->opr.op[0]);
            return ex(p->opr.op[1]);
        case '=': return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);
        case '+': return ex(p->opr.op[0]) + ex(p->opr.op[1]);
        case '-': return ex(p->opr.op[0]) - ex(p->opr.op[1]);
        case '*': return ex(p->opr.op[0]) * ex(p->opr.op[1]);
        case '/': return ex(p->opr.op[0]) / ex(p->opr.op[1]);
        case '<': return ex(p->opr.op[0]) < ex(p->opr.op[1]);
        case '>': return ex(p->opr.op[0]) > ex(p->opr.op[1]);
        case GE: return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
        case LE: return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
        case NE: return ex(p->opr.op[0]) != ex(p->opr.op[1]);
        case EQ: return ex(p->opr.op[0]) == ex(p->opr.op[1]);
        }
    }
} 
