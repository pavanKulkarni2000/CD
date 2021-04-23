/* count the number of vowels and consonents*/
%{
    int c=0,v=0;
%}
%%
[aeiouAEIOU] v++;
[a-zA-Z] c++;
. ;
\n return 0;
%%
void main(){
    printf("enter the string :");
    yylex();
    printf(" count:\n vowels=%d\n consonents=%d\n",v,c);
}