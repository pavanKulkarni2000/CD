#ifndef OPERANDS_H
#define OPERANDS_H

#include "tac.h"
#define  symTableSize 20

char *symbols[symTableSize];
int tacIndex=0;
int tempIndex=0;
int symIndex=0;

struct TacInstr TAC[20];

struct Operand noneOpd=(struct Operand){none,0};

struct Operand OpdNum(int val){
    return (struct Operand){num,val};
}

struct Operand OpdId(char * name){
    symbols[symIndex]=name;
    return (struct Operand){id,symIndex++};
}

struct Operand OpdTemp(){
    return (struct Operand){temp,tempIndex++};
}

struct Operand AddTacLine(struct Operand opd1,struct Operand opd2, char opr){
    if(opr=='='){
        TAC[tacIndex].lhs=opd1;
        TAC[tacIndex].opd1=opd2;
        TAC[tacIndex].opd2=noneOpd;
        TAC[tacIndex].opr='\0';
    }else{
        TAC[tacIndex].lhs=OpdTemp();
        TAC[tacIndex].opd1=opd1;
        TAC[tacIndex].opd2=opd2;
        TAC[tacIndex].opr=opr;
    }
    return TAC[tacIndex++].lhs;
}
#endif //OPERANDS_H