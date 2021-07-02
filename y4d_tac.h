#ifndef TAC_H
#define TAC_H

#define  symTableSize 100

extern char *symbolTable[symTableSize];
extern int tacIndex=0;
extern int tempIndex=0;
extern int symIndex=0;


enum TokenType{
    id, num, temp, none, keyword
};

struct Token{
    enum TokenType type;
    int val;
};

struct TacInstr{
    struct Token lhs,opd1,opd2;
    char opr;
};

#endif //TAC_H