/* count the number of keywords, identifiers, digits and operators*/
%{
    int k=0,v=0,o=0,d=0;
%}
%%
auto|break|case|char k++;
const|continue|default|do k++;
double|else|enum|extern k++;
float|for|goto|if k++;
int|long|register|return k++;
short|signed|sizeof|static k++;
struct|switch|typedef|union k++;
unsigned|void|volatile|while k++;
[a-z]([a-z]|[0-9])* {v++; printf("variable %s no:%d\n",yytext,v);}
[0-9]+ d++;
[*+/-] o++;
. ;
\n ;
%%
int main(int argc,char *argv[]){
    
    if(argc>1){
        yyin = fopen(argv[1],"r");
        if(argc>2)
            yyout = fopen(argv[2],"w");
    }
    yylex();
    printf(" \ncount: \n\t keywords = %d  \n\t variables = %d  \n\t digits = %d\n\t operators = %d \n\n",k,v,d,o);
}