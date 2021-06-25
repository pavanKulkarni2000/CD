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
S: A{printf("Valid!\n\n");};
A: ID  '=' A {$$=AddTacLine(OpdId($1),$3,'=');}| E {$$=$1;};
E: E '+' E {$$=AddTacLine($1,$3,'+');}
| E '-' E {$$=AddTacLine($1,$3,'-');}
| E '*' E {$$=AddTacLine($1,$3,'*');}
| E '/' E {$$=AddTacLine($1,$3,'/');}
| '(' E ')' {$$=$2;}
| NUM {$$=OpdNum($1);}
| ID {$$=OpdId($1);}
| '-' E {$$=AddTacLine($2,noneOpd,'-');}
;
%%


yyerror(char *s)
{
    printf("%s",s);
    exit(0);
}

int main(int argc,char *argv[])
{
    //to read input from the file
    extern FILE *yyin;
    if(argc==1 || !(yyin=fopen(argv[1],"r")))
        printf("Enter expression  : \n");
    yyparse();
    printTac();
    printQuadruples();
    printTriples();
}