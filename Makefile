# 
# riscv-simulator: A simulator for RISCV, supporing RV32I now
# Automake script
#
# Yangcheng Luo		<lyc.eecs@pku.edu.cn>
# Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
# 
# Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University

simulator: ./src/*.cpp ./src/*.h
	g++ -o simulator ./src/*.cpp ./src/*.h

.PHONY:clean
clean:
	rm -f simulator

.PHONY:debug_all
debug_all:
	g++ -DDEBUG_HEADER -DDEBUG_MEMORY -DDEBUG_EXECUTION -DDEBUG_CONTENT -o simulator ./src/*.cpp ./src/*.h

.PHONY:debug_header
debug_header:
	g++ -DDEBUG_HEADER -o simulator ./src/*.cpp ./src/*.h

.PHONY:debug_memory
debug_memory:
	g++ -DDEBUG_MEMORY -o simulator ./src/*.cpp ./src/*.h

.PHONY:debug_execution
debug_execution:
	g++ -DDEBUG_EXECUTION -o simulator ./src/*.cpp ./src/*.h

.PHONY:debug_content
debug_content:
	g++ -DDEBUG_CONTENT -o simulator ./src/*.cpp ./src/*.h

.PHONY:debug_single_step
debug:
	g++ -DDEBUG -DDEBUG_EXECUTION -o simulator ./src/*.cpp ./src/*.h
