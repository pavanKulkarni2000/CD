%{
    #include"y.tab.h"
    // extern yylval;
%}
digit [0-9]
alpha [a-zA-Z]
alnum [a-zA-Z0-9]
WS [\n ]
%%
{WS}* ;
for return FOR;
{alpha}{alnum}* return ID;
{digit}+(\.{digit}+)? return NUM;
([+\-/*]|<=?|>=?|==|&&?|\|\|?) return OP;
[(){};=] return yytext[0];
(\+\+|--) return UNOP;
%%