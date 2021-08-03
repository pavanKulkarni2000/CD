%{
    #include<stdio.h>
    int w=0,l=0,c=0,s=0;
%}
%%
\n l++;
[ ] {c++;s++;}
[^\n\t ]+ {w++;c+=yyleng;}
<<EOF>> {l++;return 0;}
%%
int main(int a, char *b[]){
    if(a<2){
        printf("Enter input\n");
    }else{
        yyin=fopen(b[1],"r");
    }
    yylex();
    printf("The count of \n");
    printf("Lines = %d\n",l);
    printf("Words = %d\n",w);
    printf("Characters = %d\n",c);
    printf("Spaces = %d\n",s);
    return 0;
}