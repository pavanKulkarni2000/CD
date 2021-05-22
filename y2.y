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
S:T{ans=$$;};
T:T'+'T {$$=$1+$3;}
|T'-'T {$$=$1-$3;}
|T'*'T {$$=$1*$3;}
|T'/'T {if($3==0)yyerror();else $$=$1/$3;}
|'('T')' {$$=$2;}
|'-'NUM {$$=-$2;}
|NUM {$$=$1;};
%%

int main(int argc,char *argv[]){
    
    if(argc>1)
        yyin=fopen(argv[1],"r");
    else
        printf("Enter expression\n");
    yyparse();
    printf("Result = %d\n", ans);
}

int yyerror(){
    printf("Invalid expression\n");
    exit(0);
}