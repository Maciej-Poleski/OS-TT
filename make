#!/bin/bash
nasm -f bin boot.asm -o boot.o
nasm -f bin head.asm -o head.o
cat boot.o head.o > boot.img
cat boot.img > /dev/fd0
