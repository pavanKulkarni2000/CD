%{
    #include"y.tab.h"
    // extern yylval;
%}
digit [0-9]
alpha [a-zA-Z]
alnum [a-zA-Z0-9]
WS [\n ]
%%
{WS}*for{WS}* { return FOR;}
{WS}*{alpha}{alnum}*{WS}* return ID;
{WS}*{digit}+{WS}* return NUM;
{WS}*([+-/*]|<=?|>=?|==|&&?|\|\|?){WS}* return OP;
{WS}*[(){};=]{WS}* return yytext[0];
{WS}*(\++|--){WS}* return UNOP;
%%

/*

for { return FOR;}
{alpha}{alnum}* return ID;
{digit}+ return NUM;
\( return '(';
\) return ')';
\{ return '{';
\} return '}';
; return ';';
[+-/*]|<=?|>=?|== return OP;
= return '=';
\++|-- return UNOP;
[ ] return SP;
\n return 0;
*/