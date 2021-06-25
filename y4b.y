%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    char tempVar=0;
    int tacIndex=0;

    struct TacLine{

        char *lhs, *opd1, *opd2, opr;

    } TAC[20];

    char* AddTacLine(char *opd1,char *opd2,char opr){
        TAC[tacIndex].opd1=opd1;
        TAC[tacIndex].opd2=opd2;
        TAC[tacIndex++].opr=opr;
        size_t needed = snprintf(NULL, 0, "t%d", tempVar) + 1;
        char  *buffer = malloc(needed);
        sprintf(buffer,"t%d", tempVar);
        tempVar++;
        return buffer;
    }
%}

%union
{
    char *stringValue;
}

%token <stringValue> ID NUM
%type <stringValue> S S1 A E
%right '='
%left '+' '-'
%left '*' '/'


%%
S: S1{printf("Valid!\n");};
S1: A | E ;
A: ID  '=' A {$$=AddTacLine($1,$3,'=');}| E {$$=$1;};
E: E '+' E {$$=AddTacLine($1,$3,'+');}
| E '-' E {$$=AddTacLine($1,$3,'-');}
| E '*' E {$$=AddTacLine($1,$3,'*');}
| E '/' E {$$=AddTacLine($1,$3,'/');}
| '(' E ')' {$$=$2;}
| NUM {$$=$1;}
| ID {$$=$1;}
| '-' E {$$=AddTacLine("\0",$2,'-');}
;
%%


yyerror(char *s)
{
    printf("%s",s);
    exit(0);
}
void printTac(int i){
    if(TAC[i].opd1[0]=='\0')
        printf("t%d = %c %s\n",i,TAC[i].opr,TAC[i].opd2);
    else if(TAC[i].opr=='=')
        printf("%s %c %s\n",TAC[i].opd1,TAC[i].opr,TAC[i].opd2);
    else
        printf("t%d = %s %c %s\n",i,TAC[i].opd1,TAC[i].opr,TAC[i].opd2);
}

main()
{
    printf("\n Enter the Expression : ");
    yyparse();
    for(int i=0;i<tacIndex;i++){
        printTac(i);
    }
}