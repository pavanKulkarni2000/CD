%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    extern FILE *yyin;
    int ans;
%}
%token NUM
%left '+''-'
%left '*''/''%'
%%
S:T { ans=$$; };
T:T'+'T {$$=$1+$3;}
|T'-'T {$$=$1-$3;}
|T'*'T {$$=$1*$3;}
|T'/'T {if($3==0)yyerror("Division by zero!");else $$=$1/$3;}
|'('T')' {$$=$2;}
|'-'T {$$=-$2;}
|NUM {$$=$1;};
%%
void yyerror(char *err){
    printf("Error: %s\n",err);
    exit(0);
}
int main(int argc,char *argv[]){
    
    if(argc>1)
        yyin=fopen(argv[1],"r");
    else
        printf("Enter expression\n");
    yyparse();
    printf("Result = %d\n", ans);
}