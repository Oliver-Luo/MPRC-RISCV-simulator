# MPRC-RISCV-simulator
A instruction level RISCV-simulator written for learning

Author:
	Yangcheng Luo <lyc.pku.eecs@gmail.com>
	Haoze Wu <wuhaoze@pku.edu.cn>

Instrction:

1. Type "make" to build a normal mode executive file named simulator, than you can use this simulator to execute RISCV RV32I programs.

2. Other make options include:
	make debug_header: Print information about elf header, program headers and section headers before execution.
	make debug_memory: Print memory content after the execution of each instruction. The output may be large, so redirecting to a file may be a good choice.
	make debug_execution: Print information for each instruction executed.
	make debug_context: Print the content of registers and memory after the execution of the whole program.
	make debug_all: Print all the information above. The output may be large, so redirecting to a file may be a good choice.
	make debug_single_step: Enter single step mode. Type h in this mode for more help.
	make clean: Remove all intermediate files.

3. There are plenty of test case under directory "test".
