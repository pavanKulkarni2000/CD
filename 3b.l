%{
    #include"y.tab.h"
%}
digit [0-9]
alpha [a-zA-Z]
alnum [a-zA-Z0-9]
WS [\n ]
%%
{WS}* ;
int|float|char return TYPE;
if return IF;
else return ELSE;
for return FOR;
while return WHILE;
return RETURN;
{alpha}{alnum}* return ID;
{digit}+(\.{digit}+)? return NUM;
([+\-/*]|<=?|>=?|==|&&?|\|\|?) return OP;
[(){};=,] return yytext[0];
(\+\+|--) return UNOP;
%%