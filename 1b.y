%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
%}
%%
S:'a'S'b'|;
%%

int main(int argc,char *argv[]){
    
    /* if(argc>1)
        yyin = fopen(argv[1],"r"); */
    yyparse();
    printf("Valid String\n");
}

int yyerror(){
    printf("Invalid String\n");
    exit(0);
}