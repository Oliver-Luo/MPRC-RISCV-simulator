#!/bin/sh

if [ $# != 1 ]; then
	echo "Usage: " `basename $0` " filename of the C file"
	exit
fi

riscv64-unknown-elf-gcc -m32  -march=RV32I -o ${1%%.c}.exe $1

riscv64-unknown-elf-objdump -D ${1%%.c}.exe > ${1%%.c}.asm
riscv64-unknown-elf-readelf -a ${1%%.c}.exe > ${1%%.c}.elf
