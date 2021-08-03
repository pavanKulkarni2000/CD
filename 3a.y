%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    extern FILE *yyin;
    extern int yydebug=0;
    int ans=0;
%}
%token FOR ID OP UNOP NUM
%%
S:F ;
F:FOR FBR ST {ans++;};
FBR: '(' EXP ';' EXP ';' EXP ')' ;
EXP: EXPA|;
EXPA: ID '=' EXPA|EXPOP;
EXPOP: EXPOP OP ANYU | ANYU ;
ANYU:ANY|ANY UNOP| UNOP ANY;
ANY:ID|NUM;
ST: EXP ';'| '{' BL '}'|F;
BL: BL ST |;
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
    printf("Result = %d\n", ans);
}

int yyerror(){
    printf("Invalid expression\n");
    exit(0);
}