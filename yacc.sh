#!/bin/bash

set -e

#lex file
lex y$1.l


#yacc file
if [[ $3 == d ]] 
then 
#if debug is required
yacc -d y$1.y --debug -v
else
yacc -d y$1.y
fi

#compile
cc -w lex.yy.c y.tab.c -ll

#run file with optional input file
./a.out $2