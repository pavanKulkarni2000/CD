#ifndef OPERANDS_H
#define OPERANDS_H

//for color output
#ifdef linux
#define GREEN "\x1b[32m"
#define ORANGE "\x1b[91m"
#define RESET "\x1b[0m"
#else
#define GREEN ""
#define RESET ""
#endif

#include "y4d_tac.h"
#include <stdio.h>

struct TacInstr TAC[20];

struct Token noneOpd=(struct Token){none,0};

struct Token OpdNum(int val){
    return (struct Token){num,val};
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
        TAC[tacIndex].opr='=';
    }else{
        TAC[tacIndex].lhs=OpdTemp();
        TAC[tacIndex].opd1=opd1;
        TAC[tacIndex].opd2=opd2;
        TAC[tacIndex].opr=opr;
    }
    return TAC[tacIndex++].lhs;
}

//printing functions
int printOpd(struct Operand myopd){
    switch(myopd.type){
        case id:printf("%s",symbols[myopd.val]);return 1;
        case num:printf("%d",myopd.val);return 1;
        case temp:printf("t%d",myopd.val);return 1;
        case none:return 0;
    }
}
void printTac(){

    printf( GREEN "TAC:\n" RESET);
    for(int i=0;i<tacIndex;i++){
        printOpd(TAC[i].lhs);
        printf(" = ");
        //if unary operator print operator operand1
        if( TAC[i].opd2.type==none){
            switch (TAC[i].opr)
            {
                case '-':printf("minus ");break;
                case '=':break;
                default:printf("un-op ");break;
            }
            printOpd(TAC[i].opd1);
        }
        //if binary operator print operand1 operator operand2
        else{
            printOpd(TAC[i].opd1);
            printf(" %c ",TAC[i].opr);
            printOpd(TAC[i].opd2);
        }
        printf("\n");
    }
    printf("\n");
}

void printQuadruples(){

    printf( GREEN "Quadruples:\n" RESET);
    printf( ORANGE "op\targ1\targ2\tres\n" RESET);
    for(int i=0;i<tacIndex;i++){
        if( TAC[i].opd2.type==none){
            switch (TAC[i].opr)
            {
                case '-':printf("minus\t");break;
                case '=':printf("=\t");break;
                default:printf("un-op\t");break;
            }
        }
        else 
            printf("%c\t",TAC[i].opr);
        printOpd(TAC[i].opd1);
        printf("\t");
        printOpd(TAC[i].opd2);
        printf("\t");
        printOpd(TAC[i].lhs);
        printf("\n");
    }
    printf("\n");
}

void printTriples(){

    printf( GREEN "Triples:\n" RESET);
    printf( ORANGE "\top\targ1\targ2\n" RESET);
    for(int i=0;i<tacIndex;i++){
        //table index
        printf("%d",i);
        printf("|\t");

        //operator
        if( TAC[i].opd2.type==none){
            switch (TAC[i].opr)
            {
                case '-':printf("minus\t");break;
                case '=':printf("=\t");break;
                default:printf("un-op\t");break;
            }
        }
        else 
            printf("%c\t",TAC[i].opr);

        //operand1
        if(TAC[i].opr=='=')
            printOpd(TAC[i].lhs);
        else if(TAC[i].opd1.type==temp)
            printf("(%d)",TAC[i].opd1.val);
        else
            printOpd(TAC[i].opd1);
        printf("\t");
        //operand2
        if(TAC[i].opr=='=')
            if(TAC[i].opd1.type==temp)
                printf("(%d)",TAC[i].opd1.val);
            else
                printOpd(TAC[i].opd1);
        else if(TAC[i].opd2.type==temp)
            printf("(%d)",TAC[i].opd2.val);
        else
            printOpd(TAC[i].opd2);
        printf("\n");
    }
    printf("\n");
}

void printStatement(){

    printTac();
    printQuadruples();
    printTriples();
    symIndex=0;
    tempIndex=0;
    tacIndex=0;
}
#endif //OPERANDS_H