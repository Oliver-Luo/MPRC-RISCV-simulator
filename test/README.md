1. There are twe scripts here:
	compile_only_main.sh: Compile C type source code using riscv64-unknown-linux-gnu-gcc, then link with params "-m elf32lriscv" and "-e main" to ensure only main function is presented in the final executive.
	process_shole.sh: Compile and link C type source code using riscv64-unknown-elf-gcc, then use objdump to get the assembly code and readelf to get the elf information.

2. There are plenty of test files in this directory. Use the scripts described above to handle then.

3. There is a sub directory named dhrystone, consisting the source code of dhrystone 2.1 benchmark. Use the Makefile inside to process that.
