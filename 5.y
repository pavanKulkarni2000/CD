%{
    #include<stdio.h>
    #include "5h1.h"

    char* syms[100];
    int syms_i=0;
    int temps_i=0;

    const Token none_token = (Token){none,0};

    Token num_token(int val){
        return (Token){num,val};
    }

    Token id_token(char *name){
        syms[syms_i]=name;
        return (Token){id,syms_i++};
    }

    Token temp_token(){
        return (Token){temp,temps_i++};
    }

    Token ldr_instr(Token t){
        Token reg=temp_token();
        printf("LDR R%d, %s\n",reg.val,syms[t.val]);
        return reg;
    }

    Token instr(Token t1,Token t2,char op){
        if(op=='='){
            if(t2.type==id)
                t2=ldr_instr(t2);
            printf("STR R%d, %s\n",t2.val,syms[t1.val]);
            return t2;
        }
        if(t1.type==id)
            t1=ldr_instr(t1);
        if(t2.type==id)
            t2=ldr_instr(t2);
        switch(op){
            case '+':
            printf("ADD R%d, R%d\n",t1.val,t2.val);
            return t1;
            case '-':
            printf("SUB R%d, R%d\n",t1.val,t2.val);
            return t1;
            case '/':
            printf("DIV R%d, R%d\n",t1.val,t2.val);
            return t1;
            case '*':
            printf("MUL R%d, R%d\n",t1.val,t2.val);
            return t1;
        }
    }

%}

%union{
    Token token;
    char * name;
    int value;
}

%token <value> NUM
%token <name> ID
%type <token> S S1 E
%right '='
%left '+' '-'
%left '*' '/'

%%
S: S1 {printf("Valid!\n\n");};
S1: ID '=' E {$$=instr(id_token($1),$3,'=');}| E {$$=$1;} ;
E: E '+' E {$$=instr($1,$3,'+');}
| E '-' E {$$=instr($1,$3,'-');}
| E '*' E {$$=instr($1,$3,'*');}
| E '/' E {$$=instr($1,$3,'/');}
| '(' E ')' {$$=$2;}
| '-' E {$$=instr($2,none_token,'-');}
| NUM {$$=num_token($1);}
| ID {$$=id_token($1);}
;
%%

yyerror(char *s)
{
    printf("%s",s);
    exit(0);
}

int main(){
    #ifdef YYDEBUG
    extern yydebug;
    #endif
    printf("Enter expression");
    yyparse();
}