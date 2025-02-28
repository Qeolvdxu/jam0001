#ifndef COMMON_H
#define COMMON_H

typedef enum { typeCon, typeId, typeOpr } nodeEnum;
/* constants */
typedef struct {
    nodeEnum type; /* type of node */
    int value; /* value of constant */
} conNodeType;

/* identifiers */
typedef struct {
    nodeEnum type; /* type of node */
    int i; /* subscript to ident array */
} idNodeType;

/* operators */
typedef struct {
    nodeEnum type; /* type of node */
    int oper; /* operator */
    int nops; /* number of operands */
    union nodeTypeTag *op[1]; /* operands (expandable) */
} oprNodeType;

typedef %union nodeTypeTag {
    nodeEnum type; /* type of node */
    conNodeType con; /* constants */
    idNodeType id; /* identifiers */
    oprNodeType opr; /* operators */
} nodeType;

extern int sym[26]; 

#endif // COMMON_H
