%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include"operands.h"
        
%}

%union
{
    struct Operand opd;
    char * name;
    int val;
}

%token <name> ID 
%token <val> NUM
%type <opd> S A E
%right '='
%left '+' '-'
%left '*' '/'


%%
S: A{printf("Valid!\n");};
A: ID  '=' A {$$=AddTacLine(OpdId($1),$3,'=');}| E {$$=$1;};
E: E '+' E {$$=AddTacLine($1,$3,'+');}
| E '-' E {$$=AddTacLine($1,$3,'-');}
| E '*' E {$$=AddTacLine($1,$3,'*');}
| E '/' E {$$=AddTacLine($1,$3,'/');}
| '(' E ')' {$$=$2;}
| NUM {$$=OpdNum($1);}
| ID {$$=OpdId($1);}
| '-' E {$$=AddTacLine(noneOpd,$2,'-');}
;
%%


yyerror(char *s)
{
    printf("%s",s);
    exit(0);
}
void printOpd(struct Operand myopd){
    switch(myopd.type){
        case id:printf("%s",symbols[myopd.val]);break;
        case num:printf("%d",myopd.val);break;
        case temp:printf("t%d",myopd.val);break;
    }
}
void printTac(int i){
    printOpd(TAC[i].lhs);
    printf("=");
    printOpd(TAC[i].opd1);
    printf("%c",TAC[i].opr);
    printOpd(TAC[i].opd2);
    printf("\n");
}

main()
{
    printf("\n Enter the Expression : ");
    yyparse();
    for(int i=0;i<tacIndex;i++){
        printTac(i);
    }
}