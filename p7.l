%{
#include<stdio.h>
int negno=0, posno=0, negfrac=0, posfrac=0, dv=0;
%}

%%

[+]?[0-9]+ {posno++; printf("\nPos Int: %s",yytext);}
-[0-9]+ {negno++; printf("\nNeg Int: %s",yytext);}

[+]?[0-9]*[.][0-9]+ {posfrac++; printf("\nPos Frac: %s",yytext);}
-[0-9]*\.[0-9]+ {negfrac++; printf("\nNeg Frac: %s",yytext);}

-[0-9][.][0-9]+[/][0] {dv++; printf("\nDivide By Zero: %s", yytext);}
[0-9][.][0-9]+[/][0] {dv++; printf("\nDivide By Zero: %s", yytext);}

-[0-9][.][0-9]+[/][-][0-9][.][0-9]+ {posfrac++; printf("\nPos Frac: %s",yytext);}
[+]?[0-9][.][0-9]+[/][+]?[0-9][.][0-9]+ {posfrac++; printf("\nPos Frac: %s", yytext);}
[+]?[0-9][.][0-9]+[/][-][0-9][.][0-9]+ {negfrac++; printf("\n Neg Frac: %s", yytext);}
-[0-9][.][0-9]+[/][0-9][.][0-9]+ {negfrac++; printf("\n Neg frac: %s", yytext);}


. ;
\n return 0;
%%

void main()
{
        yylex();
        printf("\n\nCount:");
        printf("\nPositive Int: %d", posno);
        printf("\nNeg Int: %d", negno);
        printf("\nPos Frac: %d", posfrac);
        printf("\nNeg Frac: %d", negfrac);
        printf("\nDivide by Zero: %d\n", dv);
}