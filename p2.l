/* count the number of space and other characters*/
%{
    int c=0,v=0;
%}
%%
[a-zA-Z0-9] c++;
[ ] v++;
. ;
\n return 0;
%%
void main(){
    printf("enter the string :");
    yylex();
    printf(" count:\n alnum=%d\n space=%d\n",c,v);
}