%{
    #include"y4d_tac.h"
    #include "y.tab.h"
%}

%%

if {
    yylval.token.type=keyword;
    return IF;
}

[a-zA-Z][a-zA-Z0-9]* {
    yylval.token.type=id;
    symTable[symIndex] = strdup(yytext);
    yylval.token.val=symIndex++;
    return ID;
}

[0-9]+ { 
    yylval.token.type = num;
    yylval.token.val = atoi(yytext);
    return NUM;
}

[ ]+ ;
\n return 0;
. return yytext[0];

%%
int yywrap() {
   return 1;
}
