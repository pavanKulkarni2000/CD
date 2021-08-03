%{
    #include"4h2.h"
    #include "y.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9]* {
 yylval.name = strdup(yytext);
 return ID;
}

[0-9]+ { 
 yylval.val = atoi(yytext);
 return NUM;
}

[ ]+ ;
\n return 0;
. return yytext[0];

%%
int yywrap() {
   return 1;
}
