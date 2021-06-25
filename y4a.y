%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    char tempVar='1';
    int tacIndex=0;
    struct TacLine{

        char opd1, opd2, opr;

    } TAC[20];

    char AddTacLine(char opd1,char opd2,char opr){
        TAC[tacIndex++]=(struct TacLine){opd1, opd2, opr};
        return tempVar++;
    }
%}

%token NUM ID
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
| '-' E {$$=AddTacLine($2,'\t','-');}
;
%%

struct TacOpd{
    char opd;
    int is_temp;
};


yyerror(char *s)
{
 printf("%s",s);
 exit(0);
}
main()
{
printf("\n Enter the Expression : ");
yyparse();
for(int i=0;i<tacIndex;i++){
    printf("%c %c %c\n",TAC[i].opd1,TAC[i].opr,TAC[i].opd2);
}
}