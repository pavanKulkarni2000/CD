/* replace printf with writef and scanf with readf*/
%{
%}
%%
printf fprintf(yyout,"writef");
scanf fprintf(yyout,"readf");
%%
int main(int argc,char *argv[]){
    
    yyin = fopen(argv[1],"r");
    yyout = fopen(argv[2],"w");
    yylex();
}