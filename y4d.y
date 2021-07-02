%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include"y4d_tokens.h"
%}

%union
{
    struct Token token;
}

%token <token> ID IF NUM
%type <token> S A E
%right '='
%left '+' '-'
%left '*' '/'


%%
S1: S { printStatement(); } S1| ;
S: A ';' |
IF '(' E ')' E {  };
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
}