%{
    #include "5h1.h"
    #include "y.tab.h"
%}
num [0-9]
aplha [a-zA-Z]
wsp [ \n\t]+
%%
{aplha}({aplha}|{num})* {
    yylval.name=strdup(yytext);
    return ID;
}
{num}+  {
    yylval.value=atoi(yytext);
    return NUM;
}
{wsp} ;
. return yytext[0];
%%
int yywrap() {
   return 1;
}