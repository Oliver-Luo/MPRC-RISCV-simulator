/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * siscall -- System call part 
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */

#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <map>
#include <sys/time.h>

#include "riscv_inst.h"
#include "elf_format.h"
#include "simulator.h"

using namespace std;

extern uint32_t reg[];
extern uint64_t f_reg[];
extern uint32_t PC;
extern map<uint32_t, uint8_t> mem;

#define Rd(inst) ((inst >> 7) & 0x1f)
#define Rs1(inst) ((inst >> 15) & 0x1f)
#define Rs2(inst) ((inst >> 20) & 0x1f)

// 80 sys_fstat ; 214 sys_brk; 57 sys_close unimplemented
static void sys_write()
{
	Elf32_Addr cur_addr = reg[11];
	Elf32_Addr limit_addr = reg[12]+reg[11];
	//printf("entered\n");
	for(int i = cur_addr; i < limit_addr; i++)
	{
		char a = retrieve_or_error(i);
		printf("%c", a);

	}
	reg[10] = reg[12];
}
 
static void sys_read()
{
	int i = 0;
	char temp_str[1024];
	uint32_t len;
	scanf("%s", temp_str);
	len = strlen(temp_str);
	map<uint32_t, uint8_t>::iterator iter;
	for (i = 0; i <= len; i++)
	{
		iter = mem.find(reg[11] + i);
		if (iter == mem.end())
			mem.insert(pair<uint32_t, uint8_t>(reg[11] + i, temp_str[i]));
		else
			iter->second = temp_str[i];
		iter = mem.find(reg[11] + i);
	}

	reg[10] = len+1;
	return;
}

static void sys_gettimeofday()
{
	int i = 0;
	struct timeval t;
	if (gettimeofday(&t, NULL) == 0)
	{
		map<uint32_t, uint8_t>::iterator iter;
		for (i = 0; i < 4; i++)
		{
			iter = mem.find(reg[10] + i);
			if (iter == mem.end())
				mem.insert(pair<uint32_t, uint8_t>(reg[10] + i, (t.tv_sec >> (i * 8)) & 0xff));
			else
				iter->second = (t.tv_sec >> (i * 8)) & 0xff;

			iter = mem.find(reg[10] + i + 4);
			if (iter == mem.end())
				mem.insert(pair<uint32_t, uint8_t>(reg[10] + i + 4, (t.tv_usec >> (i * 8)) & 0xff));
			else
				iter->second = (t.tv_usec >> (i * 8)) & 0xff;
		}
	}
	else
	{
		printf("The call to func gettimeofday error.\n");
		exit(EXIT_FAILURE);
	}
}

int scall(void)
{
	if (reg[17] == 93)
		return 0;
	// for (int i = 10; i < 18; ++i)
	// {
	// 	printf("%x    ", reg[i]);
	// }
	// printf("\n");
	//printf("scall: %d\n", reg[17]);
	switch(reg[17])
	{
		//TODO Finish some syscalls
		case 64: sys_write();break;
		case 63: sys_read(); break;
		case 80: break;
		case 169: sys_gettimeofday(); break;
		case 214: break;
		default: 
		{
			printf("System call %d in addr: %x unimplemented.\n", reg[17], PC);
			printf("PC: %x, inst: SCALL num: %d\n", PC, reg[17]);
			break;
		}
	}
	return 1;
#ifdef DEBUG_EXECUTION
	printf("SCALL, num:%x  executed!	\n", reg[17]);
#endif

}


