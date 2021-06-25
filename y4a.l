%{
    #include "y.tab.h"
%}

%%



[0-9] {yylval=(int)yytext[0]; return NUM;}
[_a-zA-Z] {yylval=(int)yytext[0];return ID;}

\n return 0;
. return yytext[0];

%%