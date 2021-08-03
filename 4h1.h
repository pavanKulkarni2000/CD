#ifndef OPERANDS_H
#define OPERANDS_H

#include "4h2.h"
#include <stdio.h>
#define  symTableSize 20

char *symbols[symTableSize];
int tacIndex=0;
int tempIndex=0;
int symIndex=0;
FILE * fp;

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
        case id:fprintf(fp,"%s",symbols[myopd.val]);return 1;
        case num:fprintf(fp,"%d",myopd.val);return 1;
        case temp:fprintf(fp,"t%d",myopd.val);return 1;
        case none:return 0;
    }
}

//printing functions
int printOpdCol(struct Operand myopd){
    switch(myopd.type){
        case id:fprintf(fp,"%-8s",symbols[myopd.val]);return 1;
        case num:fprintf(fp,"%-8d",myopd.val);return 1;
        case temp:fprintf(fp,"t%-7d",myopd.val);return 1;
        case none:return 0;
    }
}
void printTac(){

    fprintf(fp, "TAC:\n");
    for(int i=0;i<tacIndex;i++){
        printOpd(TAC[i].lhs);
        fprintf(fp," = ");
        //if unary operator print operator operand1
        if( TAC[i].opd2.type==none){
            switch (TAC[i].opr)
            {
                case '-':fprintf(fp,"minus ");break;
                case '=':break;
                default:fprintf(fp,"un-op ");break;
            }
            printOpd(TAC[i].opd1);
        }
        //if binary operator print operand1 operator operand2
        else{
            printOpd(TAC[i].opd1);
            fprintf(fp,"%c",TAC[i].opr);
            printOpd(TAC[i].opd2);
        }
        fprintf(fp,"\n");
    }
    fprintf(fp,"\n");
}

void printQuadruples(){

    fprintf(fp,  "Quadruples:\n" );
    fprintf(fp, "%-8s%-8s%-8s%-8s\n" ,"op","arg1","arg2","res" );
    for(int i=0;i<tacIndex;i++){
        if( TAC[i].opd2.type==none){
            switch (TAC[i].opr)
            {
                case '-':fprintf(fp,"%-8s","minus");break;
                case '=':fprintf(fp,"%-8s","=");break;
                default:fprintf(fp,"%-8s","un-op");break;
            }
        }
        else 
            fprintf(fp,"%-8c",TAC[i].opr);
        printOpdCol(TAC[i].opd1);
        // fprintf(fp,"\t");
        printOpdCol(TAC[i].opd2);
        printOpdCol(TAC[i].lhs);
        fprintf(fp,"\n");
    }
    fprintf(fp,"\n");
}

void printTriples(){

    fprintf(fp,  "Triples:\n" );
    fprintf(fp, "\t%-8s%-8s%-8s\n" ,"op","arg1","arg2" );
    for(int i=0;i<tacIndex;i++){
        //table index
        fprintf(fp,"%d",i);
        fprintf(fp,"|\t");

        //operator
        if( TAC[i].opd2.type==none){
            switch (TAC[i].opr)
            {
                case '-':fprintf(fp,"%-8s","minus");break;
                case '=':fprintf(fp,"%-8s","=");break;
                default:fprintf(fp,"%-8s","un-op");break;
            }
        }
        else 
            fprintf(fp,"%-8c",TAC[i].opr);

        //operand1
        if(TAC[i].opr=='=')
            printOpdCol(TAC[i].lhs);
        else if(TAC[i].opd1.type==temp)
            fprintf(fp,"(%d)     ",TAC[i].opd1.val);
        else
            printOpdCol(TAC[i].opd1);
        //operand2
        if(TAC[i].opr=='=')
            if(TAC[i].opd1.type==temp)
                fprintf(fp,"(%d)     ",TAC[i].opd1.val);
            else
                printOpdCol(TAC[i].opd1);
        else if(TAC[i].opd2.type==temp)
            fprintf(fp,"(%d)     ",TAC[i].opd2.val);
        else
            printOpdCol(TAC[i].opd2);
        fprintf(fp,"\n");
    }
    fprintf(fp,"\n");
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