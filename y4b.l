%{
    #include "y.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9]* {
 yylval.stringValue = strdup(yytext);
 return ID;
}

[0-9]+ { 
 yylval.stringValue = strdup(yytext);
 return NUM;
}

[ ]+ ;
\n return 0;
. return yytext[0];

%%