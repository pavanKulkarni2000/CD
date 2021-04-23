%{
    #define printCt(str,val){ printf("Count of %s = %d\n",str,val);}
    int n=0,p=0,nf=0,pf=0,z=0,dz=0;
%}
digit [0-9]
num {digit}+
nnum [-]{num}
pnum [+]?{num}
deci {num}?[.]{num}
pdeci [+]?{deci}
ndeci [-]{deci}
zero [+-]?0+([.]{num})?
%%
({ndeci}|{pdeci}|{nnum}|{nnum})[/]{zero} dz++;
{zero}([/]({ndeci}|{pdeci}|{nnum}|{nnum}))? z++;
({ndeci}|{nnum})[/]({ndeci}|{nnum}) pf++;
({ndeci}|{nnum})[/]({pdeci}|{pnum}) nf++;
({pdeci}|{pnum})[/]({ndeci}|{nnum}) nf++;
({pdeci}|{pnum})[/]({pdeci}|{pnum}) pf++;
{ndeci} nf++;
{pdeci} pf++;
{nnum} n++;
{pnum} p++;
. printf("other : %s\n",yytext);
%%
int main(int argc,char *argv[]){
    
    if(argc>1){
        yyin = fopen(argv[1],"r");
        if(argc>2)
            yyout = fopen(argv[2],"w");
    }
    yylex();
    printCt("Divide by Zeros",p);
    printCt("Zeros",p);
    printCt("Positive numbers",p);
    printCt("Negative numbers",n);
    printCt("Positive fraction numbers",pf);
    printCt("Negative fraction numbers",nf);
}