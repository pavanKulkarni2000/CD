%{
    #define printCt(str,val){ printf("Count of %s = %d\n",str,val);}
    int n=0,p=0,nf=0,pf=0,z=0,dz=0;
    short file_input=0;
%}
digit [0-9]
num {digit}+
nnum [-]{num}
pnum [+]?{num}
deci {num}?[.]{num}
pdeci [+]?{deci}
ndeci [-]{deci}
zero [+-]?0+([.]0+)?
%%
({ndeci}|{pdeci}|{nnum}|{pnum})[/]{zero} dz++;
{zero}([/]({ndeci}|{pdeci}|{nnum}|{pnum}))? z++;
({ndeci}|{nnum})[/]({ndeci}|{nnum}) pf++;
({ndeci}|{nnum})[/]({pdeci}|{pnum}) nf++;
({pdeci}|{pnum})[/]({ndeci}|{nnum}) nf++;
({pdeci}|{pnum})[/]({pdeci}|{pnum}) pf++;
{ndeci} nf++;
{pdeci} pf++;
{nnum} n++;
{pnum} p++;
. ;
\n if(file_input) ; else return 0;
%%
int main(int argc,char *argv[]){
    
    if(argc>1){
        file_input=1;
        yyin = fopen(argv[1],"r");
        if(argc>2)
            yyout = fopen(argv[2],"w");
    }else{
        printf("Enter expression\n");
    }
    yylex();
    printCt("Divide by Zeros",dz);
    printCt("Zeros",z);
    printCt("Positive numbers",p);
    printCt("Negative numbers",n);
    printCt("Positive fraction numbers",pf);
    printCt("Negative fraction numbers",nf);
}