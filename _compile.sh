#!/bin/sh
# Creating the directory
mkdir ./bin 2>/tmp/null
mkdir ./build 2>/tmp/null
# Removing old content
rm -r ./bin/* 2>/tmp/null
rm -r ./build/* 2>/tmp/null
rm -r maschEditor 2>/tmp/null
rm ./maschEditor 2>/tmp/null
# compile & linking
as -o ./bin/bin.o ./src/main.s 2>./build/assembling.log;ld -o ./build/maschEditor ./bin/bin.o 2>./build/linking.log; ln ./build/maschEditor ./maschEditor 2>/tmp/null