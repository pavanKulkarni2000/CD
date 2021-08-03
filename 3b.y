%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    extern FILE *yyin;
    extern int yydebug=0;
    int ans=0;
%}
%token TYPE ID OP UNOP NUM RETURN FOR WHILE IF ELSE
%%
S:FUNC ;
FUNC: TYPE ID '(' FPARAM ')' FBODY ;
FPARAM: TYPE ID ',' FPARAM|TYPE ID;
FBODY: '{' FBODY1 '}';
FBODY1: FBODY_STATEMENT FBODY1 |;
FBODY_STATEMENT: DECLARATION| EXP ';'| IF_STATEMENT| WHILE_STATEMENT| FOR_STATEMENT| RETURN EXP ';';
IF_STATEMENT:IF '(' EXP ')' FBODY2 OPTIONAL_ELSE ;
OPTIONAL_ELSE:ELSE FBODY2 | ELSE IF_STATEMENT |;
WHILE_STATEMENT:WHILE '(' EXP ')' FBODY2;
FOR_STATEMENT:FOR '(' EXP ';' EXP ';' EXP ')' FBODY2;
FBODY2:FBODY|FBODY_STATEMENT;
DECLARATION: TYPE ID ';' ;
EXP: EXPA|EXPOP|;
EXPA: ID '=' EXPA|ID '=' EXPOP;
EXPOP: EXPOP OP ANYU | ANYU ;
ANYU:ANY|ANY UNOP| UNOP ANY;
ANY:ID|NUM;
%%
int main(int argc,char *argv[]){
    #ifdef YYDEBUG
    yydebug = 1;
    #endif
    if(argc>1)
        yyin=fopen(argv[1],"r");
    else
        printf("Enter expression  : \n");
    yyparse();
    printf("Valid!\n");
}

int yyerror(){
    printf("Invalid expression\n");
    exit(0);
}