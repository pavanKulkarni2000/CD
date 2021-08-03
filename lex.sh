#! /bin/sh

set -e

lex $1.l
cc lex.yy.c -ll
./a.out $1.in