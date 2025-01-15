#!/bin/sh

# GOTTA PASS THE CLIENT AS FIRST ARG
# GOTTA PASS THE TEST NUMBER AS SECOND
as -o ./bin/$1.o ./tests/$1.s 2>./build/assembling.log
ld -o ./build/$1 ./bin/$1.o 2>./build/linking.log
./build/$1 < ./tests/$1/input$2 > ./tests/$1/outputtest$2
cmp -s ./tests/$1/output$2 ./tests/$1/outputtest$2 && printf "$1: Test %d passed\n" $2 || printf "$1: Test %d failed\n" $2
rm ./tests/$1/outputtest$2