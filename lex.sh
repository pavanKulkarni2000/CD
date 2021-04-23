#! /bin/sh
lex p$1.l
cc lex.yy.c -ll
./a.out $2 $3