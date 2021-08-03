#!/bin/bash

set -e

#lex file
lex y$1.l

yacc -d y$1.y

#compile
cc -w lex.yy.c y.tab.c -ll

#run file with optional input file
./a.out $2 $3